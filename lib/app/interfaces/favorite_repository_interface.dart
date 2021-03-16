import 'package:easydrink/app/core/response/response_default.dart';
import 'package:easydrink/app/models/drink.dart';

abstract class IFavoriteRepository {
  Future<ResponseDefault> addFavorite(Drink drink);
  Future<ResponseDefault> removeFavorite(Drink drink);
  Future<List<Drink>> getListFavorite();
}
