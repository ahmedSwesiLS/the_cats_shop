import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_cats_shop_app/cubits/cats_cubit/cats_cubit.dart';
import 'package:the_cats_shop_app/cubits/cats_cubit/cats_state.dart';
import 'package:the_cats_shop_app/models/cat_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'The Cat Shop',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: BlocBuilder<CatsCubit, CatsState>(builder: (context, state) {
            return Column(
              children: [
                if (state is CatsLoaded)
                  ...List<CatModel>.from(state.cats!)
                      .map(
                        (cat) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.blue[900],
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Mr. Wahid',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                // IconButton(
                                //   onPressed: () {},
                                //   icon: Icon(
                                //     Icons.favorite_border,
                                //     color: Colors.redAccent,
                                //   ),
                                // ),
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
                else if (state is CatsError)
                  Text(state.errorMessage!)
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
      ),
    );
  }
}
