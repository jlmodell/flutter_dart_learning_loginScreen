import 'dart:async';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'validators.dart'; //mixin validate methods to stream below

class Bloc extends Object with Validators {
  // Controllers
  final _email = new BehaviorSubject<String>();
  final _password = new BehaviorSubject<String>();
  final _passwordTwo = new BehaviorSubject<String>();
  final _login = 'https://busse-nestjs-api.herokuapp.com/users/login';
  final _register = 'https://busse-nestjs-api.herokuapp.com/users/register';
  String token;

  // Getters
  // Change Data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changePasswordTwo => _passwordTwo.sink.add;

  // Add Data to Stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<String> get passwordTwo =>
      _passwordTwo.stream.transform(validatePassword).doOnData((String c) {
        // if the password is accepted (after validation rules), we need to
        // ensure both password & retyped password match
        if (0 != _password.value.compareTo(c)) {
          _passwordTwo.addError("Passwords do not match.");
        }
      });

  // Login Screen
  Stream<bool> get loginValid =>
      Observable.combineLatest2(email, password, (e, p) => true);

  // Register Screen
  Stream<bool> get confirmPassword => Observable.combineLatest2(
      password, passwordTwo, (p1, p2) => (0 == p1.compareTo(p2)));
  Stream<bool> get registerValid => Observable.combineLatest3(
      email, password, confirmPassword, (e, p, c) => true);

  login() async {
    final validEmail = _email.value;
    final validPassword = _password.value;

    var body = {
      "email": "$validEmail",
      "password": "$validPassword",
    };

    var res = await http.post(
      _login,
      body: body,
    );

    // final token = json.decode(res.body)['token'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', json.decode(res.body)['token']);
  }

  printToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token' ?? '');
    print("$token");
  }

  register() async {
    final validEmail = _email.value;
    final validPassword = _password.value;

    var body = {
      "email": "$validEmail",
      "password": "$validPassword",
    };

    var res = await http.post(
      _register,
      body: body,
    );

    print(res.body);
  }

  // Clean-up methods
  dispose() {
    _email.close();
    _password.close();
  }
}

final bloc = Bloc();
