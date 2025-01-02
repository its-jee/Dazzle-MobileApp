import 'package:flutter/material.dart';
import 'package:splash_screen_project/pages/home.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Luxurious light background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0), // Spacing for better layout
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with shadow effect
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/logo.png',
                  width: 250, // Logo size
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
              
              const SizedBox(height: 30),
              // Elegant welcome text
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Please login to continue',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(179, 75, 71, 71),
                ),
              ),
              const SizedBox(height: 30),
              
              // Phone number input
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter your Phone Number',
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 251, 251, 253),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                ),
              ),
              const SizedBox(height: 20),
              
              // Sign In Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  side: BorderSide(color: const Color.fromARGB(255, 14, 4, 97), width: 1.5),
                  shadowColor: const Color.fromARGB(255, 5, 36, 90).withOpacity(0.4),
                  elevation: 4,
                ),
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 3, 41, 79)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
