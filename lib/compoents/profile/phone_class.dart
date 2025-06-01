
import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;
    final buffer = StringBuffer();

    if (newText.length <= 4) {
      buffer.write(newText);
    } else if (newText.length <= 7) {
      buffer.write(newText.substring(0, 4) + ' ' + newText.substring(4, newText.length));
    } else if (newText.length <= 9) {
      buffer.write(newText.substring(0, 4) + ' ' + newText.substring(4, 7) + ' ' + newText.substring(7, newText.length));
    } else if (newText.length <= 11) {
      buffer.write(newText.substring(0, 4) + ' ' + newText.substring(4, 7) + ' ' + newText.substring(7, 9) + ' ' + newText.substring(9, newText.length));
    } else if (newText.length <= 13) {
      buffer.write(newText.substring(0, 4) + ' ' + newText.substring(4, 7) + ' ' + newText.substring(7, 9) + ' ' + newText.substring(9, 11) + ' ' + newText.substring(11, newText.length));
    } else {
      buffer.write(newText.substring(0, 4) + ' ' + newText.substring(4, 7) + ' ' + newText.substring(7, 9) + ' ' + newText.substring(9, 11) + ' ' + newText.substring(11, 13));
    }

    return newValue.copyWith(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}