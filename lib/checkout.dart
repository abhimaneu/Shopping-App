import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/model/order_model.dart';

import 'checkoutstage2.dart';

class checkout extends StatefulWidget {
  const checkout({Key? key}) : super(key: key);

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  @override
  Widget build(BuildContext context) {
    double subtotal = 0;
    double total = 0;
    double discount = 0;
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white24,
        child: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)
             => checkoutstage2(total)));
          },
          child: Text("Continue" , style: TextStyle(color: Colors.black45),),
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('user').
          doc(FirebaseAuth.instance.currentUser?.uid).
          collection('usercart').
          get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          snapshot.data!.docs.forEach((element) {
            for(int i= 0; i<element['quantity'];i++) {
              subtotal = subtotal + double.parse(element['price']);
            }
          });

          snapshot.data!.docs.forEach((element) {
            total = subtotal - (discount/100 * subtotal);
          });

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context , index) {
                    return Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              SizedBox(height: 40,),
                              Card(
                                elevation: 0,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      child: Image.network(snapshot.data!.docs[index]['image']),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data!.docs[index]['name'],
                                        style: TextStyle(
                                          fontSize: 17
                                        ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text(snapshot.data!.docs[index]['price'],
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                        ),
                                        SizedBox(height: 10,),
                                        Text( "Quantity: " + snapshot.data!.docs[index]['quantity'].toString()),
                                        SizedBox(height: 2,),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Subtotal : ",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.normal
                        ),
                        ),
                        Text(subtotal.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.normal
                        ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Discount : ",
                        style: TextStyle(
                          fontSize: 19
                        ),
                        ),
                        Text(discount.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 19
                        ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total : ",
                        style: TextStyle(
                          fontSize: 18
                        ),
                        ),
                        Text(total.toStringAsFixed(2),
                        style: TextStyle(
                          fontSize: 32.2,
                        ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
