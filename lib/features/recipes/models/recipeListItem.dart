class RecipeListItem {
  final int id;
  final String title;
  final String image;
  final int missedIngredientCount;
  final int usedIngredientCount;

  RecipeListItem(
      {required this.id,
      required this.title,
      required this.image,
      required this.missedIngredientCount,
      required this.usedIngredientCount});

  factory RecipeListItem.fromJson(Map<String, Object> data) {
    return RecipeListItem(
      id: data['id'] as int,
      title: data['title'] as String,
      image: data['image'] as String,
      usedIngredientCount: data['usedIngredientCount'] as int,
      missedIngredientCount: data['missedIngredientCount'] as int,
    );
  }
  static List<RecipeListItem> recipeListFromJson(List data) {
    // print("this is the data $data");
    List<RecipeListItem> list = [];
    for (var element in data) {
      list.add(createRecipeListItem(element));
    }
    return list;
  }

  static RecipeListItem createRecipeListItem(dynamic recipeItem) {
    return RecipeListItem(
        id: recipeItem["id"],
        title: recipeItem["title"],
        image: recipeItem["image"],
        missedIngredientCount: recipeItem["missedIngredientCount"],
        usedIngredientCount: recipeItem["usedIngredientCount"]);
  }
}
