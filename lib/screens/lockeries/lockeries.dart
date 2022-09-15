// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:lockery_app/constants/routes.dart';
// import 'package:lockery_app/services/auth/auth_service.dart';

// class LockeryIcon extends StatelessWidget {
//   final String lockId;

//   LockeryIcon({
//     Key? key,
//     required this.lockId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(
//           color: Colors.red,
//           width: 2,
//         ),
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             onPressed: () async {
//               final userId = AuthService.firebase().currentUser!.id;
//               print(lockId);
//               Map<String, dynamic> data = {
//                 'locker_id': lockId,
//                 'user_id': userId,
//               };
//               await FirebaseFirestore.instance
//                   .collection('locker')
//                   .doc(lockId)
//                   .set(data);
//               Navigator.of(context).pushNamed(paymentRoute);
//             },
//             iconSize: 40,
//             icon: const Icon(Icons.lock),
//           ),
//         ],
//       ),
//     );
//   }
// }
