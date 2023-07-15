import 'package:furniture/model/company.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController {
  static CompanyController get instance => Get.find();
  final Company company;

  CompanyController({required this.company});
  List<String> imgList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    updateImgList();
  }

  // Method to update the company
  void updateImgList() {
    imgList = [
      company.companyImage,
      company.companyImage,
      company.companyImage,
    ];
  }
}
