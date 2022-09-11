import 'package:flutter/material.dart';
import 'package:lockery_app/screens/login_view.dart';
import 'package:lockery_app/screens/main_screen.dart';
import 'package:lockery_app/services/auth/auth_service.dart';

class HomePg extends StatelessWidget {
  const HomePg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 185, 185, 185),
      body: FutureBuilder(
          future: AuthService.firebase().initialize(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final user = AuthService.firebase().currentUser;
                if (user != null) {
                  return const MainScreen();
                } else {
                  return const LoginView();
                }
              default:
                return const Center(child: Text('Loading...'));
            }
          }),
    );
  }
}
