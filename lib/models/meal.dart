class Meal {
  String label;
  String image;
  String source;
  List<String> ingredientLines;
  List<String> healthLabels;
  String uri;
  double calories;
  double totalTime;

  Meal({
    this.label,
    this.source,
    this.image,
    this.healthLabels,
    this.ingredientLines,
    this.calories,
    this.uri,
    this.totalTime,
  });

  Meal.fromJson(Map<String, dynamic> json) {
    try {
      json = json['recipe'];
      label = json['label'];
      source = json['source'];
      image = json['image'];
      healthLabels = new List<String>.from(json['healthLabels']);
      ingredientLines = new List<String>.from(json['ingredientLines']);
      calories = json['calories'];
      totalTime = json['totalTime'];
      uri = json['uri'];
    } catch (e) {
      //do nothing
    }
  }
}
