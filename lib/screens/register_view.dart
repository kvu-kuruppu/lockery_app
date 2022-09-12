import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lockery_app/constants/routes.dart';
import 'package:lockery_app/services/auth/auth_exceptions.dart';
import 'package:lockery_app/services/auth/auth_service.dart';

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
  final _formKey = GlobalKey<FormState>();

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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 87, 127, 160),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            height: 150,
            padding: const EdgeInsets.only(top: 40),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 87, 127, 160),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(150),
                bottomRight: Radius.circular(150),
              ),
            ),
            child: const Text(
              'Create New Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 30,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // First name and last name
                  Row(
                    children: [
                      Flexible(
                        // First Name
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'First Name',
                          ),
                          validator: (val) => val!.isEmpty ? 'requied*' : null,
                          controller: _firstName,
                        ),
                      ),
                      const SizedBox(
                        width: 20.0,
                      ),
                      Flexible(
                        // Last Name
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Last Name',
                          ),
                          validator: (val) => val!.isEmpty ? 'requied*' : null,
                          controller: _lastName,
                        ),
                      ),
                    ],
                  ),
                  // Date Of Birth
                  TextFormField(
                    controller: dateinput,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      suffixIcon: Icon(Icons.calendar_month),
                    ),
                    validator: (val) => val!.isEmpty ? 'requied*' : null,
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
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email address',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    validator: (val) => val!.isEmpty ? 'requied*' : null,
                  ),
                  // Password
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Create a Password',
                    ),
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    validator: (val) => (val!.isEmpty && val.length < 5)
                        ? 'Enter a password with more than 6 characters'
                        : null,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Sign Up Button
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 0, 132, 255),
                    ),
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      if (_formKey.currentState!.validate()) {
                        try {
                          final userCredential =
                              await AuthService.firebase().register(
                            email: email,
                            password: password,
                          );
                          devtools.log(userCredential.toString());
                          await showErrorDialog(
                            context,
                            'Registration Successful !\nYou can log in now.',
                          ).then(
                            (value) {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  loginRoute, (route) => false);
                            },
                          );
                        } on InvalidEmailAuthException {
                          await showErrorDialog(
                            context,
                            'Invalid email',
                          );
                        } on WeakPasswordAuthException {
                          await showErrorDialog(
                            context,
                            'Weak password',
                          );
                        } on EmailAlreadyUsedAuthException {
                          await showErrorDialog(
                            context,
                            'Email already in use',
                          );
                        } on GenericAuthException {
                          await showErrorDialog(
                            context,
                            'Failed to register',
                          );
                        }
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
          ),
        ],
      ),
    );
  }
}
