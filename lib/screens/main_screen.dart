import 'package:flutter/material.dart';
import 'package:lockery_app/constants/routes.dart';
import 'package:lockery_app/enums/menu_actions.dart';
import 'package:lockery_app/screens/lockeries/lockers.dart';
import 'package:lockery_app/services/auth/auth_service.dart';
import 'dart:developer' as devtools show log;

import 'package:lockery_app/utils/dialogs/log_out_dialog.dart';

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
            icon: const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Icon(Icons.person, color: Colors.black),
            ),
          )
        ],
        title: const Text(
          'Hi',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 185, 185, 185),
      ),
      body: Column(
        children: [
          // QR Code Button
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(qrRoute);
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 64, 44, 151),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(
                    Icons.qr_code,
                    size: 50,
                    color: Colors.white,
                  ),
                  Column(
                    children: const [
                      // Click here to generate your
                      Text(
                        'Click here to generate your',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      // QR Code
                      Text(
                        'QR Code',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Lockers(),
          ),
        ],
      ),
    );
  }
}
