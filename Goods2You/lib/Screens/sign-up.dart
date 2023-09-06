import 'package:ecommerce/data_provider/remote_data/firebase_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'Items/color_item.dart';
import 'Widgets/signin_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passcontroller = TextEditingController();

  TextEditingController namecontroller = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(gradient: LinearGradient(
              colors:[
                hexaStringToColor("9370DB"),
                Colors.deepPurple
              ],begin: Alignment.topCenter,end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      20,
                      125,
                      20,
                      0),

                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 130,
                        ),
                        TextFormField(
                          controller: namecontroller,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Name must not be null";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            prefixIcon: Icon(Icons.person, color: Colors.deepPurple),
                          ),
                          onFieldSubmitted: (object) {
                            print(object);
                          },
                        ),

                        const SizedBox(
                          height: 30,
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
                            prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
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
                              prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                              suffixIcon: Icon(Icons.remove_red_eye_sharp),
                            ),
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
                                  onPressed:signup,
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(color: Colors.deepPurple,fontWeight:FontWeight.bold,fontSize: 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  )))

      ),
    );
  }
  void signup() async{
    if(formKey.currentState!.validate())
    {
      showDialog(context: context,
          builder:(context){
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
      await FirebaseHelper().Signup(emailcontroller.text.toString(), passcontroller.text.toString(), namecontroller.text.toString()).then((value) {
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