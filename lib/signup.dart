import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppingapp/databasefolder/firestoredatabase.dart';

class signUp extends StatefulWidget {
  const signUp({Key? key , required this.toggle}) : super(key: key);

  final Function() toggle;

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  bool showpasswords = true;
  changepasswords() {
    showpasswords = !showpasswords;
  }
  void validation() async {
    final FormState? _form = _formkey.currentState;
    if(_form!.validate()){
      try{
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text("Please Wait"),
            ),
          );
        }));
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
        Databaseservices().addusersinfo(
          name,
          email,
          phonenumber
        );

        Navigator.pop(context);
      }
      on FirebaseAuthException catch (e) {
        print(e.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${e.message}")),
        );
      }
    }
    else{
      print("No");
    }
  }
  String? name;
  String? phonenumber;
  String? email;
  String? password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width ,
                  child: Text("Register",
                  style: TextStyle(
                    color: Colors.black26,
                      fontSize: 74
                  ),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  onChanged:(value) {
                    name = value;
                  },
                  validator: (value){
                    if(value == " "){
                      return "Enter Username";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Username",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  onChanged: (value){
                    email = value;
                  },
                  validator: (value){
                    if(value == ""){
                      return "Enter Email";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  onChanged: (value){
                    password = value;
                  },
                  validator: (value){
                    if(value == ""){
                      return "Enter Password";
                    }
                    else if((value?.length)! < 8){
                      return "Password should be aleast 8 characters";
                    }
                  },
                  obscureText: showpasswords,
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          changepasswords();
                        });
                      },
                      child: Icon(Icons.visibility , color: Colors.black,),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  onChanged: (value) {
                    phonenumber = value;
                  },
                  validator: (value){
                    if(value == ""){
                      return "Enter phone number";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Phonenumber",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20,),
                TextButton(onPressed: () {print(email);
                  validation();
                  },
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 19
                      ),
                      primary: Colors.black
                    ),
                    child: Text("Register")),
                Text("Already have account?"),
                TextButton(onPressed: () {
                  widget.toggle();
                },
                    style: TextButton.styleFrom(
                      primary: Colors.black
                    ),
                    child: Text("Login")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
