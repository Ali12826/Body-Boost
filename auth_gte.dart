import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_fitness_flutter_3_main/Register/VerifyEmailPage.dart';
import 'package:workout_fitness_flutter_3_main/main.dart';
import 'package:workout_fitness_flutter_3_main/view/login/on_boarding_view.dart';

import '../common/color_extension.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(_user != null && _user!.emailVerified){
              return const OnBoardingView();
            }else{
              return const VerifyEmail();
            }

          }else if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator(color: TColor.primary,);
          }else{
            return LoginCard();
          }
        },
      ),
    );
  }
}
