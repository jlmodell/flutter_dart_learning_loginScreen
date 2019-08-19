import 'dart:async';
import '../blocs/provider.dart';

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (String input, sink) {
      if (input.contains('@busseinc.com')) {
        sink.add(input);
      } else {
        sink.addError('Enter a valid busse email address.');
      }
    },
  );

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (String input, sink) {
      if (input.length >= 6) {
        sink.add(input);
      } else {
        sink.addError('Check your password and try again.');
      }
    },
  );
}
