import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:lockery_app/constants/routes.dart';
import 'package:lockery_app/services/auth/auth_service.dart';

class LockeryData extends StatelessWidget {
  final String docId;
  const LockeryData({Key? key, required this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('locker');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(docId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          bool isL = data['is_locked'];
          String lid = data['locker_id'];
          String uid = data['user_id'];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.red,
                width: 2,
              ),
            ),
            child: Column(
              children: [
                IconButton(
                  onPressed: () async {
                    final userId = AuthService.firebase().currentUser!.id;

                    await FirebaseFirestore.instance
                        .collection('locker')
                        .where(
                          'locker_id',
                          isEqualTo: lid,
                        )
                        .get()
                        .then((querySnapshot) {
                      querySnapshot.docs.forEach((documentSnapshot) {
                        documentSnapshot.reference
                            .update({'is_locked': true, 'user_id': userId});
                      });
                    });
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      notesRoute,
                      (route) => false,
                    );
                  },
                  iconSize: 40,
                  icon: Icon(isL == true ? Icons.lock : Icons.lock_open),
                ),
              ],
            ),
          );
          // return Text('Locker Id: ${data['locker_id']}');
        }
        return const Text('Loading');
      },
    );
  }
}
