class Genre {
  final int id;
  final String name;

  Genre.fromjason(dynamic json)
      : this.id = json['id'],
        this.name = json['name'];
}
