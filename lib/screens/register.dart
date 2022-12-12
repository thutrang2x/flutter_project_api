import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_login_regis_provider/domain/user.dart';
import 'package:flutter_login_regis_provider/providers/auth_provider.dart';
import 'package:flutter_login_regis_provider/providers/user_provider.dart';
import 'package:flutter_login_regis_provider/utility/validator.dart';
import 'package:flutter_login_regis_provider/utility/widgets.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  final formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController(text: "nguyenvan110");
  final _fullNameController = TextEditingController(text: "Nguyen Thi Thu A");
  final _emailController = TextEditingController(text: "abc@gmail.com");
  final _phoneController = TextEditingController(text: "0987985469");
  final _identityNumber = TextEditingController(text: "798741654321");
  final _passwordController = TextEditingController(text: "Vietnam@2022");
  final _passwordControllerConfirm =
      TextEditingController(text: "Vietnam@2022");

  String userName, fullName, email, phone, indentity, password, confirmPassword;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    
    void handleRegister() async {
      final form = formKey.currentState;

      final uName = _userNameController.text;

      final uPass = _passwordController.text;

      if (form.validate()) {
        form.save();
        auth.hanldeRegisterUser(uName, uPass).then((value) {
          if (value.data.userId != null) {
            Navigator.pushReplacementNamed(context, '/login');
          } else {
            Flushbar(
              title: "Failed Register",
              message: value.response.responseMessage,
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
    }

    ;

    final loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );

    var doRegister = () {
      print('on doRegister');

      final form = formKey.currentState;
      if (form.validate()) {
        form.save();

        auth.loggedInStatus = Status.Authenticating;
        auth.notify();

        Future.delayed(loginTime).then((_) {
          Navigator.pushReplacementNamed(context, '/login');
          auth.loggedInStatus = Status.LoggedIn;
          auth.notify();
        });

        /*// now check confirm password
        if(_password.endsWith(_confirmPassword)){

          auth.register(_username, _password).then((response) {
            if(response['status']){
              User user = response['data'];
              Provider.of<UserProvider>(context,listen: false).setUser(user);
              Navigator.pushReplacementNamed(context, '/login');
            }else{
              Flushbar(
                title: 'Registration fail',
                message: response.toString(),
                duration: Duration(seconds: 10),
              ).show(context);
            }
          });

        }else{
          Flushbar(
            title: 'Mismatch password',
            message: 'Please enter valid confirm password',
            duration: Duration(seconds: 10),
          ).show(context);
        }*/
      } else {
        Flushbar(
          title: 'Invalid form',
          message: 'Please complete the form properly',
          duration: Duration(seconds: 10),
        ).show(context);
      }
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
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
                Text('Username'),
                TextFormField(
                  controller: _userNameController,
                  autofocus: false,
                  onChanged: (value) => userName = value,
                  decoration: buildInputDecoration(
                      "Enter UserName", Icons.e_mobiledata),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text('FullName'),
                TextFormField(
                  controller: _fullNameController,
                  autofocus: false,
                  onChanged: (value) => fullName = value,
                  decoration: buildInputDecoration(
                      "Enter FullName", Icons.e_mobiledata),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text('Email'),
                TextFormField(
                  autofocus: false,
                  controller: _emailController,
                  validator: validateEmail,
                  onChanged: (value) => _emailController.text = value,
                  decoration: buildInputDecoration('Enter Email', Icons.email),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text('PhoneNumber'),
                TextFormField(
                  controller: _phoneController,
                  autofocus: false,
                  onChanged: (value) => phone = value,
                  decoration: buildInputDecoration(
                      "Enter PhoneNumber", Icons.e_mobiledata),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text('CMND/CCCD'),
                TextFormField(
                  controller: _identityNumber,
                  autofocus: false,
                  onChanged: (value) => indentity = value,
                  decoration: buildInputDecoration(
                      "Enter CMND/CCCD", Icons.e_mobiledata),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('Password'),
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
                Text('Confirm Password'),
                TextFormField(
                  controller: _passwordControllerConfirm,
                  autofocus: false,
                  obscureText: true,
                  validator: (value) =>
                      value.isEmpty ? 'Your password is required' : null,
                  onChanged: (value) => confirmPassword = value,
                  decoration: buildInputDecoration(
                      "Enter Confirm Password", Icons.lock),
                ),
                SizedBox(
                  height: 20.0,
                ),
                // auth.loggedInStatus == Status.Authenticating
                //     ? loading
                //     : longButtons('Register', doRegister)

                longButtons('Register', () => handleRegister()),
                // auth.loggedInStatus == Status.Authenticating
                //     ? loading
                //     : longButtons('Login', doLogin),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
