import 'package:the_cats_shop_app/models/cat_model.dart';

abstract class CatsState {
  const CatsState({this.cats, this.errorMessage});

  final List<CatModel>? cats;
  final String? errorMessage;
}

class CatsLoaded extends CatsState {
  CatsLoaded({required List<CatModel> cats}) : super(cats: cats);
}

class CatsLoading extends CatsState {}

class CatsError extends CatsState {
  const CatsError({required String errorMaessage})
      : super(errorMessage: errorMaessage);
}
