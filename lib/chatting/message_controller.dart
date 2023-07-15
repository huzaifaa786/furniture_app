import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:furniture/helper/loading.dart';
import 'package:furniture/model/message.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
 RxList<Message> massages = <Message>[].obs;

  TextEditingController massagecontroller = TextEditingController();
  String? activeUserId;
  main() {
    var intValue = Random().nextInt(10);

    return intValue;
  }



  ClearVariable() {
    massagecontroller.clear();

    update();
  }

  File? file;
  Future<void> picksinglefile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'zip',
        'rar',
        'txt',
        'pdf',
        'png',
        'jpg',
        'jpeg',
        'gif'
      ],
    );
    if (result != null) {
      file = await File(result.files.single.path!);
      sendMassage();
    } else {
      // User canceled the picker
    }
  }

  sendMassage() async {
    // var url = BASE_URL + 'sendMessage';
    // var data;
    // GetStorage box = GetStorage();

    // String fileName =
    //     file?.path.split('/').last ?? ''; // Get the file name if it exists
    // print(fileName);

    // data = dio.FormData.fromMap({
    //   'api_token': box.read('api_token')!,
    //   'message': massagecontroller.text.toString(),
    //   'type': 'user',
    //   'temporaryMsgId': main(),
    //   'id': activeUserId,
    // });

    // if (file != null) {
    //   data.files.add(
    //     MapEntry(
    //       'file',
    //       await dio.MultipartFile.fromFile(file!.path, filename: fileName),
    //     ),
    //   );
    // }

    // var response = await Api.execute(url: url, data: data);

    // response['message']['body'] = response['message']['message'];
    // response['message']['created_at'] = response['message']['created_at'];

    // massages.add(Msg(response['message']));

    update();
    ClearVariable();
  }

  fetchmassage(id) async {
    LoadingHelper.show();
    // var url = BASE_URL + 'fetchMessages';
    // var data;
    // GetStorage box = GetStorage();
    // print(box.read('api_token'));
    // data = {
    //   'api_token': box.read('api_token')!,
    //   'id': id,
    // };
    // var response = await Api.execute(url: url, data: data);

    // massages = <Msg>[].obs;
    // for (var van in response['messages']) {
    //   print(van['attachment']);
    //   massages.add(Msg(van));
    //   print(massages.last.file_name);

    //   update();
    // }
    LoadingHelper.dismiss();
  }

  makeseen(id) async {
    LoadingHelper.show();
    // var url = BASE_URL + 'makeSeen';
    // var data;
    // GetStorage box = GetStorage();
    // data = {
    //   'api_token': box.read('api_token')!,
    //   'id': id,
    // };
    // var response = await Api.execute(url: url, data: data);
    LoadingHelper.dismiss();
  }

  String? unseen;
 
 
}