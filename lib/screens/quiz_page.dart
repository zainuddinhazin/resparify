import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/team.dart';
import '../utils/open_ai_api.dart';
import '../utils/question.dart';
import '../components/card_team.dart';
import 'question_page.dart';
import 'award_page.dart';
import '../theme.dart';

/// This is the page where the team are displayed with their points and the round
/// The active team can select a category and the difficulty and then the question page is opened
class QuizPageWidget extends StatefulWidget {
  QuizPageWidget({Key? key}) : super(key: key);
  final Team teams = Team(name: "");

  @override
  State<QuizPageWidget> createState() => _QuizPageWidgetState();
}

class _QuizPageWidgetState extends State<QuizPageWidget> {
  final TextEditingController _displayNameController = TextEditingController();
  String? _displayName;

  @override
  void initState() {
    super.initState();
    _getUserDisplayName();
  }

  Future<void> _getUserDisplayName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        _displayName = snapshot['name'];
        _displayNameController.text = _displayName!;
        widget.teams.name = _displayName!;
      });
    }
  }

  int round = 1; // the current round

  bool updateRound = false; // if the round is updated in the UI

  /// Increases the round by one and updates the UI
  void increaseRound() {
    setState(() {
      updateRound = true;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        round++;
        updateRound = false;
      });
    });
  }

  /// This function is called when the active team selects a category and a difficulty
  /// It gets a question from the OpenAI API and then opens the question page
  /// If the answer was correct the points are added to the team
  void selectCategory(Team team) async {
    Future<Question> question =
        OpenAIApi().getQuestion('human respiratory system', 'Hard', context);

    // wait for the question page to return if the answer was correct
    var correct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionPageWidget(question: question),
      ),
    );

    // if the answer was correct add the points to the team
    if (correct == true) {
      setState(() {
        team.points += 10;
      });
    }

    // redirect to the AwardPage after round 5
    if (round == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AwardPageWidget(team: widget.teams as Team)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: SafeArea(
        top: true,
        child: Align(
          alignment: AlignmentDirectional(0, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryBackground,
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.dprimary,
                              offset: Offset(0, 5),
                            )
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Round $round',
                                    style: AppTheme.titleMedium.copyWith(
                                      fontFamily: AppTheme.secondaryFont,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  TeamCard(team: widget.teams as Team)
                                ],
                              ),
                              SizedBox(height: 30),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.dprimary,
                                      offset: Offset(0, 5),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primary,
                                    foregroundColor: AppTheme.info,
                                    elevation: 0,
                                    minimumSize: const Size(120, 40),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                  ),
                                  onPressed: () {
                                    selectCategory(widget.teams as Team);
                                  },
                                  child: Text(
                                    'Continue',
                                    style: AppTheme.titleSmall.copyWith(
                                      fontFamily: AppTheme.secondaryFont,
                                      color: AppTheme.info,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
