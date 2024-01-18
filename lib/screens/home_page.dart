import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resparify5/theme.dart';
import 'package:resparify5/const.dart';
import 'package:resparify5/components/card_learn.dart';
import 'package:resparify5/screens/welcome_page.dart';
import 'package:resparify5/screens/profile_page.dart';
import 'package:resparify5/screens/argallery_page.dart';
import 'package:resparify5/screens/quizmain_page.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
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

  void _signOut() {
    FirebaseAuth.instance.signOut();
    runApp(new MaterialApp(
      home: new WelcomePageWidget(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBackground,
        automaticallyImplyLeading: false,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/logo_square.png',
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          InkWell(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.dprimary,
                    offset: Offset(0, 5),
                  )
                ],
                shape: BoxShape.circle,
              ),
              child: Align(
                alignment: AlignmentDirectional(0, 0),
                child: FaIcon(
                  FontAwesomeIcons.user,
                  color: AppTheme.info,
                  size: 15,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfilePageWidget()),
              );
            },
          ),
          SizedBox(width: 15),
          InkWell(
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppTheme.tertiary,
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
                  FontAwesomeIcons.signOutAlt,
                  color: AppTheme.info,
                  size: 15,
                ),
              ),
            ),
            onTap: () => _signOut(),
          ),
          SizedBox(width: 15),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 30),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.dprimary,
                        offset: Offset(0, 5),
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/images/greet.png',
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Hi Zainuddin!',
                              style: AppTheme.titleLarge.copyWith(
                                fontFamily: AppTheme.primaryFont,
                                color: AppTheme.info,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Ready to Learn?',
                              style: AppTheme.bodyLarge.copyWith(
                                fontFamily: AppTheme.secondaryFont,
                                color: AppTheme.info,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.tertiary,
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
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Explore AR Gallery',
                                    style: AppTheme.displaySmall.copyWith(
                                        fontFamily: AppTheme.primaryFont,
                                        color: AppTheme.info,
                                        height: 1),
                                  ),
                                  SizedBox(height: 15),
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
                                        backgroundColor:
                                            AppTheme.primaryBackground,
                                        foregroundColor: AppTheme.tertiary,
                                        elevation: 0,
                                        minimumSize: const Size(120, 40),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ARGalleryPageWidget()),
                                        );
                                      },
                                      child: Text(
                                        'Try It',
                                        style: AppTheme.titleSmall.copyWith(
                                          fontFamily: AppTheme.secondaryFont,
                                          color: AppTheme.tertiary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(12),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.asset(
                                'assets/images/ar_card.png',
                                height: 150,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Learn About Respiratory System',
                      style: AppTheme.titleMedium.copyWith(
                        fontFamily: AppTheme.secondaryFont,
                        color: AppTheme.primaryText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      height: 270,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: learnData.length,
                        primary: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return CardLearnWidget(
                            learn: learnData[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.secondary,
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
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Let\'s Play Together',
                                    style: AppTheme.displaySmall.copyWith(
                                        fontFamily: AppTheme.primaryFont,
                                        color: AppTheme.info,
                                        height: 1),
                                  ),
                                  SizedBox(height: 15),
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
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            AppTheme.primaryBackground,
                                        foregroundColor: AppTheme.tertiary,
                                        elevation: 0,
                                        minimumSize: const Size(120, 40),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const QuizMainPageWidget()),
                                        );
                                      },
                                      child: Text(
                                        'Play Now',
                                        style: AppTheme.titleSmall.copyWith(
                                          fontFamily: AppTheme.secondaryFont,
                                          color: AppTheme.secondary,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(12),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.asset(
                                'assets/images/quiz_card.png',
                                height: 150,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
