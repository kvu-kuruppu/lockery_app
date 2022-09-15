import 'package:flutter/material.dart';
import 'package:lockery_app/constants/routes.dart';
import 'package:lockery_app/providers/lockery_provider.dart';
import 'package:lockery_app/screens/lockeries/lockers.dart';
import 'package:lockery_app/screens/login_view.dart';
import 'package:lockery_app/screens/main_screen.dart';
import 'package:lockery_app/screens/lockeries/payment_screen.dart';
import 'package:lockery_app/screens/notes/create_update_note_view.dart';
import 'package:lockery_app/screens/notes/notes_view.dart';
import 'package:lockery_app/screens/qr/qr_code.dart';
import 'package:lockery_app/screens/register_view.dart';
import 'package:lockery_app/utils/home_pg.dart';
import 'package:month_year_picker/month_year_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LockeryProvider()),
      ],
      child: MaterialApp(
        home: const HomePg(),
        routes: {
          loginRoute: (context) => const LoginView(),
          registerRoute: (context) => const RegisterView(),
          mainRoute: (context) => const MainScreen(),
          qrRoute: (context) => const QRCodeScreen(),
          paymentRoute: (context) => const PaymentScreen(),
          lockerRoute: (context) => Lockers(),
          notesRoute: (context) => const NotesView(),
          createUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
        },
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
      ),
    ),
  );
}
