import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_cats_shop_app/cubits/favorite_cubit/favorite_state.dart';
import 'package:the_cats_shop_app/models/cat_model.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());

  void favorite({required String url}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final cacheUrls = prefs.getStringList('urls');

      if (!cacheUrls!.contains(url)) {
        await prefs.setStringList(
          'urls',
          [
            ...cacheUrls,
            url,
          ],
        );
      } else {
        cacheUrls.removeWhere((cacheUrl) => cacheUrl == url);

        await prefs.setStringList(
          'urls',
          cacheUrls,
        );
      }

      emit(Favorited(urls: [...state.urls ?? [], url]));
    } catch (e) {
      emit(FavoriteError());
    }
  }
}
