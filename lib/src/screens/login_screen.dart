import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final url = 'https://busse-nestjs-api.herokuapp.com/users/login';

  String email = '';
  String password = '';
  String token = '';

  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 20.0)),
            emailField(),
            passwordField(),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'you@example.com',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (!value.contains('@')) {
          return 'Please enter a valid email';
        }
        return null;
      },
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
      ),
      validator: (String value) {
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget submitButton() {
    return RaisedButton(
      onPressed: () async {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          var body = {
            "email": "$email",
            "password": "$password",
          };

          var res = await http.post(
            url,
            body: body,
          );

          token = json.decode(res.body)['token'];

          print(token);
        }
        return null;
      },
      child: Text('Submit'),
      color: Colors.blue[100],
    );
  }
}
