import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:resparify5/theme.dart';

class CardLearnWidget extends StatefulWidget {
  final Map learn;

  const CardLearnWidget({Key? key, required this.learn}) : super(key: key);

  @override
  _CardLearnWidgetState createState() => _CardLearnWidgetState();
}

class _CardLearnWidgetState extends State<CardLearnWidget> {
  late Map learn;

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    learn = widget.learn;
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(learn['video'] as String)!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 7),
      child: InkWell(
        child: Container(
          width: 180,
          decoration: BoxDecoration(
            color: learn['color'] as Color,
            boxShadow: [
              BoxShadow(
                color: learn['shadow'] as Color,
                offset: Offset(0, 5),
              )
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      learn['image'] as String,
                      width: 120,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      learn['title'] as String,
                      style: AppTheme.bodyLarge.copyWith(
                        fontFamily: AppTheme.primaryFont,
                        color: AppTheme.info,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      learn['text'] as String,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTheme.bodyMedium.copyWith(
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                backgroundColor: AppTheme.primaryBackground,
                appBar: AppBar(
                  backgroundColor: learn['color'] as Color,
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
                              color: learn['shadow'] as Color,
                              offset: Offset(0, 5),
                            )
                          ],
                          shape: BoxShape.circle,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: FaIcon(
                            FontAwesomeIcons.angleLeft,
                            color: learn['shadow'] as Color,
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
                          decoration: BoxDecoration(
                            color: learn['color'] as Color,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(30),
                                child: Container(
                                  width: 180,
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryBackground,
                                    boxShadow: [
                                      BoxShadow(
                                        color: learn['shadow'] as Color,
                                        offset: Offset(0, 5),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(15),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.asset(
                                              learn['image'] as String,
                                              width: 120,
                                              height: 120,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height * 1,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryBackground,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(0),
                                    bottomRight: Radius.circular(0),
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(30),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        learn['title'] as String,
                                        textAlign: TextAlign.center,
                                        style: AppTheme.headlineLarge,
                                      ),
                                      SizedBox(height: 30),
                                      Text(
                                        learn['text'] as String,
                                        style: AppTheme.bodyLarge,
                                      ),
                                      SizedBox(height: 30),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(0),
                                        child: Image.network(
                                          learn['image2'] as String,
                                          width: double.infinity,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      YoutubePlayer(
                                        controller: _controller,
                                      ),
                                    ],
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
              ),
            ),
          );
        },
      ),
    );
  }
}
