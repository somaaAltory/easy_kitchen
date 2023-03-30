class Recipe {
  final int id;
  final String title;
  final String images;
  final List extendedIngredients;
  final bool isVegetarian;
  final bool isVegan;
  final bool isGlutenFree;
  final bool isDairyFree;
  final bool isCheap;
  final int duration;

  Recipe(
      {required this.id,
        required this.title,
       required this.images,
        required this.extendedIngredients,
         required this.isVegetarian,
        required this.isVegan,
        required this.isGlutenFree,
        required this.isDairyFree,
        required this.isCheap,
        required this.duration,
     });

  factory Recipe.fromJson(dynamic json) {
    return Recipe(
        id: json['id'] as int,
        title: json['title'] as String,
        images: json['image']as String,
        extendedIngredients: json['extendedIngredients'] as List,
        duration: json['readyInMinutes'] as int,
        isVegan: json['vegan'] as bool,
        isVegetarian: json['vegetarian']as bool,
        isDairyFree: json['dairyFree']as bool,
        isCheap: json['cheap'] as bool,
         isGlutenFree: json['glutenFree'] as bool
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
