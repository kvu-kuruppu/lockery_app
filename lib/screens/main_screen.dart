import 'package:flutter/material.dart';
import 'package:lockery_app/enums/menu_actions.dart';
import 'package:lockery_app/services/auth/auth_service.dart';
import 'dart:developer' as devtools show log;
import 'package:lockery_app/utils/show_log_out_dialog.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 185, 185, 185),
      appBar: AppBar(
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogOut = await showLogOutDialog(context);
                  if (shouldLogOut) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login',
                      (_) => false,
                    );
                  }
                  devtools.log(shouldLogOut.toString());
                  break;
              }
            },
            itemBuilder: ((context) {
              return [
                const PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Center(child: Text('Log out')),
                ),
              ];
            }),
            icon: const Icon(Icons.person, color: Colors.black),
          )
        ],
        title: const Text(
          'Home',
          style: TextStyle(
              fontSize: 50, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 185, 185, 185),
      ),
      body: ListView(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              children: const [
                Text(
                  'Hey dude',
                  style: TextStyle(fontSize: 40),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
