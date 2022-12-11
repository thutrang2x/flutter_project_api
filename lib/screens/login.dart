import 'package:encrypt/encrypt.dart';
import 'package:encrypt/encrypt_io.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_regis_provider/domain/user.dart';
import 'package:flutter_login_regis_provider/model/response/login_response.dart';
import 'package:flutter_login_regis_provider/providers/auth_provider.dart';
import 'package:flutter_login_regis_provider/providers/user_provider.dart';
import 'package:flutter_login_regis_provider/utility/validator.dart';
import 'package:flutter_login_regis_provider/utility/widgets.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController(text: "nguyenvan110");
  final _emailController = TextEditingController(text: "abc@gmail.com");
  final _passwordController = TextEditingController(text: "Vietnam@2022");

  String userName, password;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    void handleLogin() async {
      final form = formKey.currentState;

      print(_userNameController.text);
      print(_passwordController.text);

      final uName = _userNameController.text;
      final uPass = _passwordController.text;

      if (form.validate()) {
        form.save();
        auth.hanldeLoginUser(uName, uPass).then((value) {
          if (value.data.accountNo != null) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            Flushbar(
              title: "Failed Login",
              message: value.response.responseMessage,
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      }
    }

    ;

    var doLogin = () async {
      final form = formKey.currentState;

      print(_userNameController.text);
      print(_passwordController.text);

      final uName = _userNameController.text;
      final uPass = _passwordController.text;

      if (form.validate()) {
        form.save();

        final Future<Map<String, dynamic>> respose =
            auth.login(_userNameController.text, _passwordController.text);

        respose.then((response) {
          if (response['responseMessage'] == 'Success') {
            print(response);

            // User user = response['user'];

            //Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            Flushbar(
              title: "Failed Login",
              message: response['message']['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
      } else {
        Flushbar(
          title: 'Invalid form',
          message: 'Please complete the form properly',
          duration: Duration(seconds: 10),
        ).show(context);
      }
    };

    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Login ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          child: Text("Forgot password?",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
//            Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
        TextButton(
          child: Text("Sign up", style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/register');
          },
        ),
      ],
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Text("Username"),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: _userNameController,
                    onChanged: (value) => userName = value,
                    decoration:
                        buildInputDecoration('Enter Username', Icons.email),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text("Email"),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    autofocus: false,
                    controller: _emailController,
                    validator: validateEmail,
                    onChanged: (value) => _emailController.text = value,
                    decoration:
                        buildInputDecoration('Enter Email', Icons.email),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Password"),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    autofocus: false,
                    obscureText: true,
                    validator: (value) =>
                        value.isEmpty ? "Please enter password" : null,
                    onChanged: (value) => _passwordController.text = value,
                    decoration:
                        buildInputDecoration('Enter Password', Icons.lock),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),

                  longButtons('Login', () => handleLogin()),
                  // auth.loggedInStatus == Status.Authenticating
                  //     ? loading
                  //     : longButtons('Login', doLogin),

                  SizedBox(
                    height: 8.0,
                  ),
                  forgotLabel
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
