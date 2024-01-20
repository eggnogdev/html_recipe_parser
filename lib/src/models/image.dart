class RecipeImage {
  const RecipeImage({
    required this.url,
  });

  final String url;

  factory RecipeImage.fromJson(json) {
    if (json is Map<String, dynamic>) {
      return RecipeImage(
        url: json['url'],
      );
    } else {
      return RecipeImage(
        url: json.first,
      );
    }
  }

  @override
  String toString() {
    return url;
  }
}
