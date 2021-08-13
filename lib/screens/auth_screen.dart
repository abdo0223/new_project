import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:roovies/widgets/auth_form.dart';
import 'package:roovies/widgets/auth_widget.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AuthBackground(),
          AuthForm(),
        ],
      ),
    );
  }
}
