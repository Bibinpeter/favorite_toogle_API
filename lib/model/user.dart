class User {
  final int id;
  final String name;
  bool isFavorite;

  User({required this.id, required this.name, this.isFavorite = false});
}
