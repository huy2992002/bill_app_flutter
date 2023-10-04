import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_text_field.dart';
import '../models/authen.dart';
import 'login_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
                'Forgot Password',
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
                controller: newPasswordController,
                hintText: 'New Password',
                labelText: 'New Password',
                obscureText: true,
                icon: Icons.lock,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
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
                          } else if (usernameController.text != Authen.username) {
                            const snackBar = SnackBar(
                              content: Text('Username Không Tồn Tại'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else if (newPasswordController.text == '') {
                            const snackBar = SnackBar(
                              content: Text('Vui lòng nhập New Password'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else if (confirmPasswordController.text == '') {
                            const snackBar = SnackBar(
                              content: Text('Vui lòng nhập Confirm Password'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }else if(newPasswordController.text!=confirmPasswordController.text){
                            const snackBar = SnackBar(
                              content: Text('New Password và Confirm Password không trùng nhau'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }else {
                            const snackBar = SnackBar(
                              content: Text('Thay đổi mật khẩu thành công'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            setState(() {
                              Authen.password = newPasswordController.text;
                              Authen.saveData();
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
            ],
          ),
        ),
      ),
    );
  }
}
