import 'package:flutter/material.dart';
import '../../components/my_button.dart';
import '../../components/my_text_field.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      // Perform signup logic here

      // Show confirmation popup
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: IntrinsicHeight(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_outline_rounded, size: 55),
                    Text(
                      'Account Created',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Your account has been successfully created. Please log in with your new credentials.',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        // Navigate to login page with isNewSignup flag
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(isNewSignup: true),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  } // Add this closing brace for _signUp method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                      size: 72,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "BULK",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "Create new",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      "account",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 25),
                    MyTextField(
                      controller: _nameController,
                      hintText: "Name",
                      obscureText: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: _emailController,
                      hintText: "Email",
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: _passwordController,
                      hintText: "Password",
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: _confirmPasswordController,
                      hintText: "Confirm Password",
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    MyButton(
                      onTap: _signUp,
                      text: "SIGN UP",
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}