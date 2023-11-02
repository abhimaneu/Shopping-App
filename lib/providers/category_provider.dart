import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/model/product_model.dart';

class CategoryProvider with ChangeNotifier{

  late Product shirtdata;
  List<Product> shirt = [];

  Future getShirtdata() async {
    List<Product> list = [];
    QuerySnapshot shirtsnapshot = await FirebaseFirestore.instance.
    collection('categories').
    doc('TVOIfH9lJJdXbdfM6f3w').
    collection('shirts').
    get();
    shirtsnapshot.docs.forEach((element) {
      shirtdata = Product(
        productid: "4",
      image: element['image'],
      name: element['name'],
      price: element['price']
    );
    list.add(shirtdata);
    }
    );
    shirt = list;
  }

  List<Product> get  getShirtlist {
    return shirt;
  }
}