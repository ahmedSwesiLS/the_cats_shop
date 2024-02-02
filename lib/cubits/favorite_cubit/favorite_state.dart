class FavoriteState {
  FavoriteState({this.urls});

  final List<String>? urls;
}

class FavoriteInitial extends FavoriteState {}

class Favorited extends FavoriteState {
  Favorited({required List<String> urls}) : super(urls: urls);
}

class FavoriteLoading extends FavoriteState {}

class FavoriteError extends FavoriteState {}
