import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChangeNameFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const ChangeNameFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<ChangeNameFieldWidget> createState() => _ChangeNameFieldWidget();
}

class _ChangeNameFieldWidget extends State<ChangeNameFieldWidget> {
  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelText: "Display Name",
          labelStyle: TextStyle(color: Colors.white),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: "Ex: Under",
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        keyboardType: TextInputType.name,
        validator: (name) => name != null ? 'Name invaild.' : null,
      );
}
