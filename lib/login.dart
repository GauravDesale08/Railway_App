import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:hack1/signup1.dart';

class LoginTwoPage extends StatelessWidget {
  static const String path = "lib/src/pages/login/login2.dart";

  const LoginTwoPage({required  key}) : super(key: key);

  Widget _buildPageContent(BuildContext context) {
    return Container(
      color: Colors.blue.shade100,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 100.0),
          // CircleAvatar(
          //   maxRadius: 50,
          //   backgroundColor: Colors.transparent,
          //   child: Icon(Icons.person, size: 50, color: Colors.blue),
          // ),
          SizedBox(height: 20.0),
          _buildLoginForm(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const SignupOnePage()));
                },
                child: const Text("Sign Up",
                    style: TextStyle(color: Colors.blue, fontSize: 18.0)),
              )
            ],
          )
        ],
      ),
    );
  }

  Container _buildLoginForm(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              height: 470,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 90.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.blue),
                        decoration: InputDecoration(
                          hintText: "Email address",
                          hintStyle: TextStyle(color: Colors.blue.shade200),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email address';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                      child: const Divider(
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        style: TextStyle(color: Colors.blue),
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.blue.shade200),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                      child: const Divider(
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        style: TextStyle(color: Colors.blue),
                        decoration: InputDecoration(
                          hintText: "Confirm password",
                          hintStyle: TextStyle(color: Colors.blue.shade200),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                      child: const Divider(
                        color: Colors.blue,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Forgot Password')),
                              );
                            },
                            child: const Text(
                              "Forgot Password",
                              style: TextStyle(color: Colors.black45),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.blue.shade600,
                child: const Icon(Icons.person),
              ),
            ],
          ),
          SizedBox(
            height: 460,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Valid Form. Perform action here.')),
                    );
                  }
                },
                child: const Text("Login", style: TextStyle(color: Colors.white70)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(context),
    );
  }
}
