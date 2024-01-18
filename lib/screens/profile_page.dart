import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:validatorless/validatorless.dart';
import 'package:resparify5/theme.dart';

class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({Key? key}) : super(key: key);

  @override
  _ProfilePageWidgetState createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<ProfilePageWidget> {
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
      });
    }
  }

  Future<void> _updateUserDisplayName() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'name': _displayNameController.text});
      setState(() {
        _displayName = _displayNameController.text;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Display name updated successfully!',
            style: TextStyle(color: AppTheme.primaryBackground),
          ),
          backgroundColor: AppTheme.tertiary,
        ),
      );
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
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Edit Profile',
                                    textAlign: TextAlign.start,
                                    style: AppTheme.headlineLarge,
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'Adjust the content below to update your profile.',
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
                                  controller: _displayNameController,
                                  textCapitalization: TextCapitalization.words,
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
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.tertiary,
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
                                  onPressed: _updateUserDisplayName,
                                  child: Text(
                                    'Save',
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
