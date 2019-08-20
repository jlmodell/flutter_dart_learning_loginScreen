import 'package:flutter/material.dart';
import 'screens/login_screen_bloc.dart';
// import 'screens/register_screen_bloc.dart';
// import 'screens/learning_animation.dart';
import 'blocs/provider.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return Provider(
      child: MaterialApp(
        title: 'Login',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Busse Hospital Disposables'),
          ),
          body: LoginScreen(),
          // body: LearningAnimation(),
        ),
      ),
    );
  }
}
