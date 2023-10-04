import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app_cuoiky1/pages/main_page.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../models/authen.dart';
import 'forgot_password_page.dart';
import 'home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  final String? username;
  const LoginPage({super.key, this.username});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _saveLogin();
    _getInformation();
    usernameController.text = widget.username ?? '';
  }

  Future<void> _getInformation() async {
    await Authen.loadData();
  }

  Future<void> _saveLogin() async {
    await Authen.loadData();
    if (Authen.isLogin == true) {
      Route route = MaterialPageRoute(
        builder: (context) => const HomePage(),
      );
      Navigator.push(context, route);
    }
  }

  _getAuthen() async {
    Authen.username = Authen.username;
    Authen.password = Authen.password;
    Authen.isLogin = true;
    await Authen.saveData();
    await Authen.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Login',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 35,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 80),
              CustomTextField(
                controller: usernameController,
                hintText: 'Username',
                labelText: 'Username',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                labelText: 'Password',
                obscureText: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 50),
              Row(
                children: [
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 2,
                    child: CustomButton(
                        onPressed: () {
                          if (usernameController.text == '') {
                            const snackBar = SnackBar(
                              content: Text('Vui lòng nhập Username'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (passwordController.text == '') {
                            const snackBar = SnackBar(
                              content: Text('Vui lòng nhập Password'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (usernameController.text !=
                              Authen.username) {
                            const snackBar = SnackBar(
                              content: Text('Nhập Sai Username'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (passwordController.text !=
                              Authen.password) {
                            const snackBar = SnackBar(
                              content: Text('Nhập Sai Password'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else if (usernameController.text ==
                                  Authen.username &&
                              passwordController.text == Authen.password) {
                            _getAuthen();

                            setState(() {
                              Route route = MaterialPageRoute(
                                builder: (context) => const MainPage(),
                              );
                              Navigator.pushAndRemoveUntil(
                                context,
                                route,
                                (Route<dynamic> route) => false,
                              );
                            });
                          }
                        },
                        text: 'Login'),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
              const SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  if (Authen.username == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  }
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                      color: (){
                        if (Authen.username == '') {
                          return Colors.red;
                        }else{
                          return Colors.grey.withOpacity(0.5);
                        }
                      }(),
                      
                      
                      fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordPage(),
                      ),
                    );
                  });
                },
                child: const Text(
                  'Forgot password',
                  style: TextStyle(color: Colors.blue, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
