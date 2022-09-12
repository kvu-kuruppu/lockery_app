import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeScreen extends StatelessWidget {
  final String dt = 'abc';

  const QRCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 185, 185, 185),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 185, 185, 185),
        elevation: 0,
        leading: IconButton(
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // QR Code
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'QR Code',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            // QR Code image
            Center(
              child: QrImage(
                data: dt,
                size: 300,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(dt),
          ],
        ),
      ),
    );
  }
}
