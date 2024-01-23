import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';

class DataFetchService {
  static Map<String, dynamic>? getJson(Document dom) {
    final scripts = dom.querySelectorAll(
      'script[type="application/ld+json"]',
    );

    for (final script in scripts) {
      final jsonLd = jsonDecode(script.innerHtml);

      if (jsonLd is List) {
        for (final json in jsonLd) {
          final found = _findRecipeJsonLd(json);
          if (found != null) return found;
        }
      } else {
        final found = _findRecipeJsonLd(jsonLd);
        if (found != null) return found;
      }
    }

    return null;
  }

  /// Search a json tree for a Map<String, dynamic> that has {"@type": "Recipe"}
  ///
  /// if `json` is a [List], gather all [Map]s in the list with `_jsonListParser`
  /// and then check each [Map] with `_jsonMapParser`
  static Map<String, dynamic>? _findRecipeJsonLd(dynamic json) {
    if (json is List) {
      final maps = _jsonListParser(json);
      for (final map in maps) {
        final recipe = _jsonMapParser(map);
        if (recipe != null) return recipe;
      }
    } else if (json is Map<String, dynamic>) {
      final recipe = _jsonMapParser(json);
      if (recipe != null) return recipe;
    }

    return null;
  }

  /// Check if the [Map] is a Recipe schema.
  ///
  /// If the [Map] is not a Recipe schema, it will send each value in the [Map]
  /// back to `_findRecipeJsonLd` to search deeper in the json for a Recipe schema.
  ///
  /// The deeper search will eventually come back to `_jsonMapParser` and if it
  /// goes as deep as possible into the json without finding a Recipe schema,
  /// then return null.
  static Map<String, dynamic>? _jsonMapParser(Map<String, dynamic> json) {
    if (json['@type'] == 'Recipe') {
      return json;
    } else if (json['@type'] is List) {
      if ((json['@type'] as List).contains('Recipe')) return json;
    } else {
      /// if we didn't find a recipe yet, send each value in this [Map] back
      /// through `_findRecipeJsonLd`
      for (final value in json.values) {
        final recipe = _findRecipeJsonLd(value);
        if (recipe != null) return recipe;
      }
    }

    return null;
  }

  /// Recursively search a [List] for [Map]s.
  ///
  /// This will go through every element in the [List]. If the element is a [List]
  /// then call this method again on that [List] element.
  ///
  /// Effectively this will search through nested lists until it reaches a [Map].
  /// It will not search the [Map] any deeper.
  static List<Map<String, dynamic>> _jsonListParser(List json) {
    List<Map<String, dynamic>> res = [];

    for (final item in json) {
      if (item is List) {
        res.addAll(_jsonListParser(item));
      } else if (item is Map<String, dynamic>) {
        res.add(item);
      }
    }

    return res;
  }

  static Future<Document> getDocument(Uri uri) async {
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return html_parser.parse(response.body);
    } else {
      throw Exception(
        'Failed to get document at uri: $uri',
      );
    }
  }
}
