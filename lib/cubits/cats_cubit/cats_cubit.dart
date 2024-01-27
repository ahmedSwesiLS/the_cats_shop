import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_cats_shop_app/cubits/cats_cubit/cats_state.dart';
import 'package:the_cats_shop_app/data/cats_dats.dart';

class CatsCubit extends Cubit<CatsState> {
  CatsCubit() : super(CatsLoading());

  CatsData catsData = CatsData();

  void getCats() async {
    try {
      final cats = await catsData.getCats();

      emit(CatsLoaded(cats: cats));
    } catch (e) {
      emit(
        const CatsError(errorMaessage: 'Cats not found'),
      );
    }
  }
}
