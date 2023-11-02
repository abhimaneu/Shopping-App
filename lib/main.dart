import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shoppingapp/cart.dart';
import 'package:shoppingapp/categoriesall.dart';
import 'package:shoppingapp/checkout.dart';
import 'package:shoppingapp/detailsscreen.dart';
import 'package:shoppingapp/homepage.dart';
import 'package:shoppingapp/login.dart';
import 'package:shoppingapp/produt.dart';
import 'package:shoppingapp/showwrapperpage.dart';
import 'package:shoppingapp/signup.dart';
import 'package:shoppingapp/welcome.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        secondaryHeaderColor: Color.fromRGBO(255, 255, 255, 1),
        canvasColor: Colors.white,
        backgroundColor: Color.fromRGBO(224, 224, 224, 1)
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context , snapshot) {
          if(snapshot.hasData){
            return homepage();
          }
          else {
            return showsignpages();
          }
        },
      ),
    );
  }
}
