import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lockery_app/screens/lockeries/lockery_data.dart';

class Lockers extends StatefulWidget {
  @override
  State<Lockers> createState() => _LockersState();
}

class _LockersState extends State<Lockers> {
  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance.collection('locker').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  // @override
  // void initState() {
  //   getDocId();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 185, 185, 185),
        body: FutureBuilder(
          future: getDocId(),
          builder: (context, snapshot) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: docIDs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    LockeryData(docId: docIDs[index]),
                    const SizedBox(
                      height: 10,
                    )
                  ],
                );
              },
            );
          },
        )

        // ListView.builder(
        //   shrinkWrap: true,
        //   itemCount: docIDs.length,
        //   itemBuilder: (context, index) {
        //     // return ListTile(
        //     //   title: Gettt(docId: docIDs[index]),
        //     // );
        //     return Padding(
        //       padding: const EdgeInsets.all(30.0),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: [
        //           LockeryIcon(
        //             lockId: _lock1[index],
        //           ),
        //           LockeryIcon(
        //             lockId: _lock2[index],
        //           ),
        //           LockeryIcon(
        //             lockId: _lock3[index],
        //           ),
        //         ],
        //       ),
        //     );
        //   },
        // ),
        );
  }
}
