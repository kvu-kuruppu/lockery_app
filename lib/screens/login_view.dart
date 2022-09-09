import 'package:flutter/material.dart';
import 'package:lockery_app/constants/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 185, 185, 185),
      body: ListView(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8),
                  BlendMode.dstATop,
                ),
                image: const AssetImage(
                  'assets/istockphoto-466487479-170667a.jpg',
                ),
              ),
            ),
            child: Center(
              child: Stack(
                children: [
                  // Stroked text as border.
                  Text(
                    'Lockery',
                    style: TextStyle(
                      fontSize: 70,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 6
                        ..color = Colors.white,
                    ),
                  ),
                  // Solid text as fill.
                  const Text(
                    'Lockery',
                    style: TextStyle(
                      fontSize: 70,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 40,
            ),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  controller: _password,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 132, 255),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SizedBox(
                      width: 140,
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                    Text('OR'),
                    SizedBox(
                      width: 140,
                      child: Divider(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      registerRoute,
                      // (route) => false,
                    );
                  },
                  child: const Text(
                    'Create New Account',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
