import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:odds_social_media/screens/login_screen.dart';
import 'package:odds_social_media/widgets/text_feild_input.dart';

import '../resources/auth_methods.dart';
import '../utils/util.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text);

    if (res != 'success') {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void NavigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            //svg image
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              height: 100,
            ),
            //email
            const SizedBox(
              height: 64,
            ),
            //text feild input for username
            TextFieldInput(
                hintText: 'Enter your username',
                textEditingController: _usernameController,
                textInputType: TextInputType.text),
            const SizedBox(
              height: 24,
            ),

            //text feild  email
            TextFieldInput(
                hintText: 'Enter your email',
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 24,
            ),
            //password box

            TextFieldInput(
              hintText: 'Enter your password',
              textEditingController: _passwordController,
              textInputType: TextInputType.text,
              ispass: true,
            ),
            const SizedBox(
              height: 24,
            ),

            TextFieldInput(
                hintText: 'Enter your bio',
                textEditingController: _bioController,
                textInputType: TextInputType.text),
            const SizedBox(
              height: 24,
            ),

            //login button
            InkWell(
              onTap: signUpUser,
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Signup'),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                    color: blueColor),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            //transition to signup
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text('not yet here?'),
                  padding: const EdgeInsets.symmetric(
                    vertical: 0,
                  ),
                ),
                GestureDetector(
                  onTap: NavigateToLogin,
                  child: Container(
                    child: const Text(
                      'login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
