import 'package:the_cats_shop_app/models/cat_model.dart';

abstract class GetFavoritesState {
  const GetFavoritesState({this.urls, this.errorMessage});

  final List<String>? urls;
  final String? errorMessage;
}

class FavoritesLoaded extends GetFavoritesState {
  FavoritesLoaded({required List<String> urls}) : super(urls: urls);
}

class FavoriteLoading extends GetFavoritesState {}

class FavoritesError extends GetFavoritesState {
  const FavoritesError({required String errorMaessage})
      : super(errorMessage: errorMaessage);
}
