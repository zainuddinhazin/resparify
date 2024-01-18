import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resparify5/theme.dart';
import 'package:resparify5/const.dart';
import 'package:resparify5/components/card_argallery.dart';

class ARGalleryPageWidget extends StatefulWidget {
  const ARGalleryPageWidget({Key? key}) : super(key: key);

  @override
  _ARGalleryPageWidgetState createState() => _ARGalleryPageWidgetState();
}

class _ARGalleryPageWidgetState extends State<ARGalleryPageWidget> {
  GlobalKey catListKey = GlobalKey();

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      'AR Gallery',
                      style: AppTheme.displaySmall.copyWith(
                        fontFamily: AppTheme.primaryFont,
                        color: AppTheme.info,
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
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: arData.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.65,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return CardARGalleryWidget(
                            ar: arData[index],
                          );
                        },
                        primary: false,
                        scrollDirection: Axis.vertical,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
