import 'package:ecommerce/Screens/sign-in.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetohome();
  }
  _navigatetohome()async{
    await Future.delayed(const Duration(milliseconds:2000 ),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.deepPurple,
        body: Center(
          child: Container(
            child: const Text('Goods2You',
                style: TextStyle(color: Colors.white,
                  fontSize: 35,
                  fontFamily: 'Pacifico',)
            ),
          ),
        ),
    );
  }
}
