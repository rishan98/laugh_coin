import 'package:flutter/material.dart';
import 'package:laugh_coin/utils/connection.dart';
import 'package:laugh_coin/utils/preference.dart';
import 'package:laugh_coin/utils/toast.dart';
import 'package:laugh_coin/views/home_screen.dart';
import 'package:laugh_coin/views/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Connection connection = Connection();
  ShowToast toast = ShowToast();

  @override
  void initState() {
    super.initState();
    
    // Set a delay of 5 seconds
    Future.delayed(const Duration(seconds: 10), () {
      connection.check().then((internet) async {
        if (internet) {
          if (Preference.getString('token') != null &&
              Preference.getBool('login')!) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
        } else {
          toast.showToastError("No internet");
        }
      });
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 1, 17, 27),
              Color(0xFF0A3149),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/logo.jpeg'),
            ),
            const Text(
              'Laugh Coin',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            const CircularProgressIndicator(
              color: Color.fromARGB(255, 45, 189, 246),
            )
          ],
        )),
      ),
    );
  }
}
