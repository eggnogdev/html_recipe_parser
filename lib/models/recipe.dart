import 'package:html_recipe_parser/models/image.dart';
import 'package:html_recipe_parser/models/ingredient.dart';
import 'package:html_recipe_parser/models/instruction.dart';

class Recipe {
  Recipe({
    required this.name,
    required this.description,
    required this.ingredients,
    required this.image,
    required this.instructions,
  });

  final String name;
  final String description;
  final List<Ingredient> ingredients;
  final List<RecipeInstruction> instructions;
  final RecipeImage image;

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
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
