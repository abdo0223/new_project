import 'package:flutter/cupertino.dart';
import 'package:roovies/models/TMDB_handler.dart';
import 'package:roovies/models/person.dart';

class PersonsProvider with ChangeNotifier {
  List<Person> trendingPersons;

  Future<bool> fechTrendingPersons() async {
    try {
      trendingPersons = await TMDBHandler.instance.getTrendingPerson();
      return true;
    } catch (error) {
      return false;
    }
  }
}
