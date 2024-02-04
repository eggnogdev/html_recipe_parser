import 'image.dart';
import 'ingredient.dart';
import 'instruction.dart';

class Recipe {
  const Recipe({
    this.uri,
    required this.name,
    required this.description,
    required this.ingredients,
    required this.image,
    required this.instructions,
  });

  final Uri? uri;
  final String name;
  final String description;
  final List<Ingredient> ingredients;
  final List<RecipeInstruction> instructions;
  final RecipeImage image;

  /// Create the [Recipe] instance from a JSON object.
  ///
  /// optionally set `originUri` to save the uri of the [Recipe]
  factory Recipe.fromJson(
    Map<String, dynamic> json, {
    Uri? originUri,
  }) {
    return Recipe(
      uri: originUri,
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
