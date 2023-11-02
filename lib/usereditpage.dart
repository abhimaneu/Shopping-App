import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppingapp/databasefolder/firestoredatabase.dart';

class usereditpage extends StatefulWidget {
  const usereditpage({Key? key}) : super(key: key);

  @override
  State<usereditpage> createState() => _usereditpageState();
}

class _usereditpageState extends State<usereditpage> {
  var uid;
  late XFile? _pickedimage;
  late PickedFile? _image;
  ImagePicker picker = ImagePicker();
  String imageUrl = '';
  late final _imagetemp;
  final controller1 = TextEditingController();
  final controller2 = TextEditingController();
  String? name;
  String? emailid;
  String? number;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isimage = false;
  Future getuid() async {
    uid = await FirebaseAuth.instance.currentUser?.uid;
  }
  Future getimage(ImageSource source) async {
    _pickedimage = await picker.pickImage(source: source);
    if(_pickedimage != null) {
      _imagetemp = File(_pickedimage!.path);
      print(_imagetemp);
      isimage = true;
      uploadimage(image: _imagetemp);
      setState(() {});
    }
    return ;
  }

  Future getdialog() {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text("From Camera"),
                    onTap: () {
                      getimage(ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.photo),
                    title: Text("From Gallery"),
                    onTap: () {
                      getimage(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
  Future getprofiledata() async {
    User user = await FirebaseAuth.instance.currentUser!;
    Reference storageref = FirebaseStorage.instance.ref().child("userimage/${user.uid}/${user.uid}/");
    imageUrl = await storageref.getDownloadURL() as String;
    //return imageUrl;
  }

  Future uploadimage({required File image}) async {
    User user = await FirebaseAuth.instance.currentUser!;
    Reference storageref = FirebaseStorage.instance.ref().child("userimage/${user.uid}/${user.uid}/");
    UploadTask uploadtask = storageref.putFile(image);
    final storagesnapshot = await uploadtask.whenComplete(() async =>
    imageUrl = await storageref.getDownloadURL() as String
    );
    setState(() {});
  }
  void validatedata() async {
    final FormState? _form = _formkey.currentState;
    if(controller1 != "" && controller2 != "") {
      try{
        await Databaseservices().changedata(controller1.text , controller2.text);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
        );
      }
    }
    else {
      print("n");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _formkey,
      body: FutureBuilder(
        future: getprofiledata(),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return FutureBuilder(
            future: FirebaseFirestore.instance.
              collection('user').
              doc(FirebaseAuth.instance.currentUser?.uid).
              collection('userdetails').
              get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {

              if(snapShot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              controller1.text = snapShot.data!.docs[0]['name'];
              controller2.text = snapShot.data!.docs[0]['phonenumber'];

              return Scaffold(
                body: SingleChildScrollView(
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(height: 40,),
                          Row(
                            children: [
                              Text("Edit ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19
                              ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2,),
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200)
                            ),
                            color: Colors.white30,
                            child: CircleAvatar(
                              backgroundImage: imageUrl != '' ? NetworkImage(imageUrl) : NetworkImage('https://img.freepik.com/free-photo/pleasant-looking-serious-man-stands-profile-has-confident-expression-wears-casual-white-t-shirt_273609-16959.jpg?w=2000'),
                              maxRadius: 60,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(85, 85, 0, 0),
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(30)
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        getdialog();
                                      },
                                      child: Icon(Icons.edit,
                                          color: Colors.black45
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start ,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(" Name",
                            style: TextStyle(
                              fontSize: 16
                            ),
                            ),
                          SizedBox(height: 4,),
                          TextFormField(
                            //initialValue: snapShot.data!.docs[0]['name'],
                            controller: controller1,
                            onChanged: (value) {
                              name = value;
                            },
                            validator: (value) {
                              if(value == "") {
                                return "Name Cannot be Emptty";
                              }
                            },
                            decoration: InputDecoration(
                              //label: Text("Name"),
                                border: OutlineInputBorder(),
                                hintText: snapShot.data!.docs[0]['name']
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text("Email Id",
                          style: TextStyle(
                              fontSize: 16
                          ),
                          ),
                          SizedBox(height: 4,),
                          TextFormField(
                            enabled: false,
                            initialValue: snapShot.data!.docs[0]['emailid'],
                            onChanged: (value) {
                              emailid = value;
                            },
                            validator: (value) {
                              if(value == "") {
                                return "";
                              }
                            },
                            decoration: InputDecoration(
                              //label: Text("Email"),
                                border: OutlineInputBorder(),
                                hintText: snapShot.data!.docs[0]['emailid']
                            ),
                          ),
                          SizedBox(height: 20,),
                          Text("Phone Number",
                            style: TextStyle(
                                fontSize: 16
                            ),),
                          SizedBox(height: 4,),
                          TextFormField(
                            //initialValue: snapShot.data!.docs[0]['phonenumber'],
                            controller: controller2,
                            onChanged: (value) {
                              number = value;
                            },
                            validator: (value) {
                              if(value == "") {
                                return "Number cannot be Empty";
                              }
                            },
                            //controller: controller2,
                            decoration: InputDecoration(
                              //label: Text("Phone Number"),
                                border: OutlineInputBorder(),
                                hintText: snapShot.data!.docs[0]['phonenumber']
                            ),
                          ),
                          SizedBox(height: 20,),
                          ListTile(),
                          ],
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width ,
                              //height: MediaQuery.of(context).size.height * 0.072,
                              child: TextButton(
                                onPressed: () {
                                    validatedata();
                                    Navigator.pop(context);
                                },
                                child: Text("Save Data",
                                style: TextStyle(
                                  color: Colors.black
                                ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                ),
              );
            }
          );
        }
      ),
    );
  }
}
