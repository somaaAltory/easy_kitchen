class Recipe {
  final int id;
  final String title;
  final String images;
  final List extendedIngredients;
  final List analyzedInstructions;
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
        required this.analyzedInstructions,
        required this.isVegetarian,
        required this.isVegan,
        required this.isGlutenFree,
        required this.isDairyFree,
        required this.isCheap,
        required this.duration,
      });

  factory Recipe.fromJson(dynamic data) {
    return Recipe(
        id: data['id'] as int,
        title: data['title'] as String,
        images: data['image']as String,
        extendedIngredients: data['extendedIngredients'] as List,
        analyzedInstructions: data['analyzedInstructions'] as List,
        //analyzedInstructions[0].steps
        duration: data['readyInMinutes'] as int,
        isVegan: data['vegan'] as bool,
        isVegetarian: data['vegetarian']as bool,
        isDairyFree: data['dairyFree']as bool,
        isCheap: data['cheap'] as bool,
        isGlutenFree: data['glutenFree'] as bool
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
