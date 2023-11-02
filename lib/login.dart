import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoppingapp/signup.dart';

class login extends StatefulWidget {
  const login({Key? key , required this.toggle}) : super(key: key);

  final Function() toggle;

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool showpasswords = true;
  changepasswords() {
    showpasswords = !showpasswords;
  }
  void validation() async {
    final FormState? _form = _formkey.currentState;
    if(_form!.validate()){
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email!, password: password!);
      }
      on FirebaseAuthException catch (e) {
        print(e.message);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${e.message}"))
        );
      }
    }
    else{
      print("No");
    }
  }
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
                  child: Text("Login",
                    style: TextStyle(
                      color: Colors.black26,
                        fontSize: 74
                    ),
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
                        FocusScope.of(context).unfocus();
                      },
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            changepasswords();
                          });
                        },
                        icon: Icon(Icons.visibility) , color: Colors.black,),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10,),
                TextButton(onPressed: () {validation();},
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      fontSize: 19
                    ),
                    primary: Colors.black,
                  ),
                    child: Text("Login"),),
                SizedBox(height: 0,),
                TextButton(onPressed: () {
                  widget.toggle();
                },
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 16
                      ),
                      primary: Colors.black
                    ),
                    child: Text("Click here to Register")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
