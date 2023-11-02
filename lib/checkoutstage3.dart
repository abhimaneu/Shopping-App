import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/cart.dart';
import 'package:shoppingapp/databasefolder/firestoredatabase.dart';
import 'package:shoppingapp/model/cart_model.dart';
import 'package:shoppingapp/model/order_model.dart';

class checkoutstage3 extends StatefulWidget {
  double total;
  String name = "" ;
  String emailid = "" ;
  String phonenumber = "" ;
  String address = "" ;
  checkoutstage3(this.total, this.address, this.name, this.emailid , this.phonenumber, {Key? key}) : super(key: key);

  @override
  State<checkoutstage3> createState() => _checkoutstage3State();
}

class _checkoutstage3State extends State<checkoutstage3> {
  var f = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: FirebaseFirestore.instance.collection('user').
        doc(FirebaseAuth.instance.currentUser!.uid).
        collection('userdetails').
        get(),
        builder: (context , AsyncSnapshot<QuerySnapshot> snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return FutureBuilder(
            future: FirebaseFirestore.instance.collection('user').
              doc(FirebaseAuth.instance.currentUser!.uid).
              collection('usercart').
              get(),
              builder: (context , AsyncSnapshot<QuerySnapshot> sNapshot) {

              if(sNapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if(f == 0) {
                List<Cart> cart = [] ;
                for(int i=0 ; i < sNapshot.data!.docs.length ; i++) {
                  cart.add(Cart(sNapshot.data!.docs[i]['productid'],
                      " ",
                      sNapshot.data!.docs[i]['name'],
                      sNapshot.data!.docs[i]['price'],
                      sNapshot.data!.docs[i]['size'],
                      sNapshot.data!.docs[i]['quantity'])
                  );
                }
                order orders = order(
                    name: widget.name,
                    totalprice: widget.total.toString(),
                    phonenumber: widget.phonenumber,
                    emailid: widget.emailid,
                    address: widget.address,
                    orderid: (Random().nextInt(900000) + 100000).toString(),
                    uid: FirebaseAuth.instance.currentUser!.uid,
                    Productdata: cart
                );


                // orders?.name = widget.name;
                // orders?.uid = FirebaseAuth.instance.currentUser!.uid;
                // orders?.totalprice = widget.total?.toStringAsFixed(2);
                // orders?.emailid = widget.emailid;
                // orders?.phonenumber = widget.phonenumber;
                // orders?.address = widget.address;
                // orders?.orderid = (Random().nextInt(90000) + 1000).toString();
                Databaseservices().putorderdetails(orders, sNapshot.data!.docs.length).then((value) =>
                    Databaseservices().clearcart().then((value) => Navigator.pop(context)).then((value) => Navigator.pop(context)));
                //f=1;
              }

              if(f == 1) {
                return Text("Error");
              }

              return Container();

              });

        },
      ),
    );
  }
}
