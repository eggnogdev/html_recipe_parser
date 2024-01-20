import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart';

class DataFetchService {
  static Map<String, dynamic> getJsonLd(Document dom) {
    final scripts = dom.querySelectorAll(
      'script[type="application/ld+json"]',
    );

    for (final script in scripts) {
      final jsonLd = jsonDecode(script.innerHtml);

      if (jsonLd is List) {
        // we found a list, grab the first one that is a recipe
        for (final element in jsonLd) {
          if (element['@type'] == 'Recipe' ||
              element['@type'].contains('Recipe')) {
            return element;
          }
        }
      } else if (jsonLd['@type'] == 'Recipe') {
        return jsonLd;
      }
    }

    throw Exception(
      'Failed to find Recipe type JSON-LD',
    );
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
