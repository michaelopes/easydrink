import 'dart:math';

class Drink {
  String strDrink;
  String strDrinkThumb;
  int idDrink;
  double stars;
  double rating;
  bool isFavorite;
  double userStar;
  String strCategory;
  String strIBA;
  String strAlcoholic;
  String strGlass;
  String strInstructions;
  String strIngredient1;
  String strIngredient2;
  String strIngredient3;
  String strIngredient4;
  String strIngredient5;
  String strIngredient6;
  String strIngredient7;
  String strIngredient8;
  String strIngredient9;
  String strIngredient10;
  String strIngredient11;
  String strIngredient12;
  String strIngredient13;
  String strIngredient14;
  String strIngredient15;
  String strMeasure1;
  String strMeasure2;
  String strMeasure3;
  String strMeasure4;
  String strMeasure5;
  String strMeasure6;
  String strMeasure7;
  String strMeasure8;
  String strMeasure9;
  String strMeasure10;
  String strMeasure11;
  String strMeasure12;
  String strMeasure13;
  String strMeasure14;
  String strMeasure15;

  Drink({
    this.strDrink,
    this.strDrinkThumb,
    this.idDrink,
    this.stars,
    this.userStar,
    this.isFavorite,
    this.strCategory,
    this.strIBA,
    this.strAlcoholic,
    this.strGlass,
    this.strInstructions,
    this.strIngredient1,
    this.strIngredient2,
    this.strIngredient3,
    this.strIngredient4,
    this.strIngredient5,
    this.strIngredient6,
    this.strIngredient7,
    this.strIngredient8,
    this.strIngredient9,
    this.strIngredient10,
    this.strIngredient11,
    this.strIngredient12,
    this.strIngredient13,
    this.strIngredient14,
    this.strIngredient15,
    this.strMeasure1,
    this.strMeasure2,
    this.strMeasure3,
    this.strMeasure4,
    this.strMeasure5,
    this.strMeasure6,
    this.strMeasure7,
    this.strMeasure8,
    this.strMeasure9,
    this.strMeasure10,
    this.strMeasure11,
    this.strMeasure12,
    this.strMeasure13,
    this.strMeasure14,
    this.strMeasure15,
  });

  Drink.fromJson(Map<String, dynamic> json) {
    strDrink = json['strDrink'].trim();
    strDrinkThumb = json['strDrinkThumb'];
    idDrink = (json['idDrink'].runtimeType.toString() == "String")
        ? int.parse(json['idDrink'])
        : json['idDrink'];
    stars = json['stars'] ?? _generateRandomStarValue();
    userStar = json['userStar'] ?? 0;
    isFavorite = json['isFavorite'] ?? false;
    rating = _getRating();

    strCategory = json['strCategory'];
    strIBA = json['strIBA'];
    strAlcoholic = json['strAlcoholic'];
    strGlass = json['strGlass'];
    strInstructions = json['strInstructions'];
    strIngredient1 = json['strIngredient1'];
    strIngredient2 = json['strIngredient2'];
    strIngredient3 = json['strIngredient3'];
    strIngredient4 = json['strIngredient4'];
    strIngredient5 = json['strIngredient5'];
    strIngredient6 = json['strIngredient6'];
    strIngredient7 = json['strIngredient7'];
    strIngredient8 = json['strIngredient8'];
    strIngredient9 = json['strIngredient9'];
    strIngredient10 = json['strIngredient10'];
    strIngredient11 = json['strIngredient11'];
    strIngredient12 = json['strIngredient12'];
    strIngredient13 = json['strIngredient13'];
    strIngredient14 = json['strIngredient14'];
    strIngredient15 = json['strIngredient15'];
    strMeasure1 = json['strMeasure1'];
    strMeasure2 = json['strMeasure2'];
    strMeasure3 = json['strMeasure3'];
    strMeasure4 = json['strMeasure4'];
    strMeasure5 = json['strMeasure5'];
    strMeasure6 = json['strMeasure6'];
    strMeasure7 = json['strMeasure7'];
    strMeasure8 = json['strMeasure8'];
    strMeasure9 = json['strMeasure9'];
    strMeasure10 = json['strMeasure10'];
    strMeasure11 = json['strMeasure11'];
    strMeasure12 = json['strMeasure12'];
    strMeasure13 = json['strMeasure13'];
    strMeasure14 = json['strMeasure14'];
    strMeasure15 = json['strMeasure15'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['strDrink'] = this.strDrink;
    data['strDrinkThumb'] = this.strDrinkThumb;
    data['idDrink'] = this.idDrink;
    data['stars'] = this.stars;
    data['userStar'] = this.userStar;
    data['isFavorite'] = this.isFavorite;
    data['strCategory'] = this.strCategory;
    data['strIBA'] = this.strIBA;
    data['strAlcoholic'] = this.strAlcoholic;
    data['strGlass'] = this.strGlass;
    data['strInstructions'] = this.strInstructions;
    data['strDrinkThumb'] = this.strDrinkThumb;
    data['strIngredient1'] = this.strIngredient1;
    data['strIngredient2'] = this.strIngredient2;
    data['strIngredient3'] = this.strIngredient3;
    data['strIngredient4'] = this.strIngredient4;
    data['strIngredient5'] = this.strIngredient5;
    data['strIngredient6'] = this.strIngredient6;
    data['strIngredient7'] = this.strIngredient7;
    data['strIngredient8'] = this.strIngredient8;
    data['strIngredient9'] = this.strIngredient9;
    data['strIngredient10'] = this.strIngredient10;
    data['strIngredient11'] = this.strIngredient11;
    data['strIngredient12'] = this.strIngredient12;
    data['strIngredient13'] = this.strIngredient13;
    data['strIngredient14'] = this.strIngredient14;
    data['strIngredient15'] = this.strIngredient15;
    data['strMeasure1'] = this.strMeasure1;
    data['strMeasure2'] = this.strMeasure2;
    data['strMeasure3'] = this.strMeasure3;
    data['strMeasure4'] = this.strMeasure4;
    data['strMeasure5'] = this.strMeasure5;
    data['strMeasure6'] = this.strMeasure6;
    data['strMeasure7'] = this.strMeasure7;
    data['strMeasure8'] = this.strMeasure8;
    data['strMeasure9'] = this.strMeasure9;
    data['strMeasure10'] = this.strMeasure10;
    data['strMeasure11'] = this.strMeasure11;
    data['strMeasure12'] = this.strMeasure12;
    data['strMeasure13'] = this.strMeasure13;
    data['strMeasure14'] = this.strMeasure14;
    data['strMeasure15'] = this.strMeasure15;
    return data;
  }

  double _getRating() {
    if (userStar > 0) {
      return double.parse(((userStar + stars) / 2).toStringAsFixed(1));
    } else {
      return stars;
    }
  }

  void setUserStar(double star) {
    userStar = star;
    rating = _getRating();
  }

  double _generateRandomStarValue() {
    final random = Random();
    var rand = random.nextDouble() * 5.0;
    if (rand < 1) {
      rand = 1.0;
    }
    return double.parse((rand).toStringAsFixed(1));
  }
}
