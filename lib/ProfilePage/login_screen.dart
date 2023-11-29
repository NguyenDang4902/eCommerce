import 'package:e_commerce_ui/ProfilePage/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isObscure = true;
  bool _isChecked = true;

  Widget passwordTextFieldDesign() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Password',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            height: 60,
            child: TextField(
              controller: passwordController,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: Colors.grey,
              obscureText: _isObscure,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter your Password',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(_isObscure
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_outlined),
                ),
                prefixIcon: const Icon(
                  Icons.lock_outlined,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      );

  Widget emailTextFieldDesign() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Email',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            height: 60,
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your Email',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.blue,
                  )),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              )),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  const Text(
                    'Sign in',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  emailTextFieldDesign(),
                  const SizedBox(height: 30),
                  passwordTextFieldDesign(),
                  Row(
                    children: [
                      Checkbox(
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                        checkColor: Colors.white,
                        value: _isChecked,
                      ),
                      const Text(
                        'Remember password',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                      },
                      child: Text(
                        'Login'.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'Don\'t have an Account ?',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ));
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
