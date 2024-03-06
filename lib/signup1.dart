import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class SignupOnePage extends StatelessWidget {
  static const String path = "lib/src/pages/login/signup1.dart";

  const SignupOnePage({Key? key});

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: ListView(
        children: <Widget>[
          SizedBox(height: 30.0),
          CircleAvatar(
            maxRadius: 50,
            backgroundColor: Colors.transparent,
            child: Icon(Icons.person, size: 50, color: Colors.blue),
          ),
          SizedBox(height: 20.0),
          _buildLoginForm(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  Container _buildLoginForm(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Container(
              height: 400,
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
                        controller: _emailController,
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
                          // You can add more email validation logic here
                          return null;
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                      child: Divider(
                        color: Colors.blue.shade400,
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
                      child: Divider(
                        color: Colors.blue.shade400,
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
                      child: Divider(
                        color: Colors.blue.shade400,
                      ),
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
                child: Icon(Icons.person),
              ),
            ],
          ),
          SizedBox(
            height: 420,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, perform signup logic here
                  }
                },
                child: Text("Sign Up", style: TextStyle(color: Colors.white70)),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPageContent(context);
  }
}
