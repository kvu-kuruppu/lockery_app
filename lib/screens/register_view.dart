import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // late DateTime selectedDate;
  TextEditingController dateinput = TextEditingController();
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
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
      body: ListView(
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
                  children: const [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'First Name',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 10,
                // ),
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
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                ),
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
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 132, 255),
                  ),
                  onPressed: () {},
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
      ),
    );
  }
}
