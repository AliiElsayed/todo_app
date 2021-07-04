import 'package:flutter/material.dart';

class UsedTextFormField extends StatelessWidget {
  UsedTextFormField({
    @required this.controller,
    @required this.fieldLabel,
    @required this.fieldPrefixIcon,
    this.onFieldTap,
    this.fieldValidate,
    this.onFieldChanged,
    this.boardType,
    this.isReadOnly,
    this.isCursorShowed,
  });

  final TextEditingController controller;
  final String fieldLabel;
  final IconData fieldPrefixIcon;
  final Function onFieldTap;
  final Function fieldValidate;
  final TextInputType boardType;
  final bool isReadOnly;
  final bool isCursorShowed;
  final Function onFieldChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onFieldTap,
      validator: fieldValidate,
       onChanged: onFieldChanged,
      keyboardType: boardType,
      readOnly: isReadOnly,
      showCursor: isCursorShowed,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.5),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2.5),
        ),
        labelText: fieldLabel,
        labelStyle: TextStyle(color: Colors.grey, fontSize: 20),
        prefixIcon: Icon(fieldPrefixIcon),
      ),
    );
  }
}
