import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roovies/widgets/movies_list.dart';

class TrendingMovies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trending movies in this week ',
              style: Theme.of(context).textTheme.headline6),
          MoviesList.trending(),
        ],
      ),
    );
  }
}
