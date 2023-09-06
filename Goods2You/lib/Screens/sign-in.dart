import 'package:ecommerce/Screens/Items/color_item.dart';
import 'package:ecommerce/Screens/sign-up.dart';
import 'package:ecommerce/data_provider/remote_data/firebase_helper.dart';
import 'package:ecommerce/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Widgets/signin_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passcontroller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: LinearGradient(
            colors:[
              hexaStringToColor("9370DB"),
              Colors.deepPurple
            ],
            begin: Alignment.topCenter,end: Alignment.bottomCenter
        )),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  20,
                  125,
                  20,
                  0),

              child: Column(
                children: <Widget>[
                  logoWidget("assets/Images/avatar.png"),

                  const SizedBox(
                    height: 60,

                  ),
                  TextFormField(
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Email must not be null";
                      }
                      return null;
                    },
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      prefixIcon: Icon(Icons.email, color: Colors.white),
                    ),
                    onFieldSubmitted: (object) {
                      print(object);
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextFormField(
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return "Password must not be null";
                        }
                        return null;
                      },
                      controller: passcontroller,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        prefixIcon: Icon(Icons.lock, color: Colors.white),
                        suffixIcon: Icon(Icons.remove_red_eye_sharp),
                      ),
                      onFieldSubmitted: (object) {
                        print(object);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: signin,
                            child: Text(
                              "Sign In",
                              style: TextStyle(color: Colors.deepPurple,fontWeight:FontWeight.bold,fontSize: 20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  signUpOption()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Row signUpOption (){
    return Row(
      mainAxisAlignment:MainAxisAlignment.center ,
      children: [
        const Text(
          "Don't have an account ? ",
          style: TextStyle(
              fontSize: 20,
              color: Colors.white70
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
          },
          child:const Text(

            "Sign Up",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
  void signin() async{
    if(formKey.currentState!.validate())
    {
      showDialog(context: context,
          builder:(context){
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await FirebaseHelper().Signin(emailcontroller.text.toString(), passcontroller.text.toString()).then((value) {
        if(value is User)
        {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainScreen()));
        }
        else if(value is String)
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
        }
      });
    }
  }
}