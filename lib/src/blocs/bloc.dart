import 'dart:async';
import 'validators.dart'; //mixin validate methods to stream below

class Bloc extends Object with Validators {
  // Controllers
  final _email = new StreamController<String>();
  final _password = new StreamController<String>();

  // Getters
  // Change Data
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  // Add Data to Stream
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);

  // Clean-up methods
  dispose() {
    _email.close();
    _password.close();
  }
}

final bloc = Bloc();
