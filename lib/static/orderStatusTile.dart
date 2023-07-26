// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:furniture/values/colors.dart';

class OrderStatusTile extends StatelessWidget {
  const OrderStatusTile({super.key, this.title, this.discription});
  final title;
  final discription;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              title,
              style: const TextStyle(
                  color: mainColor, fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.28,
            child: Text(
              discription,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
