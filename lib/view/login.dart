import 'package:employee_parking/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../controller/auth/login_controller.dart';
import '../helper/clipper.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final LoginController _controller = Get.put(LoginController());
  GlobalKey<FormState> formstate =
      GlobalKey<FormState>(debugLabel: '_homeScreenkey');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
                height: 280,
                child: ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    color: darkblue,
                    height: 200,
                  ),
                )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 80),
              child: Form(
                key: formstate,
                child: Column(
                  children: [
                    const Text('LOGIN to your account',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 50)),
                    const SizedBox(height: 100),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an email';
                        }
                        if (!_controller.isValidEmail(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      controller: _controller.emailController,
                      decoration: InputDecoration(
                        fillColor: lightgreen,
                        hintText: 'Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: deepdarkblue,
                        ),
                        hintStyle: TextStyle(color: deepdarkblue),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: deepdarkblue),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value!.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                      controller: _controller.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: lightgreen,
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: deepdarkblue,
                        ),
                        hintStyle: TextStyle(color: deepdarkblue),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: deepdarkblue),
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const Image(
                        image: AssetImage('assets/images/login.jpg'),
                        width: 300,
                      ),
                    ),
                    const SizedBox(height: 40),
                    MaterialButton(
                      onPressed: () async {
                        print("object");
                        if (formstate.currentState!.validate()) {
                          EasyLoading.show(
                              status: 'loading...',
                              maskType: EasyLoadingMaskType.black);
                          await _controller.signInWithEmailAndPassword();
                        }
                      },
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      color: darkblue,
                      minWidth: 300,
                      height: 50,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: AutofillHints.familyName,
                            fontSize: 25),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
