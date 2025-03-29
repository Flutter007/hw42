import 'package:flutter/material.dart';
import 'package:hw42/helpers/request.dart';

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
  String? errorTxt;
  bool isFetching = false;

  Future<void> searchCocktail() async {
    setState(() {
      isFetching = true;
    });
    try {
      final cocktail = cocktailController.text;
      final Map<String, dynamic> info = await request(
        'https://www.thecocktaildb.com/api/json/v1/1/search.php?s=$cocktail',
      );
      if (info['drinks'] != null) {
        setState(() {
          cocktails =
              (info['drinks'] as List<dynamic>)
                  .map((e) => Cocktail.fromJson(e))
                  .toList();
          isFetching = false;
        });
      } else {
        setState(() {
          cocktails = [];
          isFetching = false;
        });
      }
    } catch (e) {
      setState(() {
        errorTxt = 'Something went wrong,we are working on it!';
        isFetching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (isFetching) {
      content = Center(child: CircularProgressIndicator());
    } else if (errorTxt != null) {
      content = Center(child: Text(errorTxt!));
    } else {
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: cocktailController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text('Enter cocktail name'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            onPressed: searchCocktail,
            icon: Icon(Icons.search_rounded, size: 30),
          ),
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
                  (context, index) => CocktailCard(cocktail: cocktails[index]),
            ),
          ),
        ],
      );
    }
    return content;
  }
}
