# html_recipe_parser.dart

An HTML recipe parser that supports websites that adhere to schema.org's Recipe schema.

View this projcet on [GitHub](https://github.com/eggnogdev/html_recipe_parser) (Main) <br>
View this project on [Codeberg](https://codeberg.org/eggnog/html_recipe_parser) (Mirror)

## Releases

Releases are available on [GitHub](https://github.com/eggnogdev/html_recipe_parser/releases)

## Installation

This package is currently only available through git, so write the following into your pubspec.yaml.

```yaml
dependencies:
  html_recipe_parser:
    git:
      url: https://github.com/eggnogdev/html_recipe_parser.git
      ref: 0.1.0 # the tag, commit, or branch that you want


```

## How to use

Just create an instance of the `RecipeParser` class and begin parsing! The `RecipeParser.parseUrl()` method will return a `Recipe` object so you can easily access the information of the recipe.

```dart
final parser = RecipeParser();
final recipe = await parser.parseUrl(
  'https://www.allrecipes.com/recipe/75135/swedish-sticky-chocolate-cake-kladdkaka/',
);
print(recipe);
```

## Support this project

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/P5P5GQJKV)
