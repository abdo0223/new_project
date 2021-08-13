import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/helpers/constants.dart';
import 'package:roovies/providers/genres.provider.dart';
import 'package:roovies/providers/movies_provider.dart';
import 'package:roovies/providers/persons_provider.dart';
import 'package:roovies/screens/auth_screen.dart';
import 'package:roovies/screens/home_screen.dart';
import 'package:roovies/screens/movie_details.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => MoviesProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => GenresProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => PersonsProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roovies',
      theme: ThemeData(
        primarySwatch: constants.color,
        accentColor: Color.fromRGBO(244, 193, 15, 1),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: constants.color,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.blueGrey,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
      routes: {MovieDetailsScreen.routeName: (context) => MovieDetailsScreen()},
    );
  }
}
