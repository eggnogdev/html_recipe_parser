import 'models/recipe.dart';
import 'utils/data_fetch.dart';

export 'models/image.dart';
export 'models/ingredient.dart';
export 'models/instruction.dart';
export 'models/recipe.dart';
export 'utils/data_fetch.dart';

class RecipeParser {
  Future<Recipe> parseUrl(String url) async {
    final uri = Uri.parse(url);
    final document = await DataFetchService.getDocument(uri);
    final jsonLd = DataFetchService.getJsonLd(document);
    return Recipe.fromJson(jsonLd);
  }
}

void main() async {
  final parser = RecipeParser();
  final parsed = await parser.parseUrl(
    "https://www.allrecipes.com/recipe/75135/swedish-sticky-chocolate-cake-kladdkaka/",
  );
  print(parsed.toString());
}
