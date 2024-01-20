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

  /// This will recursively check json for a section that has: "@type": "Recipe"
  static Map<String, dynamic>? _findRecipeJsonLd(Map<String, dynamic> json) {
    if (json['@type'] == 'Recipe') {
      return json;
    } else if (json['@type'] is List) {
      if ((json['@type'] as List).contains('Recipe')) return json;
    } else {
      for (final key in json.keys) {
        print(json[key]);
        if (json[key] is List) {
          // go through every list of JSONs
          for (final nestedJson in json[key]) {
            if (nestedJson is Map<String, dynamic>) {
              final found = _findRecipeJsonLd(nestedJson);
              if (found != null) return found;
            }
          }
        } else if (json[key] is Map<String, dynamic>) {
          final found = _findRecipeJsonLd(json[key]);
          if (found != null) return found;
        }
      }
    }

    return null;
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
