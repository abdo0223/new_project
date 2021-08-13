import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:roovies/models/movie.dart';

class MovieRating extends StatelessWidget {
  final double rating;
  MovieRating(this.rating);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$rating',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          width: 10,
        ),
        RatingBar(
          filledIcon: Icons.star,
          emptyIcon: Icons.star,
          initialRating: rating / 2,
          halfFilledIcon: Icons.star,
          isHalfAllowed: true,
          filledColor: Colors.amber,
          emptyColor: Colors.grey,
          halfFilledColor: Colors.amberAccent,
          size: 20,
          onRatingChanged: (double rating) {},
        ),
      ],
    );
  }
}
