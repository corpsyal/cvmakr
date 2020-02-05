import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cvmakr/consts.dart';

class CustomInput extends StatefulWidget {
  String initialValue;
  String label;
  int maxLines;
  Function onChange;
  TextInputType keyboardType;

  CustomInput({this.label, this.maxLines = 1, this.initialValue, this.onChange, this.keyboardType});

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  FocusNode _focusNode = FocusNode();
  bool isFocused = false;
  TextEditingController _editingController = TextEditingController();
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    _editingController.text = widget.initialValue;
    isValid = inputIsValid();
    _focusNode.addListener(() {
      setState(() {
        isValid = inputIsValid();
      });
    });
  }

  bool inputIsValid() => !_focusNode.hasFocus && _editingController.value.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: widget.maxLines == 1 ? 45 : null,
      padding: EdgeInsets.only(top: 5),
      margin: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        onChanged: widget.onChange,
        maxLines: widget.maxLines,
        controller: _editingController,
        focusNode: _focusNode,
        decoration: InputDecoration(
          suffixIcon: isValid ? Icon(Icons.check, color: primaryColor,) : null,
          labelText: widget.label,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: inputBorderCorlor,
              width: 1.0,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 1.0),
          ),

        ),
      ),
    );
  }
}





/*

class CustomInput extends StatelessWidget {
  String initialValue;
  String label;
  int maxLines;
  Function onChange;
  TextInputType keyboardType;

  CustomInput({this.label, this.maxLines = 1, this.initialValue, this.onChange, this.keyboardType});

  FocusNode _focusNode = FocusNode();
  bool isFocused = false;
  TextEditingController _editingController = TextEditingController();
  bool isValid = false;


  bool inputIsValid() => !_focusNode.hasFocus && _editingController.value.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: widget.maxLines == 1 ? 45 : null,
      padding: EdgeInsets.only(top: 5),
      margin: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        keyboardType: keyboardType,
        onChanged: onChange,
        maxLines: maxLines,
        controller: _editingController,
        focusNode: _focusNode,
        decoration: InputDecoration(
          suffixIcon: isValid ? Icon(Icons.check, color: primaryColor,) : null,
          labelText: label,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: inputBorderCorlor,
              width: 1.0,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 1.0),
          ),

        ),
      ),
    );
  }
}

 */