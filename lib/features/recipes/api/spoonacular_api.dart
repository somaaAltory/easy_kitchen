/// Uri builder class for the OpenWeatherMap API
class SpoonaCularAPI {
  SpoonaCularAPI();
  static const String apiKey = "b13abb543b844c47b376b12b186fdd6a";
  // 'https://api.spoonacular.com/recipes/${id}/information?apiKey=b13abb543b844c47b376b12b186fdd6a'
  static const String _apiBaseUrl = "api.spoonacular.com";
  static const String _apiPath = "/recipes/";

  Uri searchRecipes(String recipesNumber) => _buildUri(
        endpoint: "complexSearch",
        parametersBuilder: () => recipeQueryParameters(recipesNumber),
      );
  Uri recipesDetails(String id) => _buildUri(
        endpoint: "$id/information",
        parametersBuilder: () => recipesDetailsQueryParameters(),
      );

  Uri getRecipeByIngredients(
          String recipesNumber, String ingredients) =>
      _buildUri(
          endpoint: "findByIngredients",
          parametersBuilder: () =>
              recipeByIngredientsQueryParameters(recipesNumber, ingredients));

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

  Map<String, dynamic> recipeByIngredientsQueryParameters(
          String recipesNumber, String ingredients) =>
      {
        "number": recipesNumber,
        "apiKey": apiKey,
        "ingredients": ingredients,
      };

  Map<String, dynamic> recipeQueryParameters(String recipesNumber) => {
        "number": recipesNumber,
        "apiKey": apiKey,
      };

  recipesDetailsQueryParameters() => {
        "apiKey": apiKey,
      };
}
