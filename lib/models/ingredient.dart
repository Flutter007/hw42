class Ingredient {
  final String name;
  final String measure;

  Ingredient({required this.name, required this.measure});

  static List<Ingredient> fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredients = [];

    for (int i = 1; i <= 15; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];

      if (ingredient != null) {
        ingredients.add(Ingredient(name: ingredient, measure: measure ?? ''));
      }
    }
    if (ingredients.isEmpty) {
      ingredients.add(
        Ingredient(name: 'No ingredients', measure: 'No ingredients'),
      );
    }

    return ingredients;
  }
}
