import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lockery_app/constants/routes.dart';
import 'package:lockery_app/firebase_options.dart';

import 'dart:developer' as devtools show log;

import 'package:lockery_app/utils/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController dateinput = TextEditingController();
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    dateinput.text = '';
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
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 30),
                    height: 200,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 87, 127, 160),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(150),
                        bottomRight: Radius.circular(150),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        'Create New Account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 30,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: TextField(
                                decoration: const InputDecoration(
                                  labelText: 'First Name',
                                ),
                                controller: _firstName,
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Flexible(
                              child: TextField(
                                decoration: const InputDecoration(
                                  labelText: 'Last Name',
                                ),
                                controller: _lastName,
                              ),
                            ),
                          ],
                        ),
                        // Date Of Birth
                        TextField(
                          controller: dateinput,
                          decoration: const InputDecoration(
                            labelText: 'Date of Birth',
                            suffixIcon: Icon(Icons.calendar_month),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1996),
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy/MM/dd').format(pickedDate);
                              setState(
                                () {
                                  dateinput.text = formattedDate;
                                },
                              );
                            }
                          },
                        ),
                        // Email Address
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Email address',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          controller: _email,
                        ),
                        // Password
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Create a Password',
                          ),
                          controller: _password,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Sign Up Button
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 0, 132, 255),
                          ),
                          onPressed: () async {
                            final email = _email.text;
                            final password = _password.text;
                            try {
                              final userCredential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: email,
                                password: password,
                              );
                              devtools.log(userCredential.toString());
                              await showErrorDialog(
                                context,
                                'Registration Successfull',
                              ).then(
                                (value) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      loginRoute, (route) => false);
                                },
                              );
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'invalid-email') {
                                await showErrorDialog(
                                  context,
                                  'Invalid email',
                                );
                              } else if (e.code == 'weak-password') {
                                await showErrorDialog(
                                  context,
                                  'Weak password',
                                );
                              } else if (e.code == 'email-already-in-use') {
                                await showErrorDialog(
                                  context,
                                  'Email already in use',
                                );
                              } else {
                                await showErrorDialog(
                                  context,
                                  'Error: ${e.code}',
                                );
                              }
                            } catch (e) {
                              await showErrorDialog(
                                context,
                                e.toString(),
                              );
                            }
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            default:
              return const Center(child: Text('Loading...'));
          }
        },
      ),
    );
  }
}
