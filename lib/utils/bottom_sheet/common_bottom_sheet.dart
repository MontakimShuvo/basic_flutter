import 'package:flutter/material.dart';

commonBottomSheet({
  required BuildContext context,
  required Widget body,
}) {
  showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context){
        return SafeArea(
            child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: body
            ),
        );
      }
  );
}