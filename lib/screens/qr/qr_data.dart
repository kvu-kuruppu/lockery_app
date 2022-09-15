import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class GetQR extends StatelessWidget {
  final String docId;
  GetQR({Key? key, required this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('user');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(docId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          String fname = data['first_name'];
          return SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: QrImage(
                    data: fname,
                    size: 300,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(fname),
              ],
            ),
          );
        }
        return const Text('Loading');
      },
    );
  }
}
