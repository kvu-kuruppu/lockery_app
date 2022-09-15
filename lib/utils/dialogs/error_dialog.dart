import 'package:flutter/cupertino.dart';
import 'package:lockery_app/utils/dialogs/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showGenericDialog<void>(
    context: context,
    title: 'Alert',
    content: text,
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
