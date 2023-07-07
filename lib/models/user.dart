class User {
  User(
      {required this.id,
      required this.username,
      this.pfp = 'assets/images/default_user.jpg'});
  int id;
  String username;
  String pfp;
}
