import 'package:flutter/material.dart';
import '../utils/team.dart';
import '../theme.dart';

/// A card with the team name and the points of the team
/// active is a bool to show if the team is the active team or not active team will be bigger
/// [team] the team to display
/// [active] if the team is active or not the active team will be bigger
class TeamCard extends StatelessWidget {
  const TeamCard({Key? key, required this.team}) : super(key: key);
  final Team team;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          team.name,
          textAlign: TextAlign.start,
          style: AppTheme.headlineLarge,
        ),
        SizedBox(height: 15),
        Text(
          team.points.toString(),
          textAlign: TextAlign.start,
          style: AppTheme.displaySmall,
        ),
      ],
    );
  }
}
