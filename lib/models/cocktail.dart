import 'package:hw42/models/ingredient.dart';

class Cocktail {
  final String id;
  final String name;
  final String image;
  final String instructions;
  final List<Ingredient> ingredients;
  Cocktail({
    required this.ingredients,
    required this.id,
    required this.name,
    required this.image,
    required this.instructions,
  });
  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      id: json['idDrink'],
      instructions: json['strInstructions'],
      name: json['strDrink'],
      image: json['strDrinkThumb'],
      ingredients: Ingredient.fromJson(json),
    );
  }
}
