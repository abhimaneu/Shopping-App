import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/detailsscreen.dart';
import 'package:shoppingapp/widget/featureview.dart';

class product extends StatelessWidget {
  var name;
  var mysnapshot;
  product({Key? key , this.name , this.mysnapshot = -1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cid = 'categories';
    var did = 'TVOIfH9lJJdXbdfM6f3w';
    var cidii = name;
    if(mysnapshot != -1){
      cid='products';
      name = cid;
      did='9FQZdiMHArEXoiqFl9U4';
      cidii = 'new';
    }

      return Scaffold(
        body: FutureBuilder(
          future: FirebaseFirestore.instance.
            collection('$cid').
            doc('$did').
            collection('$cidii').
            get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.connectionState== ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              child: Column(
                children: [
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      IconButton(onPressed: () {
                        Navigator.pop(context);
                      },
                          icon: Icon(Icons.arrow_back,
                          color: Colors.black45,
                          )
                      ),
                      Text(name[0].toString().toUpperCase()
                          + name.toString().substring(1)
                        ,
                        style: TextStyle(
                          color: Colors.black26,
                          fontSize: 38,

                        ),),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      //height: 100,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 2,
                          childAspectRatio:0.8,
                          crossAxisSpacing: 1,
                        ),
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context , index)
                        => Column(
                          children: [
                            buildfeaturedrow(
                              snapshot.data!.docs[index]['productid'],
      snapshot.data!.docs[index]['image'],
      snapshot.data!.docs[index]['name'],
      snapshot.data!.docs[index]['price'],
                              context
    ),
                          ],
                        )
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        ),
      );
  }
}
