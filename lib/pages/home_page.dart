import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_cats_shop_app/cubits/cats_cubit/cats_cubit.dart';
import 'package:the_cats_shop_app/cubits/cats_cubit/cats_state.dart';
import 'package:the_cats_shop_app/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:the_cats_shop_app/cubits/favorite_cubit/favorite_state.dart';
import 'package:the_cats_shop_app/cubits/get_favorites_cubit/get_favorites_cubit.dart';
import 'package:the_cats_shop_app/cubits/get_favorites_cubit/get_favorites_state.dart';
import 'package:the_cats_shop_app/models/cat_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<CatsCubit>().getCats();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SingleChildScrollView(
        child: BlocBuilder<CatsCubit, CatsState>(builder: (context, catsState) {
          return Column(
            children: [
              if (catsState is CatsLoaded)
                ...List<CatModel>.from(catsState.cats!)
                    .map(
                      (cat) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.payment),
                              ),
                              // Row(
                              //   children: [
                              // CircleAvatar(
                              //   backgroundColor: Colors.blue[900],
                              //   child: Icon(
                              //     Icons.person,
                              //     color: Colors.white,
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: 10,
                              // ),
                              // Text(
                              //   'Mr. Wahid',
                              //   style: TextStyle(
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              //   ],
                              // ),
                              BlocBuilder<FavoriteCubit, FavoriteState>(
                                builder: (context, favoriteState) {
                                  return BlocBuilder<GetFavoritesCubit,
                                      GetFavoritesState>(
                                    builder: (context, getFavoriteState) {
                                      bool isFaved = false;

                                      if (getFavoriteState is FavoritesLoaded) {
                                        isFaved = getFavoriteState.urls!
                                            .contains(cat.url);
                                      }

                                      context
                                          .read<GetFavoritesCubit>()
                                          .getFavorites();

                                      return IconButton(
                                        onPressed: () {
                                          context
                                              .read<FavoriteCubit>()
                                              .favorite(url: cat.url);
                                        },
                                        icon: Icon(
                                          isFaved
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.redAccent,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: ClipRRect(
                              clipBehavior: Clip.antiAlias,
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                cat.url,
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.blue.withOpacity(.3),
                          ),
                        ],
                      ),
                    )
                    .toList()
              else if (catsState is CatsError)
                Text(catsState.errorMessage!)
              else
                const Center(
                  child: const CircularProgressIndicator(),
                ),

              // else if (catsState is CatsFailure)
              //   Center(child: Text(catsState.errorMessage!))
              // else
              //   Center(child: CircularProgressIndicator())
            ],
          );
        }),
      ),
    );
  }
}
