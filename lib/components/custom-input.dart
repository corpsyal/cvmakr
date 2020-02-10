import 'package:cvmakr/consts.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatefulWidget {
  String initialValue;
  String label;
  int maxLines;
  Function onChange;
  Function onTap;
  TextInputType keyboardType;
  bool controlledInput;
  bool enabled;

  CustomInput({
    this.label,
    this.maxLines = 1,
    this.initialValue,
    this.onChange,
    this.onTap,
    this.keyboardType,
    this.controlledInput = false,
    this.enabled = true,
  });

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  FocusNode _focusNode;
  bool isFocused = false;
  TextEditingController _editingController;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _editingController = TextEditingController(text: widget.initialValue);
    isValid = inputIsValid();
    _focusNode.addListener(() {
      setState(() {
        isValid = inputIsValid();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _editingController.dispose();
  }

  bool inputIsValid() =>
      !_focusNode.hasFocus && _editingController.value.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    if (widget.controlledInput) _editingController.text = widget.initialValue;

    return Container(
      //height: widget.maxLines == 1 ? 45 : null,
      padding: EdgeInsets.only(top: 5),
      margin: EdgeInsets.only(bottom: 16),
      child: TextField(
        enabled: widget.enabled,
        onTap: widget.onTap,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChange,
        maxLines: widget.maxLines,
        controller: _editingController,
        focusNode: _focusNode,
        decoration: InputDecoration(
          suffixIcon: isValid
              ? Icon(
                  Icons.check,
                  color: primaryColor,
                )
              : null,
          labelText: widget.label,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: inputBorderColor,
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
