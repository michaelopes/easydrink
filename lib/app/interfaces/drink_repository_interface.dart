import 'package:easydrink/app/core/response/response_default.dart';

abstract class IDrinkRepository {
  Future<ResponseDefault> listCategories();
  Future<ResponseDefault> listIngredients();
  Future<ResponseDefault> listGlasses();
  Future<ResponseDefault> listDrinkType();
  Future<ResponseDefault> getDrinkDetail(int idDrink);
  Future<ResponseDefault> searchDrink(String prefix, String term);
}
