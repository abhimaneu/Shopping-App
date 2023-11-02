import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/cart.dart';

import '../model/cart_model.dart';
import '../model/order_model.dart';
import '../model/product_model.dart';

List<Product> datas = [];

class Databaseservices {
  List<Product> products = [];
  List<Cart> cart = [];

  Future userdata(name , emailid , phonenumber) async {
    var uid;
    uid = await FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance.collection('users').
    doc(uid).
    set({
      'name' : name,
      'emailid': emailid,
      'phonenumber'  : phonenumber
    },
        SetOptions(merge: true
        ));
}

Future clearcart() async {
    var uid = await FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance.collection('user').
  doc(uid).
  collection('usercart').
  get().then((value) => {
    value.docs.forEach((element) {
      element.reference.delete();
    })
    });
}

Future putorderdetails(order? orders , index) async {
    var uid;
    uid = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.
  collection('order').
  doc(uid).
  set({
      'useruid' : orders?.uid,
      'useremail' : orders?.emailid,
      'username' : orders?.name,
      'userphonenumber' : orders?.phonenumber,
      'useraddress' : orders?.address
    });
    var o = await FirebaseFirestore.instance.
  collection('order').
  doc(uid).
  collection('orders').
  doc();
    for(int i = 0 ; i < index ; i++) {
      await o.set({
        '$i' : {
          'productname' : orders?.Productdata[i].name,
          'productid' : orders?.Productdata[i].productid,
          'productprice' : orders?.Productdata[i].price,
          'productquantity' : orders?.Productdata[i].quantity,
          'productsize' : orders?.Productdata[i].size,
        },
        'total' : orders?.totalprice
      }, SetOptions(merge: true) );
    }
}

Future getprofileimage() async {
  User user = await FirebaseAuth.instance.currentUser!;
  Reference storageref = FirebaseStorage.instance.ref().child("userimage/${user.uid}/${user.uid}/");
  String imageUrl = await storageref.getDownloadURL() as String;
  return imageUrl;
}

Future getproductdata() async {
  var stored = await FirebaseFirestore.instance.
  collection('categories').
  doc('TVOIfH9lJJdXbdfM6f3w').
  collection('shirts').
  get();
  for(int i=0; i<stored.size; i++) {
    datas.add(Product(name: stored.docs[i]['name'],
        image: stored.docs[i]['image'],
        price: stored.docs[i]['price'],
        productid: stored.docs[i]['productid'])
    );
  }
}
List<Product> searching (String query) {
    List<Product> elements = datas.where((element) {
      return element.name.toUpperCase().contains(query) ||
      element.name.toLowerCase().contains(query);
    }).toList();
    return elements;
}

Future addusersinfo(name , emailid , phonenumber) async {
    var uid = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance.collection('user').
        doc(uid).
        collection('userdetails').
  add({
      'name' : name,
      'emailid' : emailid,
      'phonenumber' : phonenumber
    },
    );
}

Future removeitemfromcart(id) async {
    var uid;
    uid = await FirebaseAuth.instance.currentUser?.uid;
    var document = await FirebaseFirestore.instance.
  collection('user').
  doc(uid).
        collection('usercart').
  doc(id).
    delete();
}

Future changedata(name , phonenumber) async {
    var uid;
    uid = await FirebaseAuth.instance.currentUser?.uid;
    var document = await FirebaseFirestore.instance.
  collection('user').
  doc(uid).
  collection('userdetails').
  get();
    String id = document.docs[0].id;
   await FirebaseFirestore.instance.
  collection('user').
  doc(uid).
  collection('userdetails').
  doc(id).
  set({
     'name' : name,
     'phonenumber' : phonenumber
   }, SetOptions(merge: true) );

}

Future cartdata(productid ,image , name , price , size , quantity) async {
    var uid;
    uid = await FirebaseAuth.instance.currentUser?.uid;
    var document = await FirebaseFirestore.instance.collection('user').
    doc(uid).
    collection('usercart').doc(productid).get();
    try {
      var s = document.data()?['size'];
      if (s.toString() == size.toString()) {
        return "Item already in Cart";
      }
    }
    catch (e) {
      print(e);
    }
    await FirebaseFirestore.instance.collection('user').
    doc(uid).
    collection('usercart').
        doc(productid).
  set({
      'productid' : productid,
      'image' : image,
      'name' : name,
      'price' : price,
      'size' : size,
      'quantity' : quantity
    },SetOptions(
        merge: true
    ));
    return "OK";
}
Future modify(productid, v) async {
    var uid;
    uid = await FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance.
  collection('user').
  doc(uid).
  collection('usercart').
  doc(productid).
  set({
      'quantity' : v
    },SetOptions(merge: true));
}
}