// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:furniture/values/colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, this.ontap, this.text, this.hide = false});
  final ontap;
  final text;
  final hide;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          hide == false
              ? InkWell(
                  onTap: ontap,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(45),
                        border: Border.all(color: Colors.grey)),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 14.0),
                  child: Text(
                    '..........',
                    style: TextStyle(color: white),
                  ),
                ),
          Text(
            text,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 21,
                color: Colors.black.withOpacity(0.7699999809265137),
                fontWeight: FontWeight.w500),
          ),
          Text(
            '..........',
            style: TextStyle(color: white),
          )
        ],
      ),
    );
  }
}
