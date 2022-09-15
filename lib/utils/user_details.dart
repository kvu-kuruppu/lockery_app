// import 'package:flutter/material.dart';
// import 'package:lockery_app/services/auth/auth_service.dart';
// import 'package:lockery_app/services/cloud/firebase_cloud_storage.dart';
// import 'package:lockery_app/services/cloud/user/cloud_user.dart';

// typedef UserCallBack = void Function(CloudLocker user);

// class QRDetails extends StatefulWidget {
//   const QRDetails({Key? key}) : super(key: key);

//   @override
//   State<QRDetails> createState() => _QRDetailsState();
// }

// class _QRDetailsState extends State<QRDetails> {
//   late final FirebaseCloudStorage _userService;

//   String get userId => AuthService.firebase().currentUser!.id;

//   @override
//   void initState() {
//     _userService = FirebaseCloudStorage();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: _userService.allUser(ownerUserId: userId),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//           case ConnectionState.active:
//             if (snapshot.hasData) {
//               final allUsers = snapshot.data as Iterable<CloudLocker>;
//               return UserListView(users: allUsers);
//             } else {
//               return const CircularProgressIndicator();
//             }
//           default:
//             return const CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }

// class UserListView extends StatelessWidget {
//   final Iterable<CloudLocker> users;

//   const UserListView({
//     Key? key,
//     required this.users,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: users.length,
//       itemBuilder: (context, index) {
//         final user = users.elementAt(index);
//         return Text('Name: ${user.firstName} ${user.lastName}');
//       },
//     );
//   }
// }
