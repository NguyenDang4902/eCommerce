import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _isObscure = true;

  void signup(String email, password) async {
    try {
      Response response = await post(
          Uri.parse('https://62d7812d51e6e8f06f1d61ef.mockapi.io/api/v1/Accounts'),
          body: {
            'email' : email,
            'password' : password
          }
      );
      if (response.statusCode == 201) {
        print('Account created successful');
      } else {
        print('Account duplicated! Please use another email');
      }
    } catch(e) {
      print(e.toString());
    }
  }

  Widget passwordTextFieldDesign(String text, TextEditingController controller) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        text,
        style: TextStyle(color: Colors.black, fontSize: 15),
      ),
      const SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        height: 60,
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.visiblePassword,
          cursorColor: Colors.grey,
          obscureText: _isObscure,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Enter your Password',
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
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
          decoration: const InputDecoration(
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
                    'Sign up',
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
                  passwordTextFieldDesign('Password', passwordController),
                  const SizedBox(height: 30),
                  passwordTextFieldDesign('Confirm Password', confirmPasswordController),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: (){
                        if (passwordController.text.toString() == confirmPasswordController.text.toString()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Test - OK',
                                ),

                              )
                          );
                          signup(emailController.text.toString(), passwordController.text.toString());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Password\'s not match. Re-enter password again.',
                                ),
                              )
                          );
                        }
                      },
                      child: Text(
                        'Sign up'.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold
                        ),
                      ),
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
