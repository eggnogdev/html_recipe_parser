import 'dart:convert';

import 'package:html_recipe_parser/html_recipe_parser.dart';

void main() async {
  final parsed = await HTMLRecipeParser.parseUrl(
    "https://www.allrecipes.com/recipe/75135/swedish-sticky-chocolate-cake-kladdkaka/",
  );

  print(jsonEncode(parsed));
}
