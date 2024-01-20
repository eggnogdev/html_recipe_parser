# html_recipe_parser.dart

An HTML recipe parser that supports websites that adhere to schema.org's Recipe schema.

View this project on [Codeberg](https://codeberg.org/eggnog/html_recipe_parser) (Main) <br>
View this projcet on [GitHub](https://github.com/eggnogdev/html_recipe_parser) (Mirror)

## Releases

Releases are available on [Codeberg](https://codeberg.org/eggnog/html_recipe_parser/releases)

## How to use

Just create an instance of the `RecipeParser` class and begin parsing! The `RecipeParser.parseUrl()` method will return a `Recipe` object so you can easily access the information of the recipe.

```dart
final parser = RecipeParser();
final recipe = await parser.parseUrl(
  'https://www.allrecipes.com/recipe/75135/swedish-sticky-chocolate-cake-kladdkaka/',
);
print(recipe);
```