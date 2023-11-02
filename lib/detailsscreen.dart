import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/cart.dart';
import 'package:shoppingapp/databasefolder/firestoredatabase.dart';

class detailscreen extends StatefulWidget {
  var productid;
  var image;
  var name;
  var price;
  detailscreen({Key? key , this.image , this.name , this.price , this.productid}) : super(key: key);

  @override
  State<detailscreen> createState() => _detailscreenState();
}

class _detailscreenState extends State<detailscreen> {
  List<bool> sized = [true,false,false,false];
  List<bool> colored = [true,false,false,false,false];
  int sizeindex = 0;
  int q = 1;
  var Size ;
  getsize() {
    if(sizeindex == 0) {
      Size = 'S';
    }
    else if(sizeindex == 1) {
      Size = 'M';
    }
    else if(sizeindex == 2) {
      Size = 'L';
    }
    else if(sizeindex == 3) {
      Size = 'XL';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
        Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height * 0.08 ,
          margin: EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 0.01
          ),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text( "₹ " + widget.price,
                  style: TextStyle(
                    color: Colors.white,
                      fontSize: 29
                  ),
                ),
              ),
              Container(
                //width: MediaQuery.of(context).size.width /2 ,
                child: TextButton(onPressed: () async {
                  getsize();
                  await Databaseservices().cartdata(
                      widget.productid,
                      widget.image,
                      widget.name,
                      widget.price,
                      Size,
                      q).then((value) => ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("$value"))));
                },
                    child: Text("Add to Cart",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    )),
              ),
            ],
          ),
        ),
      body: ListView(
        children: [
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.transparent,
              // borderRadius: BorderRadius.all(
              //   Radius.circular(15)
              // )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 400,
                  width: 400,
                  //color: Colors.black,
                  child: CarouselSlider(
                    options: CarouselOptions(
                        height: 400,
                    enableInfiniteScroll: false
                    ),
                    items: [widget.image].map((e) {
                      return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              child: Image.network(e,
                              fit: BoxFit.cover,
                              ),
                            );
                          } );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20,),
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text( "" + widget.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(" Your Size",
                        style: TextStyle(
                          fontSize: 14
                        ),
                        ),
                        SizedBox(height: 10,),
                        ToggleButtons(
                          borderColor: Colors.white,
                          color: Colors.black45,
                          selectedColor: Colors.black,
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          disabledBorderColor: Colors.white,
                          disabledColor: Colors.white,
                          selectedBorderColor: Colors.black,
                          children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 4.1,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                    "S",
                                ),
                              )
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4.1,
                              child: Align(
                                alignment: Alignment.center,
                                  child: Text("M")
                              )
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4.1,
                              child: Align(
                                  child: Text("L")
                              )
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 4.1,
                              child: Align(
                                alignment: Alignment.center,
                                  child: Text("XL")
                              )
                          ),
                          //Text("XXL")
                        ],
                          onPressed: (int index){
                            setState(() {
                              for(int indexb = 0 ; indexb < sized.length ; indexb++) {
                                if(indexb == index) {
                                  sized[indexb] = true;
                                }
                                else{
                                  sized[indexb] = false;
                                }
                              }
                              print(index);
                              print(sized);
                            });
                            setState(() {
                              sizeindex = index;
                            });
                          },
                          isSelected: sized,
                        ),
                        SizedBox(height: 20,),
                        Text(" Quantity",
                        style: TextStyle(
                          fontSize: 14
                        ),
                        ),
                        SizedBox(height: 4,),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove,
                              color: Colors.black45,
                              ),
                              onPressed: () {
                                setState(() {
                                  if(q>1) {
                                    q--;
                                  }
                                });
                              }
                              ,),
                            SizedBox(width: 1,),
                            Text(q.toString()),
                            SizedBox(width: 1,),
                            IconButton(
                                icon: Icon(Icons.add,
                                color: Colors.black45,
                                ),
                                onPressed: () {
                                  setState(() {
                                    q++;
                                  });
                                })
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Wrap(
                      children: [
                        Text(" sifnisafoafosojfosjf"
                            "smsmdsmssojfojf",
                        style: TextStyle(
                          fontWeight: FontWeight.w400
                        ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Row(),
                    SizedBox(height: 20,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
