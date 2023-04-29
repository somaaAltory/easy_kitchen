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

  factory RecipeListItem.fromJson(dynamic data) {
    return RecipeListItem(
      id: data['id'] as int,
      title: data['title'] as String,
      image: data['image'] as String,
      usedIngredientCount: data['usedIngredientCount'] as int,
      missedIngredientCount: data['missedIngredientCount'] as int,
    );
  }
  static List<RecipeListItem> recipeListFromJson(dynamic data) {
    print("this is the data $data");
    List<RecipeListItem> list=[] ;
     data.map(
      (recipeItem) {
        print("this is the item $recipeItem");
        list.add( RecipeListItem.fromJson(data));

      }
       );
     print("this is the list $list");
     return list;
  }
}
