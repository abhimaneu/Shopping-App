import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/login.dart';
import 'package:shoppingapp/signup.dart';

class showsignpages extends StatefulWidget {
  const showsignpages({Key? key}) : super(key: key);

  @override
  State<showsignpages> createState() => _showsignpagesState();
}

class _showsignpagesState extends State<showsignpages> {
  bool islogin = false;
  void toggle() {
setState(() {
  islogin = !islogin;
} );
  }
  @override
  Widget build(BuildContext context) {
    return islogin ? login(toggle: toggle) : signUp(toggle: toggle);
  }
}
