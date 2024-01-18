import 'package:flutter/material.dart';
import 'package:resparify5/services/auth_methods.dart';
import 'package:resparify5/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:validatorless/validatorless.dart';
import 'package:resparify5/screens/home_page.dart';
import 'package:resparify5/theme.dart';

class LoginPageWidget extends StatefulWidget {
  static final String id = 'login_screen';

  @override
  _LoginPageWidgetState createState() => new _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  final TextEditingController _emailIdController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailIdController.dispose();
    _passwordController.dispose();
  }

  void _logInUser() async {
    if (_emailIdController.text.isEmpty) {
      _showEmptyDialog("Email address");
    } else if (_passwordController.text.isEmpty) {
      _showEmptyDialog("Password");
    }
    setState(() {
      _isLoading = true;
    });
    String result = await AuthMethods().logInUser(
      email: _emailIdController.text,
      password: _passwordController.text,
    );
    if (result == 'success') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageWidget()),
      );
    } else {
      showSnackBar(result, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondary,
      appBar: AppBar(
        backgroundColor: AppTheme.secondary,
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
                    color: AppTheme.dsecondary,
                    offset: Offset(0, 5),
                  )
                ],
                shape: BoxShape.circle,
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: FaIcon(
                  FontAwesomeIcons.angleLeft,
                  color: AppTheme.dsecondary,
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
                              color: AppTheme.dsecondary,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Get to My Account',
                                    textAlign: TextAlign.start,
                                    style: AppTheme.headlineLarge,
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'Access your wonderful things by logging in below.',
                                    style: AppTheme.titleMedium.copyWith(
                                      fontFamily: AppTheme.secondaryFont,
                                      color: AppTheme.secondary,
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
                                      color: AppTheme.dsecondary,
                                      offset: Offset(0, 5),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextFormField(
                                  controller: _emailIdController,
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
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.dsecondary,
                                      offset: Offset(0, 5),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextFormField(
                                  controller: _passwordController,
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
                                        'The field is obligatory')
                                  ]),
                                ),
                              ),
                              SizedBox(height: 30),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.dsecondary,
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
                                          backgroundColor: AppTheme.secondary,
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
                                        onPressed: () => _logInUser(),
                                        child: Text(
                                          'Log In',
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

  _showEmptyDialog(String title) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        content: Text("$title can't be empty"),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"))
        ],
      ),
    );
  }
}
