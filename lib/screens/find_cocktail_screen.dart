import 'package:flutter/material.dart';
import 'package:hw42/helpers/request.dart';
import 'package:hw42/screens/recipe_screen.dart';
import '../models/cocktail.dart';
import '../widgets/cocktail_card.dart';

class FindCocktailScreen extends StatefulWidget {
  const FindCocktailScreen({super.key});

  @override
  State<FindCocktailScreen> createState() => _FinState();
}

final cocktailController = TextEditingController();

class _FinState extends State<FindCocktailScreen> {
  List<Cocktail> cocktails = [];
  bool hasSearched = false;
  String? errorTxt;
  bool isFetching = false;
  void showCocktail(BuildContext context, String cocktailId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                RecipeScreen(cocktailId: cocktailId, cocktails: cocktails),
      ),
    );
  }

  Future<void> searchCocktail() async {
    setState(() {
      isFetching = true;
      hasSearched = true;
    });
    try {
      final cocktail = cocktailController.text.trim();
      final Map<String, dynamic> info = await request(
        'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$cocktail',
      );
      if (info['drinks'] != null && cocktail.isNotEmpty) {
        setState(() {
          cocktails =
              (info['drinks'] as List<dynamic>)
                  .map((e) => Cocktail.fromJson(e))
                  .toList();
          isFetching = false;
          hasSearched = false;
        });
      } else {
        setState(() {
          cocktails = [];
          isFetching = false;
        });
      }
    } catch (e) {
      setState(() {
        errorTxt = e.toString();
        isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget content;
    if (isFetching) {
      content = Center(child: CircularProgressIndicator());
    } else if (errorTxt != null) {
      content = Center(child: Text(errorTxt!));
    } else {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: TextField(
                    controller: cocktailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      label: Text('Enter cocktail name'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: searchCocktail,
                icon: Icon(Icons.search_rounded, size: 35),
              ),
            ],
          ),
          if (cocktails.isNotEmpty)
            Expanded(
              child: GridView.builder(
                itemCount: cocktails.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 250,
                ),
                itemBuilder:
                    (context, index) => CocktailCard(
                      cocktail: cocktails[index],
                      onTap: () => showCocktail(context, cocktails[index].id),
                    ),
              ),
            )
          else if (hasSearched)
            Text('No cocktails found', style: theme.textTheme.titleLarge),
        ],
      );
    }
    return content;
  }
}
