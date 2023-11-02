import 'package:flutter/material.dart';

import '../detailsscreen.dart';

Widget buildfeaturedrow(productid, image , name , price , context){
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (_)
      => detailscreen(
        productid: productid,
        image: image,
        name: name,
        price: price,
      )));
    },
    child:  Container(
      //width: MediaQuery.of(context).size.width / 2.4,
      //height: MediaQuery.of(context).size.height * 0.24,
      //color: Color.fromRGBO(255, 255, 255, 1),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            //width: 2,
              color: Colors.black26
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.24 * 0.7,
            //width: MediaQuery.of(context).size.width / 2.4 * 1,
            child: Image.network(
              image,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Text(name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
          Text(price,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}