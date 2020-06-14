import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Home/components/body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(user: user),
    );
  }
}
