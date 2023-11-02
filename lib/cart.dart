import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/checkout.dart';
import 'package:shoppingapp/databasefolder/firestoredatabase.dart';

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  var uid;
  bool b = false;
  getuid() async {
    uid =  await FirebaseAuth.instance.currentUser?.uid;
  }
  @override
  void initState(){
    super.initState();
    getuid();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white24,
        child: TextButton(
          onPressed: () {
            if(!b) {
            Navigator.push(context, MaterialPageRoute(builder: (_)
             => checkout()));}
          },
          child: Text("Check Out",style: TextStyle(color: Colors.black45),),
        ),

      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.
          collection('user').
          doc(FirebaseAuth.instance.currentUser?.uid).
          collection('usercart').
          snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            //print(snapshot);
            return Center(
              child: CircularProgressIndicator(),

            );
          }

          if(snapshot.data!.docs.length == 0) {
            b=true;
            return Center(
              child:
                  Text("Add Products to Cart"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context , index){
            return Container(
              child: Column(
                children: [
                  //SizedBox(height: 40,),
                  Card(
                    elevation: 0,
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          child: Image.network(snapshot.data!.docs[index]['image']),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.54,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data!.docs[index]['name'],
                              style: TextStyle(
                                fontSize: 16
                              ),
                              ),
                              SizedBox(height: 6,),
                              Text(snapshot.data!.docs[index]['price'],
                              style: TextStyle(
                                fontSize: 14
                              ),
                              ),
                              Row(
                                children: [
                                  IconButton(onPressed: () {
                                    setState(() {
                                      if(snapshot.data!.docs[index]['quantity']>1) {
                                        Databaseservices().modify(
                                            snapshot.data!
                                                .docs[index]['productid'],
                                            snapshot.data!
                                                .docs[index]['quantity'] -
                                                1
                                        );
                                      }
                                    });
                                  },
                                      icon: Icon(Icons.remove)),
                                  Text(snapshot.data!.docs[index]['quantity'].toString()),
                                  IconButton(onPressed: () {
                                    setState(() {
                                      Databaseservices().modify(
                                          snapshot.data!.docs[index]['productid'],
                                          snapshot.data!.docs[index]['quantity'] +
                                              1
                                      );
                                    });
                                  },
                                      icon: Icon(Icons.add))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          child: Column(
                            children: [
                              IconButton(onPressed: () {
                                Databaseservices().removeitemfromcart(
                                  snapshot.data!.docs[index]['productid']
                                );
                                setState(() {});
                              },
                                  icon: Icon(Icons.clear))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
            }
          );
        }
      ),
    );
  }
}
