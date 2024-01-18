import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../utils/massage.dart';
import '../utils/question.dart';
import 'dart:convert';
import 'chat.dart';

/// this singleton class is used to communicate with the OpenAI API
/// it holes the API Key and is used to generate images and questions
class OpenAIApi {
  static final OpenAIApi _singleton = OpenAIApi._internal();

  // the API key for the OpenAI API
  String? _aPIKey = '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';

  factory OpenAIApi() {
    return _singleton;
  }

  OpenAIApi._internal();

  get aPIKey => _aPIKey;

  /// sets the API key for the OpenAI API
  /// [key] the API key
  Future<void> setAPIKey(String key) async {
    _aPIKey = key;
    try {
      await _getText("say hi", 10); // test if the key is valid
    } catch (e) {
      _aPIKey = null;
      rethrow;
    }
    return;
  }

  /// explain way the answer is the only correct answer
  /// [question] the question to explain
  /// [context] the context for the localizations
  /// returns a string with the explanation for the answer and why it is the only correct answer
  Future<String> getExplanation(Question question, context) async {
    // instruct the chat bot with the localizations to get the correct language
    Chat getExplanationChat = Chat(
        'You are an assistant who explains quiz questions. You explain why an answer is correct and why other answers can be excluded. You also explain some background information.');
    // add the question to the chat
    getExplanationChat.addMessageUser(
        "Explain why ${question.getRealAnswer} the correct answer to the question ${question.questionText}. Explain why {getWrongAnswers} are not correct answers.");

    // get the explanation
    String explanation = await _getChatAnswer(getExplanationChat, 500);
    return explanation;
  }

  /// Generates a question from the OpenAI API
  /// [category] is the category of the question which can be any string
  /// [difficulty] is the difficulty of the question 1 to 5
  /// Returns a Question object
  /// throws an error if the question could not be generated or is in the wrong format
  Future<Question> getQuestion(
      String category, String difficulty, context) async {
    // instruct the chat bot with the localizations to get the correct language
    Chat getQuestionChat = Chat(
        'You are a quizmaster. You create questions for the selected category and a selected difficulty level. The difficulty is Easy, Medium or Hard. There is one correct answer and three unambiguously wrong answers.');
    // add example to the chat
    getQuestionChat.addMessageUser(
        'Create a question:\nCategory: Earth science\nDifficulty: Medium');
    getQuestionChat.addMessage(Massage(
        role: MassageRole.assistant,
        massage:
            'Question: What is the capital of Morocco?\nAnswer: Rabat\nWrongAnswers:\n1: Berlin\n2: Casablanca\n3: Marrakesch'));
    getQuestionChat.addMessageUser(
        'Create a question:\nCategory: Nature\nDifficulty: Hard');
    getQuestionChat.addMessage(Massage(
        role: MassageRole.assistant,
        massage:
            'Question: Which plant is a monocotyledon?\nAnswer: Corn\nWrongAnswers:\n1: Potato\n2: pasture\n3: Oak'));
    // add the category and difficulty to the chat
    getQuestionChat.addMessageUser(
        "Create a question:\nCategory: $category\nDifficulty: $difficulty");

    // get the question text in the correct language and format
    String questionAndAnswerText = "";
    try {
      questionAndAnswerText = await _getChatAnswer(getQuestionChat, 300);
      questionAndAnswerText = questionAndAnswerText.trim();
    } catch (e) {
      return Future.error(e.toString());
    }
    try {
      // try to parse the question
      // the expected format is:
      // Question: Question text
      // Answer: Correct answer
      // WrongAnswers:
      // 1: Wrong answer 1
      // 2: Wrong answer 2
      // 3: Wrong answer 3
      List<String> lines = questionAndAnswerText.split("\n");
      String questionText = lines[0].split("estion:")[1].trim();
      String answerText = lines[1].split("swer:")[1].trim();
      String wrongAnswerText1 = lines[3].split("1:")[1].trim();
      String wrongAnswerText2 = lines[4].split("2:")[1].trim();
      String wrongAnswerText3 = lines[5].split("3:")[1].trim();
      // shuffle the answers
      List<String> answers = [
        answerText,
        wrongAnswerText1,
        wrongAnswerText2,
        wrongAnswerText3
      ];
      answers.shuffle();
      // get the index of the correct answer + 1
      int correctAnswer = answers.indexOf(answerText) + 1;
      return Question(questionText, answers[0], answers[1], answers[2],
          answers[3], correctAnswer);
    } catch (e) {
      return Future.error(
          "The OpenAI API returned an invalid question. Please try again.");
    }
  }

  /// used to complete an existing image based on a prompt and a mask
  /// it uses the OpenAI API Image edits endpoint see https://platform.openai.com/docs/guides/images/usage
  /// [size] is the size of the image in pixels must be 256, 512, or 1024.
  /// [prompt] is the text that describes the entire image
  /// [image] is the image to be completed in base64 format PNG in RGBA format
  /// [mask] is the mask to be used in base64 format PNG in RGBA format the transparent pixels are the pixels that will be completed
  Future<Uint8List> _getCompletedImage(
      Uint8List image, Uint8List mask, String prompt, int size) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.openai.com/v1/images/edits'),
    )
      ..headers["Authorization"] = 'Bearer $_aPIKey'
      ..fields.addAll({
        'size': '${size}x$size',
        'n': '1', // just  get one image
        'prompt': prompt,
        'response_format': 'b64_json' // return the image as base64
      })
      ..files.addAll([
        http.MultipartFile.fromBytes(
          'image',
          image,
          filename: 'image.png',
        ),
        http.MultipartFile.fromBytes(
          'mask',
          mask,
          filename: 'mask.png',
        ),
      ]);
    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 201 || response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      var b64 = data["data"][0]["b64_json"];
      return const Base64Codec().decode(b64);
    } else {
      throw Exception(['http.post error', response.statusCode, response.body]);
    }
  }

  /// Generates the next answer for the [chat] from the OpenAI API Text completions endpoint see https://platform.openai.com/docs/guides/chat
  /// it uses the GPT-3.5-turbo model this makes this function 10 times cheaper than _getText with text-davinci-003
  /// [maxTokens] is the maximum number of tokens to generate
  /// [temperature] is the temperature of the model defaults to 0.4
  /// returns the answer as a String
  Future<String> _getChatAnswer(Chat chat, int maxTokens,
      [double? temperature]) async {
    http.Response response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: <String, String>{
        'Authorization': 'Bearer $_aPIKey',
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, dynamic>{
        'model': 'gpt-3.5-turbo',
        'messages': chat.massagesAsMap,
        'max_tokens': maxTokens,
        'temperature': temperature ?? 0.4,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      Map<String, dynamic> data = jsonDecode(body);
      String massageText = data["choices"][0]["message"]["content"];
      return massageText;
    } else {
      throw Exception(['http.post error', response.statusCode, response.body]);
    }
  }

  // this function is now only used for testing the Api key
  // _getChatAnswer is used for all other tasks instead
  /// Generates text from the OpenAI API Text completions endpoint see https://platform.openai.com/docs/guides/completion/
  /// using the given [prompt] limit of [maxTokens] controls the maximum length of the generated text
  /// [model] is the model to be used see https://platform.openai.com/docs/models/gpt-3 by default it is text-davinci-003
  /// the [temperature] controls the randomness of the generated text by default it is 0.4
  /// returns the generated text
  Future<String> _getText(String prompt, int maxTokens,
      [String? model, double? temperature]) async {
    http.Response response = await http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: <String, String>{
        'Authorization': 'Bearer $_aPIKey',
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, dynamic>{
        'model': model ?? 'gpt-3.5-turbo-instruct',
        'prompt': prompt,
        'max_tokens': maxTokens,
        'temperature': temperature ?? 0.4,
      }),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      Map<String, dynamic> data = jsonDecode(body);
      return data["choices"][0]["text"].trim();
    } else {
      throw Exception(['http.post error', response.statusCode, response.body]);
    }
  }
}
