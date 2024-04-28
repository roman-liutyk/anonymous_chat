import 'package:flutter/material.dart';

class BottomSheetController {
  static bool _isBottomSheetOpened = false;

  static void showBottomSheet({
    required BuildContext context,
    required Widget widget,
  }) {
    _isBottomSheetOpened = true;

    // hideBottomSheet(context: context);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => widget,
    );
  }

  static void hideBottomSheet({
    required BuildContext context,
  }) {
    if (_isBottomSheetOpened) {
      Navigator.of(context).pop();
      _isBottomSheetOpened = false;
    }
  }
}
