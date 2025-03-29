class Cocktail {
  final String id;
  final String name;
  final String image;

  Cocktail({required this.id, required this.name, required this.image});
  factory Cocktail.fromJson(Map<String, dynamic> json) {
    return Cocktail(
      id: json['idDrink'],
      name: json['strDrink'],
      image: json['strDrinkThumb'],
    );
  }
}
