import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roovies/models/person.dart';
import 'package:roovies/providers/persons_provider.dart';

class PersonsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .2,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 100,
          itemCount: context.watch<PersonsProvider>().trendingPersons.length,
          itemBuilder: (context, index) {
            Person person =
                context.watch<PersonsProvider>().trendingPersons[index];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Expanded(
                      flex: 7,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(person.posertPath),
                                fit: BoxFit.cover)),
                      )),
                  Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          person.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ],
              ),
            );
          }),
    );
  }
}
