import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lockery_app/constants/routes.dart';
import 'package:lockery_app/services/auth/auth_service.dart';
import 'package:lockery_app/utils/dialogs/error_dialog.dart';
import 'package:month_year_picker/month_year_picker.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController startDateinput = TextEditingController();
  TextEditingController endDateinput = TextEditingController();
  TextEditingController expiryDateinput = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLocked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 185, 185, 185),
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 185, 185, 185),
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          padding: const EdgeInsets.only(top: 10),
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 30,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Start Date
              TextFormField(
                controller: startDateinput,
                decoration: const InputDecoration(
                  labelText: 'Start Date',
                  suffixIcon: Icon(Icons.calendar_month),
                ),
                readOnly: true,
                validator: (val) => val!.isEmpty ? 'requied*' : null,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1996),
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    String formattedDate = DateFormat.yMd().format(pickedDate);
                    setState(
                      () {
                        startDateinput.text = formattedDate;
                      },
                    );
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              // End Date
              TextFormField(
                controller: endDateinput,
                decoration: const InputDecoration(
                  labelText: 'End Date',
                  suffixIcon: Icon(Icons.calendar_month),
                ),
                readOnly: true,
                validator: (val) => val!.isEmpty ? 'requied*' : null,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1996),
                      lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    String formattedDate = DateFormat.yMd().format(pickedDate);
                    setState(
                      () {
                        endDateinput.text = formattedDate;
                      },
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              // Amount
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  suffixIcon: Icon(Icons.monetization_on),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'requied*';
                  }
                  if (int.parse(val) < 80) {
                    return 'You have to pay 80\$';
                  }
                },
                // => val!.isEmpty ? 'requied*' : null,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              // Name on Card
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name on Card',
                ),
                validator: (val) => val!.isEmpty ? 'requied*' : null,
                // controller: _cardName,
              ),
              const SizedBox(
                height: 10,
              ),
              // Card Number
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  suffixIcon: Icon(Icons.credit_card),
                ),
                validator: (val) => val!.isEmpty ? 'requied*' : null,
                maxLength: 12,
                keyboardType: TextInputType.number,
                // controller: _cardName,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    // Expiry Date
                    child: TextFormField(
                      controller: expiryDateinput,
                      decoration: const InputDecoration(
                        labelText: 'End Date',
                        suffixIcon: Icon(Icons.calendar_month),
                      ),
                      readOnly: true,
                      validator: (val) => val!.isEmpty ? 'requied*' : null,
                      onTap: () async {
                        DateTime? pickedDate = await showMonthYearPicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1996),
                            lastDate: DateTime(2101));
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('MM/yy').format(pickedDate);
                          setState(
                            () {
                              expiryDateinput.text = formattedDate;
                            },
                          );
                        }
                      },
                    ),
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     labelText: 'Expiry Date',
                    //     suffixIcon: Icon(Icons.calendar_month),
                    //   ),
                    //   validator: (val) => val!.isEmpty ? 'requied*' : null,
                    // ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    // Security Code
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Security Code',
                        counterText: '',
                      ),
                      validator: (val) => val!.isEmpty ? 'requied*' : null,
                      maxLength: 3,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      // controller: _lastName,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              // Proceed to payment button
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 132, 255),
                ),
                onPressed: () async {
                  final userId = AuthService.firebase().currentUser!.id;
                  if (_formKey.currentState!.validate()) {
                    await FirebaseFirestore.instance
                        .collection('locker')
                        .where(
                          'user_id',
                          isEqualTo: userId,
                        )
                        .get()
                        .then((querySnapshot) {
                      querySnapshot.docs.forEach((documentSnapshot) {
                        documentSnapshot.reference.update({'is_locked': true});
                      });
                    });
                    await showErrorDialog(
                      context,
                      'Payment Successful !',
                    ).then((value) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        mainRoute,
                        (route) => false,
                      );
                    });
                  }
                },
                child: const Text(
                  'Proceed to payment',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
