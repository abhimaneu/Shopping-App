import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shoppingapp/usereditpage.dart';

class userprofile extends StatefulWidget {
  userprofile({Key? key}) : super(key: key);

  @override
  State<userprofile> createState() => _userprofileState();
}

class _userprofileState extends State<userprofile> {
  int edit = 0;
  var uid;
  late XFile? _pickedimage;
  late PickedFile? _image;
  ImagePicker picker = ImagePicker();
  String imageUrl = '';
  late final _imagetemp;
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
  @override
  void initState() {
    super.initState();
    getuid();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getprofiledata(),
      builder: (context, snapsHot) {

        if(snapsHot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
            ),
          );
        }

        return StreamBuilder(
        stream: FirebaseFirestore.instance.
        collection('user').
        doc(FirebaseAuth.instance.currentUser?.uid).
        collection('userdetails').
        snapshots(),
            builder: (context , AsyncSnapshot<QuerySnapshot> snapshot)
        {

          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.data!.docs.length == 0) {
            return Center(
              child: IconButton(onPressed: () {
                setState(() {});
              },
                icon: Icon(
                    Icons.refresh_rounded
                ),),
            );
          }

          print(snapshot.data!.docs[0]['name']);

          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: imageUrl!="" ? NetworkImage(imageUrl): NetworkImage(
                      'https://images.unsplash.com/photo-1542909168-82c3e7fdca5c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZmFjZXxlbnwwfHwwfHw%3D&w=1000&q=80'),
                      maxRadius: 60,
                    ),
                    SizedBox(height: 20,),
                    ListTile(
                      title: Text("Name"),
                      trailing: Text(snapshot.data!.docs[0]['name']),
                    ),
                    SizedBox(height: 20,),
                    ListTile(
                      title: Text("Email id"),
                      trailing: Text(snapshot.data!.docs[0]['emailid']),
                    ),
                    SizedBox(height: 20,),
                    ListTile(
                      title: Text("Phone Number"),
                      trailing: Text(snapshot.data!.docs[0]['phonenumber']),
                    ),
                    SizedBox(height: 20,),
                    ListTile(),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width ,
                        height: MediaQuery.of(context).size.height * 0.072,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.push(context, MaterialPageRoute(builder: (_)
                               => usereditpage()));
                            });
                          },
                          child: Text("Edit Data",
                          style: TextStyle(
                            color: Colors.black
                          ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width ,
                        height: MediaQuery.of(context).size.height * 0.072,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              FirebaseAuth.instance.signOut();
                            });
                          },
                          child: Text("Sign Out",
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
    );
  }
}
