// ignore_for_file: prefer_typing_uninitialized_variables, sized_box_for_whitespace, prefer_const_constructors

import 'package:flutter/material.dart';

class BugInput extends StatelessWidget {
  const BugInput(
      {Key? key,
      this.controller,
      this.hint,
      this.text,
      this.color = Colors.white,
      this.obscure = false,
      this.maxlines = false,
      this.enabled = true,
      this.padding = true,
      this.readOnly = false,
      this.onChange,
      this.imageIcon,
      this.validator,
      this.autovalidateMode,
      // this.validate,
      this.icon,
      this.type = TextInputType.text,
      this.fontSize = 17.0,
      this.onpressed})
      : super(key: key);

  final controller;
  final validator;
  // final RxBool? validate;
  final obscure;
  final hint;
  final type;
  final imageIcon;
  final icon;
  final text;
  final autovalidateMode;
  final color;
  final maxlines;
  final onChange;
  final onpressed;
  final fontSize;
  final enabled;
  final readOnly;
  final padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding == true
          ? const EdgeInsets.only(left: 4, right: 4)
          : EdgeInsets.only(),
      child: Container(
        height: 140,
        width: MediaQuery.of(context).size.width * 0.65,
        child: Card(
          color: Color.fromRGBO(255, 255, 255, 1),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.grey[400]!,
              )),
          child: Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.62,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: TextFormField(
                      readOnly: readOnly,
                      enabled: enabled,
                      controller: controller,
                      style: TextStyle(fontSize: fontSize),
                      obscureText: obscure,
                      keyboardType: type,
                      validator: validator,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 6,right: 6),
                        hintText: text,
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                        fillColor: color,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: color, width: 1.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: color, width: 1.0),
                        ),
                       
                      ),
                      cursorColor: Colors.black,
                      maxLines: maxlines == true ? null : 1,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
