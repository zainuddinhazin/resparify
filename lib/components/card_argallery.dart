import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:resparify5/theme.dart';

class CardARGalleryWidget extends StatelessWidget {
  final Map ar;

  const CardARGalleryWidget({super.key, required this.ar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 7),
      child: InkWell(
        child: Container(
          width: 180,
          decoration: BoxDecoration(
            color: ar['color'] as Color,
            boxShadow: [
              BoxShadow(
                color: ar['shadow'] as Color,
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
                      ar['image'] as String,
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
                      ar['title'] as String,
                      textAlign: TextAlign.center,
                      style: AppTheme.bodyLarge.copyWith(
                        fontFamily: AppTheme.primaryFont,
                        color: AppTheme.info,
                        fontWeight: FontWeight.w600,
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
                  child: ModelViewer(
                    backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
                    src: ar['arModel'] as String,
                    alt: ar['title'] as String,
                    ar: true,
                    autoRotate: true,
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
