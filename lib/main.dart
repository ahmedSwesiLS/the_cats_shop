import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_cats_shop_app/cubits/cats_cubit/cats_cubit.dart';
import 'package:the_cats_shop_app/cubits/favorite_cubit/favorite_cubit.dart';
import 'package:the_cats_shop_app/cubits/get_favorites_cubit/get_favorites_cubit.dart';
import 'package:the_cats_shop_app/cubits/signup_cubit/signup_cubit.dart';
import 'package:the_cats_shop_app/pages/favorites_page.dart';
import 'package:the_cats_shop_app/pages/firestore_ex_getdocs.dart';
import 'package:the_cats_shop_app/pages/firestore_example.dart';
import 'package:the_cats_shop_app/pages/firestore_get_ex.dart';
import 'package:the_cats_shop_app/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:the_cats_shop_app/pages/sign_up.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CatsCubit()..getCats(),
        ),
        BlocProvider(
          create: (context) => FavoriteCubit(),
        ),
        BlocProvider(
          create: (context) => GetFavoritesCubit()..getFavorites(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppRoot(),
      ),
    ),
  );
}

class AppRoot extends StatefulWidget {
  const AppRoot({
    super.key,
  });

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  int _currentIndex = 0;

  static final List<Widget> _pages = const [
    HomePage(),
    FavoritesPage(),
    FirestoreExample(),
    // FirestoreGetEx('HlkR1JOfVngcNeSxEqSY'),
    FirestoreList(),
  ];

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
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Drawer'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.app_registration_rounded),
              title: Text('Signup'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => SignupCubit(),
                      child: SignupScreen(),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Login'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: 'cloud',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'list',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
