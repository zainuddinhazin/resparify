import 'package:flutter/material.dart';
import 'package:resparify5/services/auth_methods.dart';
import 'package:resparify5/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:validatorless/validatorless.dart';
import 'package:resparify5/screens/home_page.dart';
import 'package:resparify5/theme.dart';

class SignupPageWidget extends StatefulWidget {
  // const SignupPageWidget({Key? key}) : super(key: key);
  static final String id = 'signup_screen';

  @override
  _SignupPageWidgetState createState() => _SignupPageWidgetState();
}

class _SignupPageWidgetState extends State<SignupPageWidget> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _password;
  bool _isLoading = false;

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      // Logging in the user w/ Firebase
      String result = await AuthMethods().signUpUser(
          name: _name, email: _email, password: _password, points: 0);
      if (result != 'success') {
        showSnackBar(result, context);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePageWidget()),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.tertiary,
      appBar: AppBar(
        backgroundColor: AppTheme.tertiary,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.primaryBackground,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.dtertiary,
                    offset: Offset(0, 5),
                  )
                ],
                shape: BoxShape.circle,
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: FaIcon(
                  FontAwesomeIcons.angleLeft,
                  color: AppTheme.dtertiary,
                  size: 15,
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(width: 15),
        ],
        centerTitle: false,
        elevation: 0,
      ),
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
                              color: AppTheme.dtertiary,
                              offset: Offset(0, 5),
                            )
                          ],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome to RespARify!',
                                      textAlign: TextAlign.start,
                                      style: AppTheme.headlineLarge,
                                    ),
                                    SizedBox(height: 15),
                                    Text(
                                      'Enjoy future of education with RespARify.',
                                      style: AppTheme.titleMedium.copyWith(
                                        fontFamily: AppTheme.secondaryFont,
                                        color: AppTheme.tertiary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.dtertiary,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Display Name',
                                      labelStyle: AppTheme.labelLarge,
                                      errorStyle: AppTheme.labelMedium.copyWith(
                                        fontFamily: AppTheme.secondaryFont,
                                        color: AppTheme.error,
                                        height: 1.5,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.primary,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.error,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.error,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      filled: true,
                                      fillColor: AppTheme.primaryBackground,
                                      contentPadding: EdgeInsets.all(15),
                                    ),
                                    style: AppTheme.bodyLarge.copyWith(
                                      fontFamily: AppTheme.secondaryFont,
                                      height: 1.5,
                                    ),
                                    cursorColor: AppTheme.primary,
                                    validator: Validatorless.multiple([
                                      Validatorless.required(
                                          'The field is obligatory')
                                    ]),
                                    onSaved: (input) => _name = input!,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.dtertiary,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextFormField(
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Email Address',
                                      labelStyle: AppTheme.labelLarge,
                                      errorStyle: AppTheme.labelMedium.copyWith(
                                        fontFamily: AppTheme.secondaryFont,
                                        color: AppTheme.error,
                                        height: 1.5,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.primary,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.error,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.error,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      filled: true,
                                      fillColor: AppTheme.primaryBackground,
                                      contentPadding: EdgeInsets.all(15),
                                    ),
                                    style: AppTheme.bodyLarge.copyWith(
                                      fontFamily: AppTheme.secondaryFont,
                                      height: 1.5,
                                    ),
                                    cursorColor: AppTheme.primary,
                                    validator: Validatorless.multiple([
                                      Validatorless.email(
                                          'The field must be an email'),
                                      Validatorless.required(
                                          'The field is obligatory')
                                    ]),
                                    onSaved: (input) => _email = input!,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.dtertiary,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: TextFormField(
                                    textCapitalization: TextCapitalization.none,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: AppTheme.labelLarge,
                                      errorStyle: AppTheme.labelMedium.copyWith(
                                        fontFamily: AppTheme.secondaryFont,
                                        color: AppTheme.error,
                                        height: 1.5,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.primary,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.error,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: AppTheme.error,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      filled: true,
                                      fillColor: AppTheme.primaryBackground,
                                      contentPadding: EdgeInsets.all(15),
                                    ),
                                    style: AppTheme.bodyLarge.copyWith(
                                      fontFamily: AppTheme.secondaryFont,
                                      height: 1.5,
                                    ),
                                    cursorColor: AppTheme.primary,
                                    validator: Validatorless.multiple([
                                      Validatorless.required(
                                          'The field is obligatory'),
                                      Validatorless.min(
                                          6, 'Must be at least 6 characters')
                                    ]),
                                    onSaved: (input) => _password = input!,
                                  ),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.dtertiary,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  width: 120,
                                  height: 45,
                                  child: _isLoading
                                      ? Center(
                                          child: SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: AppTheme.info,
                                            ),
                                          ),
                                        )
                                      : ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppTheme.tertiary,
                                            foregroundColor: AppTheme.info,
                                            elevation: 0,
                                            minimumSize: const Size(120, 40),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(30)),
                                            ),
                                          ),
                                          onPressed: () => _signUp(),
                                          child: Text(
                                            'Sign Up',
                                            style: AppTheme.titleSmall.copyWith(
                                              fontFamily:
                                                  AppTheme.secondaryFont,
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
