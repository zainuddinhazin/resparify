/// This class is used to represent a team.
/// ech team has a name and a number of points
/// the image and the image description are loaded async
class Team {
  String name;
  int points;

  Team({required this.name, this.points = 0});

  /// adds points to the team
  void addPoints(int points) {
    this.points += points;
  }
}
