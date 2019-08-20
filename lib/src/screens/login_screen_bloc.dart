import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import '../blocs/provider.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  Widget build(context) {
    final bloc = Provider.of(context);
    String token = '';

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          emailField(bloc),
          passwordField(bloc),
          Padding(padding: EdgeInsets.only(top: 30.0)),
          submitButton(bloc),
          Padding(padding: EdgeInsets.only(top: 30.0)),
          showToken(),
        ],
      ),
    );
  }

  Widget emailField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email Address',
            hintText: 'you@example.com',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget passwordField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.loginValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Login'),
          onPressed: snapshot.hasData ? bloc.login : null,
          color: Colors.blue[100],
        );
      },
    );
  }

  printToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token' ?? '');
    print(token);
  }

  showTokenButton() {
    return RaisedButton(
      child: Text('Show Token'),
      onPressed: printToken,
      color: Colors.red[200],
    );
  }

  Widget showToken() {
    return Container(
      child: Column(
        children: [
          showTokenButton(),
        ],
      ),
    );
  }
}
