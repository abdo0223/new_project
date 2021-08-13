import 'package:flutter/material.dart';
import 'package:roovies/models/movie.dart';
import 'package:roovies/models/user.dart';
import 'package:roovies/providers/movies_provider.dart';
import 'package:provider/provider.dart';
import 'package:roovies/screens/movie_details.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:roovies/widgets/movie_raiting.dart';
import 'package:rating_bar/rating_bar.dart';

class MoviesList extends StatefulWidget {
  final int genreId;
  MoviesList.byGenreId(this.genreId);
  MoviesList.trending() : this.genreId = null;
  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  bool firstRun, successful;
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
      bool done = true;
      if (widget.genreId != null) {
        done = await context
            .read<MoviesProvider>()
            .fetchMoviesByGenreId(widget.genreId);
      }
      if (mounted) {
        setState(() {
          successful = done;
          firstRun = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: (firstRun)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (successful)
              ? ListView.builder(
                  itemExtent: 140,
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      context.watch<MoviesProvider>().trendingMovies.length,
                  itemBuilder: (context, index) {
                    Movie movie = (widget.genreId != null)
                        ? context.watch<MoviesProvider>().moviesByGegre[index]
                        : context.watch<MoviesProvider>().trendingMovies[index];

                    bool isFav =
                        context.read<MoviesProvider>().isFavorite(movie.id);
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       return MovieDetailsScreen();
                              //     },
                              //   ),
                              // );
                              Navigator.of(context).pushNamed(
                                  MovieDetailsScreen.routeName,
                                  arguments: movie);
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          movie.backPosterPath,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  flex: 7,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      movie.title,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  flex: 2,
                                ),
                                Expanded(
                                  child: FittedBox(
                                    child: Row(
                                      children: [
                                        FittedBox(
                                          child: Text(
                                            '${movie.rating}',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        RatingBar(
                                          filledIcon: Icons.star,
                                          emptyIcon: Icons.star,
                                          initialRating: movie.rating / 2,
                                          halfFilledIcon: Icons.star,
                                          isHalfAllowed: true,
                                          filledColor: Colors.amber,
                                          emptyColor: Colors.grey,
                                          halfFilledColor: Colors.amberAccent,
                                          size: 20,
                                          onRatingChanged: (double rating) {},
                                        ),
                                      ],
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 5,
                            top: 3,
                            child: InkWell(
                              onTap: () async {
                                context
                                    .read<MoviesProvider>()
                                    .toggleFavoriteStatus(movie);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    gradient: RadialGradient(colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).primaryColor.withOpacity(0),
                                ])),
                                child: Icon(
                                  (isFav)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Theme.of(context).accentColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'Error has occurred',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
    );
  }
}
