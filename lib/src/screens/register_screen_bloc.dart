import 'package:flutter/material.dart';
import '../blocs/bloc.dart';
import '../blocs/provider.dart';

class RegisterScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          emailField(bloc),
          passwordField(bloc),
          passwordTwoField(bloc),
          Padding(padding: EdgeInsets.only(top: 30.0)),
          submitButton(bloc),
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
            labelText: "Email Address",
            hintText: 'you@busseinc.com',
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
            labelText: "Password",
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget passwordTwoField(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordTwo,
      builder: (context, snapshot) {
        return TextField(
            onChanged: bloc.changePasswordTwo,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Confirm Password",
              errorText: snapshot.error,
            ));
      },
    );
  }

  Widget submitButton(Bloc bloc) {
    return StreamBuilder(
        stream: bloc.registerValid,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Text('Register'),
            onPressed: snapshot.hasData ? bloc.register : null,
            color: Colors.green[100],
          );
        });
  }
}
