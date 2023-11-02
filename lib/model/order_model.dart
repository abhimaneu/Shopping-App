import 'package:shoppingapp/model/cart_model.dart';
import 'package:shoppingapp/model/product_model.dart';
import 'package:shoppingapp/produt.dart';

class order {
  List<Cart> Productdata = [];
  String name;
  String uid;
  String phonenumber;
  String emailid;
  String address;
  String orderid;
  String totalprice;

  order({required this.name,required this.totalprice,required this.phonenumber,required this.emailid,
  required this.address,required this.orderid,required this.uid,required this.Productdata});
}