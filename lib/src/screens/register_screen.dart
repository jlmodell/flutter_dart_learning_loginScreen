import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../mixins/validation_mixins.dart';

class RegisterScreen extends StatefulWidget {
  createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final url = 'https://busse-nestjs-api.herokuapp.com/users/register';

  String email = '';
  String password = '';

  Widget build(context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text('Register'),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            emailField(),
            passwordFieldOne(),
            // passwordFieldTwo(),
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
            labelText: 'Email Address', hintText: 'you@example.com'),
        keyboardType: TextInputType.emailAddress,
        validator: validateEmail,
        onSaved: (String value) {
          email = value;
        });
  }

  Widget passwordFieldOne() {
    return TextFormField(
        obscureText: true,
        decoration: InputDecoration(labelText: 'Password'),
        validator: validatePassword,
        onSaved: (String value) {
          password = value;
        });
  }

  // Widget passwordFieldTwo() {
  //   return TextFormField(
  //       obscureText: true,
  //       decoration: InputDecoration(labelText: 'Confirm Password'),
  //       validator: (String value) {
  //         if (value != password) {
  //           return 'Passwords do not match';
  //         }

  //         return null;
  //       });
  // }

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

          print(json.decode(res.body));
        }

        return null;
      },
      child: Text('Register'),
      color: Colors.blue[100],
    );
  }
}
