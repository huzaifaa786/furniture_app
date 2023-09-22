// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:furniture/values/colors.dart';
import 'package:get_storage/get_storage.dart';

class OrderStatusTile extends StatefulWidget {
  const OrderStatusTile({super.key, this.title, this.discription});
  final title;
  final discription;

  @override
  State<OrderStatusTile> createState() => _OrderStatusTileState();
}

class _OrderStatusTileState extends State<OrderStatusTile> {
  GetStorage box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          box.read('locale') != 'ar' ? TextDirection.ltr : TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(
                widget.title,
                style: const TextStyle(
                    color: mainColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.28,
              child: Text(
                widget.discription,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
