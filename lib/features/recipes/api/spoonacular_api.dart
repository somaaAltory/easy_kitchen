/// Uri builder class for the OpenWeatherMap API
class SpoonaCularAPI {
  SpoonaCularAPI();
   static const String apiKey = "b13abb543b844c47b376b12b186fdd6a";
  // static const String apiKey = "b5f902c80b7a4f4e9ced7fd3ca8224cc";
  // 'https://api.spoonacular.com/recipes/${id}/information?apiKey=b13abb543b844c47b376b12b186fdd6a'
  static const String _apiBaseUrl = "api.spoonacular.com";
  static const String _apiPath = "/recipes/";

  Uri searchRecipes(int recipesNumber) => _buildUri(
        endpoint: "complexSearch",
        parametersBuilder: () => recipeQueryParameters(recipesNumber),
      );
  Uri recipesDetails(int id) => _buildUri(
        endpoint: "$id/information",
        parametersBuilder: () => recipesDetailsQueryParameters(),
      );

  Uri getRecipeByIngredients(int recipesNumber, String ingredients) {
      return _buildUri(
          endpoint: "findByIngredients",
          parametersBuilder: () =>
              recipeByIngredientsQueryParameters(recipesNumber, ingredients));}


  Uri _buildUri({
    required String endpoint,
    required Map<String, dynamic> Function() parametersBuilder,
  }) {
    return Uri(
      scheme: "https",
      host: _apiBaseUrl,
      path: "$_apiPath$endpoint",
      queryParameters: parametersBuilder(),
    );
  }

  // https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples,+flour,
  // +sugar&number=2&apiKey=b13abb543b844c47b376b12b186fdd6a
  Map<String, dynamic> recipeByIngredientsQueryParameters(
          int recipesNumber, String ingredients) =>
      //number
      {
        "number": recipesNumber.toString(),
        "ingredients": ingredients,
        "apiKey": apiKey,
      };

  Map<String, dynamic> recipeQueryParameters(int recipesNumber) => {
        "number": recipesNumber,
        "apiKey": apiKey,
      };

  recipesDetailsQueryParameters() => {
        "apiKey": apiKey,
      };
}
