import 'package:flutter/material.dart';
import 'package:lockery_app/constants/routes.dart';
import 'package:lockery_app/screens/login_view.dart';
import 'package:lockery_app/screens/main_screen.dart';
import 'package:lockery_app/screens/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MaterialApp(
      home: const LoginView(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        mainRoute: (context) => const MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
