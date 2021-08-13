import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/models/movie_details.dart';
import 'package:roovies/providers/movies_provider.dart';

class NowPlaying extends StatefulWidget {
  static const String routeName = '/movie-details';

  NowPlaying(Type moviePlaying);
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  MovieDetails movieDetails;
  bool firstRun, successful;
  Movie movie;
  String videoKey;
  @override
  void initState() {
    super.initState();
    firstRun = true;
    successful = false;
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    if (firstRun) {
      movie = ModalRoute.of(context).settings.arguments;

      List results = await Future.wait([
        context.read<MoviesProvider>().fetchMovieDetailsById(movie.id),
        context.read<MoviesProvider>().fetchVideoKeyByMovieId(movie.id),
      ]);
      setState(() {
        firstRun = false;
        if (!results.any((element) => element == null)) {
          successful = true;
          movieDetails = results[0];
          videoKey = results[1];
        } else {
          successful = true;
        }
      });
    }
  }

  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width,

        // color...length...shape
        child: PageIndicatorContainer(
          length: context.watch<MoviesProvider>().nowPlaying.length,
          indicatorSelectorColor: Theme.of(context).accentColor,
          shape: IndicatorShape.circle(size: 5),
          //
          child: PageView.builder(
            itemCount: context.watch<MoviesProvider>().nowPlaying.length,
            itemBuilder: (context, index) {
              //عامل stack عشان هحط صورة و فوقها gradiant , text ,icon
              return Stack(children: [
                Container(
                  height: MediaQuery.of(context).size.height * .5,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    context
                        .watch<MoviesProvider>()
                        .nowPlaying[index]
                        .posterPath,
                    fit: BoxFit.cover,
                  ),
                ),

                //gradiant
                Container(
                    height: MediaQuery.of(context).size.height * .5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          Theme.of(context).primaryColor,
                          Theme.of(context).primaryColor.withOpacity(0),
                        ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter))),

                //text_film
                Positioned(
                  bottom: 50,
                  left: 10,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                        context.watch<MoviesProvider>().nowPlaying[index].title,
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )),
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: InkWell(
                      child: IconButton(
                          icon: Icon(Icons.play_circle_outline),
                          color: Theme.of(context).accentColor,
                          iconSize: 50,
                          onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            // builder: (context) {
                            //   return MoviePlaying(videoKey);
                            //  },
                            // ));
                          }),
                    )),
              ]);
            },
          ),
        ));
  }
}
