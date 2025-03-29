import 'package:flutter/material.dart';
import 'package:hw42/screens/find_cocktail_screen.dart';

class CocktailsApp extends StatelessWidget {
  const CocktailsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu of cocktails')),
      body: FindCocktailScreen(),
    );
  }
}
