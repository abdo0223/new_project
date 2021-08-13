import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/providers/genres.provider.dart';
import 'package:roovies/providers/persons_provider.dart';
import 'package:roovies/screens/movie_playing.dart';
import 'package:roovies/widgets/movies_by_geners.dart';
import 'package:roovies/widgets/now_playing.dart';
import 'package:roovies/widgets/trending_movies.dart';
import 'package:roovies/widgets/trending_person.dart';
import 'package:roovies/providers/movies_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool firstRun, successful;
  @override
  void initState() {
    super.initState();
    firstRun = true;
    successful = false;
  }

  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (firstRun) {
      //await Provider.of<MoviesProvider>(context, listen: false).fetchNowPlaying();

      // MoviesProvider done = await context.read<MoviesProvider>();

      List<bool> results = await Future.wait([
        context.read<MoviesProvider>().fetchNowPlaying(),
        context.read<GenresProvider>().fetchGenres(),
        context.read<PersonsProvider>().fechTrendingPersons(),
        context.read<MoviesProvider>().fetchTrendingMovies()
      ]);

      setState(() {
        firstRun = false;
        successful = !results.any((element) => element == false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          onPressed: () {},
        ),
        title: Text('Aflam Gamda'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: (firstRun)
          ? Center(child: CircularProgressIndicator())
          //ممكن احط listview من غير column عادي
          : SingleChildScrollView(
              child: Column(
                children: [
                  NowPlaying(MoviePlaying),
                  MoviesByGenre(),
                  TrendingPerson(),
                  TrendingMovies(),
                ],
              ),
            ),
    );
  }
}
