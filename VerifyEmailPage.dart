import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_fitness_flutter_3_main/Register/auth_service.dart';
import 'package:workout_fitness_flutter_3_main/view/login/on_boarding_view.dart';

import '../common_widget/round_button.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
    _user?.reload(); // Refresh user data to get the latest email verification status
    if (_user != null && _user!.emailVerified) {
      // User is logged in and email is verified
      // Navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoardingView()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("A verification has been sent to your Email. Please Confirm your Email to continue"),
            ),
          ),

          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: RoundButton(title: "Send Again", type: RoundButtonType.primaryText, onPressed:() => AuthService().sendEmailVerification() ),
          ),
        ],
      ),
    );
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null && user.emailVerified) {
        // User is logged in and email is verified
        // Navigate to the next screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const OnBoardingView()),
        );
      }
    });
  }
}
