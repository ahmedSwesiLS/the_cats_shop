import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_cats_shop_app/cubits/cats_cubit/cats_cubit.dart';
import 'package:the_cats_shop_app/cubits/cats_cubit/cats_state.dart';
import 'package:the_cats_shop_app/cubits/get_favorites_cubit/get_favorites_cubit.dart';
import 'package:the_cats_shop_app/cubits/get_favorites_cubit/get_favorites_state.dart';
import 'package:the_cats_shop_app/models/cat_model.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<GetFavoritesCubit>().getFavorites();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fav Cats',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: BlocBuilder<GetFavoritesCubit, GetFavoritesState>(
              builder: (context, favoriteState) {
            return Column(
              children: [
                if (favoriteState is FavoritesLoaded)
                  ...favoriteState.urls!.map(
                    (url) => Column(
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
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.redAccent,
                              ),
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
                              url,
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
                else if (favoriteState is FavoritesError)
                  Text(favoriteState.errorMessage!)
                else
                  CircularProgressIndicator(),

                // else if (catsState is CatsFailure)
                //   Center(child: Text(catsState.errorMessage!))
                // else
                //   Center(child: CircularProgressIndicator())
              ],
            );
          }),
        ),
      ),
    );
  }
}
