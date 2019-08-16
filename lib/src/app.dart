import 'package:flutter/material.dart';
import 'screens/login_screen_bloc.dart';

class App extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      title: 'Login',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Busse Hospital Disposables'),
        ),
        body: LoginScreen(),
      ),
    );
  }
}
