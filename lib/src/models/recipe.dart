import 'image.dart';
import 'ingredient.dart';
import 'instruction.dart';

class Recipe {
  const Recipe({
    this.url,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.image,
    required this.instructions,
  });

  final String? url;
  final String name;
  final String description;
  final List<Ingredient> ingredients;
  final List<RecipeInstruction> instructions;
  final RecipeImage image;

  /// Create the [Recipe] instance from a JSON object.
  ///
  /// optionally set `originUrl` to save the url of the [Recipe]
  factory Recipe.fromJson(
    Map<String, dynamic> json, {
    String? originUrl,
  }) {
    return Recipe(
      url: originUrl,
      name: json['name'],
      description: json['description'],
      ingredients: [
        for (final text in json['recipeIngredient']) Ingredient(text: text),
      ],
      instructions: [
        for (final instruction in json['recipeInstructions'])
          RecipeInstruction(
            text: instruction['text'],
          )
      ],
      image: RecipeImage.fromJson(json['image']),
    );
  }

  @override
  String toString() {
    return """Recipe:
      name: $name
      description: $description
      ingredients: ${ingredients.join(', ')}
      instructions: ${instructions.join(', ')}
      image: $image
    """;
  }
}
