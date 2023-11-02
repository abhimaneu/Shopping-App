import 'package:flutter/material.dart';

class welcome extends StatelessWidget {
  const welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 2000,
        height: 1000,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40,),
            Text("Welcome"),
            SizedBox(height: 10,),
            Text("New here?"),
            TextButton(onPressed: () {

            },
                child: Text("Sign Up")),
            SizedBox(height: 10,),
            Text("Already have an Account?"),
            TextButton(onPressed: () {

            },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
