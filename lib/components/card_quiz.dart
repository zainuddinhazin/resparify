import 'package:flutter/material.dart';
import 'package:resparify5/theme.dart';

class CardQuizWidget extends StatelessWidget {
  final String name;
  final int points;
  final int count;

  const CardQuizWidget({
    required this.name,
    required this.points,
    required this.count,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color shadowColor;
    switch (count % 4) {
      case 1:
        backgroundColor = AppTheme.primary;
        shadowColor = AppTheme.dprimary;
        break;
      case 2:
        backgroundColor = AppTheme.secondary;
        shadowColor = AppTheme.dsecondary;
        break;
      case 3:
        backgroundColor = AppTheme.tertiary;
        shadowColor = AppTheme.dtertiary;
        break;
      default:
        backgroundColor = AppTheme.quaternary;
        shadowColor = AppTheme.dquaternary;
        break;
    }

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: Offset(0, 5),
            )
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: shadowColor,
                  shape: BoxShape.circle,
                ),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Text(
                    count.toString(),
                    style: AppTheme.headlineLarge.copyWith(
                      fontFamily: AppTheme.primaryFont,
                      color: AppTheme.info,
                    ),
                  ),
                ),
              ),
              Text(
                name,
                style: AppTheme.bodyLarge.copyWith(
                  fontFamily: AppTheme.primaryFont,
                  color: AppTheme.info,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                points.toString() + ' pts',
                style: AppTheme.bodyMedium.copyWith(
                  fontFamily: AppTheme.secondaryFont,
                  color: AppTheme.info,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
