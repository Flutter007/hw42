import 'package:flutter/material.dart';
import '../models/cocktail.dart';

class RecipeScreen extends StatefulWidget {
  final String cocktailId;
  final List<Cocktail> cocktails;
  const RecipeScreen({
    super.key,
    required this.cocktailId,
    required this.cocktails,
  });

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  late Cocktail cocktail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cocktail = widget.cocktails.firstWhere(
      (element) => element.id == widget.cocktailId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe for ${cocktail.name}', style: textTheme.titleLarge),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Text('List : ', style: textTheme.headlineSmall),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: cocktail.ingredients.length,
              itemBuilder:
                  (context, index) => ListTile(
                    title: Text(cocktail.ingredients[index].name),
                    subtitle: Text(cocktail.ingredients[index].measure),
                    leading: Image.network(
                      'https://www.thecocktaildb.com/images/ingredients/${cocktail.ingredients[index].name}-small.png',
                    ),
                  ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ListTile(
                title: Text('Instruction : ', style: textTheme.headlineSmall),
                subtitle: Text(
                  cocktail.instructions,
                  textAlign: TextAlign.justify,
                  style: textTheme.titleLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
