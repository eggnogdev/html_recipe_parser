import 'package:html_recipe_parser/html_recipe_parser.dart';

void main() async {
  final parser = RecipeParser();
  // final recipe = await parser.parseUrl(
  //   'https://cookieandkate.com/roasted-potatoes-recipe/',
  // );
  final recipe = await parser.parseUrl(
    'https://www.allrecipes.com/recipe/75135/swedish-sticky-chocolate-cake-kladdkaka/',
  );
  print(recipe);
}
