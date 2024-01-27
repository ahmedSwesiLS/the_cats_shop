import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_cats_shop_app/cubits/cats_cubit/cats_cubit.dart';
import 'package:the_cats_shop_app/pages/home_page.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => CatsCubit()..getCats(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    ),
  );
}
