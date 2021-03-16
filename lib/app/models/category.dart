class Category {
  String description;

  Category({this.description});

  Category.fromJson(Map<String, dynamic> json) {
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    return data;
  }

  String getFirstDescriptionLetter() {
    return description[0].toUpperCase();
  }
}
