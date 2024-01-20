class RecipeInstruction {
  const RecipeInstruction({
    required this.text,
  });

  final String text;

  factory RecipeInstruction.fromJson(Map<String, dynamic> json) {
    return RecipeInstruction(text: json['text']);
  }

  @override
  String toString() {
    return text;
  }
}
