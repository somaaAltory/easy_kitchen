class Recipe {
  final int id;
  final String name;
  final String images;
  Recipe(
      {required this.id,
        required this.name,
      required this.images,
     });

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
        id: json['id'] as int,
        name: json['title'] as String,
        images: json['image']as String);
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe {name: $name, image: $images}';
  }
}
