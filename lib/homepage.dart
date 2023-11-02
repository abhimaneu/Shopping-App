import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/cart.dart';
import 'package:shoppingapp/categoriesall.dart';
import 'package:shoppingapp/checkout.dart';
import 'package:shoppingapp/databasefolder/firestoredatabase.dart';
import 'package:shoppingapp/detailsscreen.dart';
import 'package:shoppingapp/produt.dart';
import 'package:shoppingapp/search.dart';
import 'package:shoppingapp/signup.dart';
import 'package:shoppingapp/userprofile.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  var mysnapshot;
  int _index = 0;
  List<Widget> _widgetoptions = [homepage() , cart() , userprofile()];
  String pageid = "Home";
  @override
  Widget build(BuildContext context) {
    Widget buildcircleavatar(image){
      return CircleAvatar(
        backgroundImage: AssetImage(image),
        backgroundColor: Colors.white,
        maxRadius: 34,
      );
    }
    Widget buildfeaturedrow(image , name , price){
      return Container(
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
            )
          ],
        ),
      );
    }
    void _onitemtap(int index) {
      setState(() {
        if(index == 0) {
          pageid = "Home";
        }
        else if(index == 1) {
          pageid = "Cart";
        }
        else {
          pageid = "Profile";
        }
        _index = index;
      });
    }

    final GlobalKey<ScaffoldState> keytoscaffold = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: keytoscaffold,
      bottomNavigationBar: Container(
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.only(
        //     topRight: Radius.circular(15),
        //     topLeft: Radius.circular(15)
        //   )
        // ),
        margin: EdgeInsets.symmetric(
            vertical: 0,
          horizontal: 0
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
             Radius.circular(15),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                label: "",
                  icon: Icon(Icons.home)
              ),
              BottomNavigationBarItem(
                label: "",
                  icon: Icon(Icons.shopping_cart_outlined)
              ),
              BottomNavigationBarItem(
                label: "",
                  icon: Icon(Icons.supervised_user_circle)
              )
            ],
            backgroundColor: Colors.black,
            fixedColor: Colors.white,
            unselectedItemColor: Colors.white24,
            currentIndex: _index,
            onTap: _onitemtap,
          ),
        ),
      ),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(15),
          )
        ),
        title: Text("$pageid",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: _index != 0 ? _widgetoptions[_index] : FutureBuilder(
        future: FirebaseFirestore.instance.collection('products').
          doc('9FQZdiMHArEXoiqFl9U4').
          collection('new').
          get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          mysnapshot = snapshot;
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                Column(
                    children: [
                      Container(
                        //color: Theme.of(context).backgroundColor,
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            GestureDetector(
                              onTap: () {
                                Databaseservices().getproductdata();
                                showSearch(context: context, delegate: Search()).whenComplete(() => datas = []);
                              },
                              child: Container(
                                //color: Colors.black45,
                                height: MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.97,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black26
                                  ),
                                  color: Colors.white30,
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: ListTile(
                                  title: Text("Search",
                                  style: TextStyle(
                                    color: Colors.black
                                  ),
                                  ),
                                  leading: Icon(Icons.search,
                                  color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Text("Categories",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12
                            ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder:
                                (_) => categoriesall() ));
                              },
                                child: Text("See all",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                    color: Colors.black45,
                                fontSize: 12)
                                  ,)
                            )
                            ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_)
                                    => product(
                                      name: 'shirts',
                                    )));
                                  },
                                    child: Column(
                                      children: [
                                        buildcircleavatar('images/cloth.png'),
                                      ],
                                    )
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_)
                                    => product(
                                      name: 'pants',
                                    )));
                                  },
                                    child: buildcircleavatar('images/trousers.png')
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_)
                                    => product(
                                      name: 'watches',
                                    )));
                                  },
                                    child: buildcircleavatar('images/watch.png')
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_)
                                    => product(
                                      name: 'shoes',
                                    )));
                                  },
                                    child: buildcircleavatar('images/shoes.png')
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("New Arrivals",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                                ),
                                ),
                                //SizedBox(width: MediaQuery.of(context).size.width/1.7,),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_)
                                     => product(
                                       mysnapshot: mysnapshot,
                                       ) ));
                                  },
                                    child: Text(" See All",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45,
                                      fontSize: 12
                                    ),
                                    )
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                                      return detailscreen(
                                        image: snapshot.data!.docs[0]['image'],
                                        name: snapshot.data!.docs[0]['name'],
                                        price: snapshot.data!.docs[0]['price'],
                                        productid: snapshot.data!.docs[0]['productid'],
                                      );
                                    }));
                                  },
                                  child: buildfeaturedrow(snapshot.data!.docs[0]['image'],
                                  snapshot.data!.docs[0]['name'],
                                  snapshot.data!.docs[0]['price']
                                  ),
                                ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return detailscreen(
                                image: snapshot.data!.docs[1]['image'],
                                name: snapshot.data!.docs[1]['name'],
                                price: snapshot.data!.docs[1]['price'],
                                productid: snapshot.data!.docs[1]['productid'],
                              );
                            }));
                          },
                          child: buildfeaturedrow(snapshot.data!.docs[1]['image'],
                              snapshot.data!.docs[1]['name'],
                              snapshot.data!.docs[1]['price']
                          ),
                        ),                          ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) {
                                  return detailscreen(
                                    image: snapshot.data!.docs[2]['image'],
                                    name: snapshot.data!.docs[2]['name'],
                                    price: snapshot.data!.docs[2]['price'],
                                    productid: snapshot.data!.docs[2]['productid'],
                                  );
                                }));
                              },
                              child: buildfeaturedrow(snapshot.data!.docs[2]['image'],
                                  snapshot.data!.docs[2]['name'],
                                  snapshot.data!.docs[2]['price']
                              ),
                            ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                                      return detailscreen(
                                        image: snapshot.data!.docs[3]['image'],
                                        name: snapshot.data!.docs[3]['name'],
                                        price: snapshot.data!.docs[3]['price'],
                                        productid: snapshot.data!.docs[3]['productid'],
                                      );
                                    }));
                                  },
                                  child: buildfeaturedrow(snapshot.data!.docs[3]['image'],
                                      snapshot.data!.docs[3]['name'],
                                      snapshot.data!.docs[3]['price']
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20,)
              ],
            ),
          );
        }
      )
    );
  }
}
