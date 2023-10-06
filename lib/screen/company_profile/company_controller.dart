import 'package:furniture/model/company.dart';
import 'package:get/get.dart';

class CompanyController extends GetxController {
  static CompanyController get instance => Get.find();
  // final Company company;

  // CompanyController({required this.company});
  List<String> imgList = <String>[].obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // updateImgList(Company company),
  // }

  // Method to update the company
  updateImgList(Company companys) {
    imgList = [
      companys.companyImage,
      companys.companyImage1,
      companys.companyImage2,
    ];
    update();
  }

  clear(){
    imgList = <String>[].obs;
    update();
  }
}
