import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:resparify5/theme.dart';

class ARPageWidget extends StatefulWidget {
  const ARPageWidget({Key? key}) : super(key: key);

  @override
  _ARPageWidgetState createState() => _ARPageWidgetState();
}

class _ARPageWidgetState extends State<ARPageWidget> {
  GlobalKey catListKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBackground,
        automaticallyImplyLeading: false,
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
                  FontAwesomeIcons.angleLeft,
                  color: AppTheme.info,
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
        child: const ModelViewer(
          backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
          src: 'assets/3d_model/heart_lungs_dis.glb',
          alt: 'title',
          ar: true,
          autoRotate: true,
        ),
      ),
    );
  }
}
