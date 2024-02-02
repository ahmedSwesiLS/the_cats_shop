import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_cats_shop_app/cubits/get_favorites_cubit/get_favorites_state.dart';
import 'package:the_cats_shop_app/models/cat_model.dart';

class GetFavoritesCubit extends Cubit<GetFavoritesState> {
  GetFavoritesCubit() : super(FavoriteLoading());

  void getFavorites() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // await prefs.remove('urls');

      final catsStringList = prefs.getStringList('urls');

      final List<String> urls = catsStringList!;

      // final cats = catsStringList
      //     ?.map<CatModel>(
      //       (catString) => jsonDecode(catString),
      //     )
      //     .toList();

      if (urls != null) {
        emit(FavoritesLoaded(urls: urls));
      } else {
        emit(
          const FavoritesError(errorMaessage: 'Favorites not found'),
        );
      }
    } catch (e) {
      emit(
        const FavoritesError(errorMaessage: 'Favorites not found'),
      );
    }
  }
}
