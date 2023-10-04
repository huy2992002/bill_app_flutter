import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../models/authen.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  _getAuthen() async {
    Authen.username = usernameController.text;
    Authen.password = passwordController.text;
    Authen.isLogin = false;
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
                'Register',
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
              const SizedBox(height: 20),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'Password',
                labelText: 'Confirm Password',
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
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else if (passwordController.text == '') {
                            const snackBar = SnackBar(
                              content: Text('Vui lòng nhập Password'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else if (confirmPasswordController.text == '') {
                            const snackBar = SnackBar(
                              content: Text('Vui lòng nhập Confirm Password'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else if (passwordController.text !=
                              confirmPasswordController.text) {
                            const snackBar = SnackBar(
                              content: Text(
                                  'Password và Confirm Password không trùng nhau'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else {
                            const snackBar = SnackBar(
                              content: Text('Tạo Tài Khoản Thành Công'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            
                            _getAuthen();
                            setState(() {
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(
                                      username: usernameController.text),
                                ),
                              );
                            });
                            
                          }
                        },
                        text: 'Next'),
                  ),
                  const Spacer(flex: 1),
                ],
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
