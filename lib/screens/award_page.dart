import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resparify5/theme.dart';
import '../utils/team.dart';

/// this page is used to display the places of the teams and to download a picture of the podium
class AwardPageWidget extends StatefulWidget {
  const AwardPageWidget({Key? key, required this.team}) : super(key: key);
  final Team team;

  @override
  State<AwardPageWidget> createState() => _AwardPageWidgetState();
}

class _AwardPageWidgetState extends State<AwardPageWidget>
    with SingleTickerProviderStateMixin {
  bool initial = true;
  final Duration _duration = const Duration(seconds: 5);

  /// this function is controlling the animation of the list
  /// it shows one team after another
  void _presentTeams() async {
    await Future.delayed(const Duration(seconds: 1));
    await Future.delayed(const Duration(seconds: 1));
    await Future.delayed(_duration);
  }

  @override
  initState() {
    super.initState();
    _presentTeams();
    _updateUserPoints();
  }

  Future<void> _updateUserPoints() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      DocumentSnapshot documentSnapshot = await documentReference.get();
      int currentPoints =
          (documentSnapshot.data() as Map<String, dynamic>)['points'] ?? 0;
      await documentReference
          .update({'points': currentPoints + widget.team.points});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Points updated successfully!',
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
      backgroundColor: AppTheme.primaryBackground,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 1,
                decoration: BoxDecoration(
                  color: AppTheme.tertiary,
                ),
                child: Column(
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/images/rocket.png',
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              SizedBox(height: 30),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Congratulations!',
                                    style: AppTheme.titleMedium.copyWith(
                                      fontFamily: AppTheme.secondaryFont,
                                      color: AppTheme.tertiary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    widget.team.name,
                                    textAlign: TextAlign.start,
                                    style: AppTheme.headlineLarge,
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    widget.team.points.toString(),
                                    textAlign: TextAlign.start,
                                    style: AppTheme.displaySmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
