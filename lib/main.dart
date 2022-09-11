import 'package:flutter/material.dart';
import 'package:lockery_app/constants/routes.dart';
import 'package:lockery_app/screens/login_view.dart';
import 'package:lockery_app/screens/main_screen.dart';
import 'package:lockery_app/screens/register_view.dart';
import 'package:lockery_app/utils/home_pg.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MaterialApp(
      home: const HomePg(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        mainRoute: (context) => const MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
