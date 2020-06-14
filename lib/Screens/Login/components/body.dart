import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/components/background.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/Screens/Home/home_screen.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
//  const Body({
//    Key key,
//  }) : super(key: key);
  bool _rememberMe = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _email, _password;

  Future<void> signInEmail() async {
    final formState = _formKey.currentState;

    //email validation method
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult authResult = (await _auth.signInWithEmailAndPassword(
            email: _email, password: _password));
        if (authResult != null) {
          FirebaseUser user = authResult.user;
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => HomeScreen(user: user)));
        }
      } catch (e) {
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Your Email",
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Provide an email';
                  }
                  return null;
                },
                onChanged: (input) => _email = input.trim(),
              ),
              RoundedPasswordField(
                validator: (input) {
                  if (input.isEmpty) {
                    return 'Provide a password';
                  }
                  return null;
                },
                onChanged: (input) => _password = input.trim(),
              ),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  signInEmail();
                  print("email:$_email" " password:$_password");
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
