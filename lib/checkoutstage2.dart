import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'checkoutstage3.dart';

class checkoutstage2 extends StatefulWidget {
  double total;
  checkoutstage2(this.total, {Key? key}) : super(key: key);

  @override
  State<checkoutstage2> createState() => _checkoutstage2State();
}

class _checkoutstage2State extends State<checkoutstage2> {
  String address = "" ;
  String name = "" ;
  String emailid = "" ;
  String phonenumber = "" ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            Text(" Enter Shipping Details",
            style: TextStyle(
              color: Colors.black,
              fontSize: 37
            ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Name",
                hintText: ""
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              onChanged: (value) {
                emailid = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email Id",
                hintText: ""
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              onChanged: (value) {
                phonenumber = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Phone Number",
                hintText:  ""
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              onChanged: (value) {
                address = value;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Address",
                hintText: ""
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end ,
              children: [
                TextButton(onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)
                  => checkoutstage3(widget.total , address , name , emailid , phonenumber)));
                },
                    child: Text("Continue",
                    style: TextStyle(
                      color: Colors.black
                    ),
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
