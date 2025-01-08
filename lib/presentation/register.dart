import 'package:flutter/material.dart';
import 'package:worldwalletnew/services/registrationApi.dart';

class Register extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
    final TextEditingController _namecontroller = TextEditingController();

final TextEditingController _placecontroller = TextEditingController();
  Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.deepPurple, Colors.blueAccent],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                _buildTextField(
                  controller: _usernameController,
                  icon: Icons.person,
                  label: 'Username',
                  obscureText: false,
                ), SizedBox(height: 30),
                _buildTextField(
                  controller: _namecontroller,
                  icon: Icons.person,
                  label: 'Name',
                  obscureText: false,
                ),
                SizedBox(height: 20),
                _buildTextField(
                  controller: _emailController,
                  icon: Icons.email,
                  label: 'Email',
                  obscureText: false,
                ),
                SizedBox(height: 20),
                _buildTextField(
                  controller: _passwordController,
                  icon: Icons.lock,
                  label: 'Password',
                  obscureText: true,
                ),
                SizedBox(height: 20),
                _buildTextField(
                  controller: _mobileController,
                  icon: Icons.phone,
                  label: 'Mobile',
                  obscureText: false,
                ),
                 SizedBox(height: 20),
                _buildTextField(
                  controller: _placecontroller,
                  icon: Icons.phone,
                  label: 'Place',
                  obscureText: false,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Map<String, String> data = {
                      'Name': _usernameController.text,
                      'Username': _usernameController.text,
                      'password': _passwordController.text,
                      'phone': _mobileController.text,
                      'place': _placecontroller.text,
                    };
                    registerFun(_emailController.text, data, context);
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back to login'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required bool obscureText,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        labelText: label,
        labelStyle: TextStyle(color: Colors.deepPurple),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      ),
    );
  }
}
