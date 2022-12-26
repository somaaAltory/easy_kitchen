class Recipe {
  final int id;
  final String title;
  final String images;
  final List extendedIngredients;
  Recipe(
      {required this.id,
        required this.title,
      required this.images,
        required this.extendedIngredients
     });

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
        id: json['id'] as int,
        title: json['title'] as String,
        images: json['image']as String,
        extendedIngredients: json['extendedIngredients'] as List,
    );
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe {name: $title, image: $images}';
  }
}
