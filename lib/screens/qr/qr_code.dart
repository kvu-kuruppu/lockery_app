import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lockery_app/screens/qr/qr_data.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  List<String> docIDs = [];

  Future getDocId() async {
    await FirebaseFirestore.instance.collection('user').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docIDs.add(document.reference.id);
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 185, 185, 185),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 185, 185, 185),
        elevation: 0,
        leading: IconButton(
          padding: const EdgeInsets.only(top: 10),
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.home,
            color: Colors.black,
            size: 40,
          ),
        ),
      ),
      body: FutureBuilder(
        future: getDocId(),
        builder: (context, snapshot) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: docIDs.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GetQR(docId: docIDs[index]),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}
