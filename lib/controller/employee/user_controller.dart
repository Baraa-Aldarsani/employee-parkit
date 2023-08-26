import 'package:get/get.dart';

import '../../model/employee_model.dart';
import 'api_services_user.dart';

class EmployeeController extends GetxController{
  var user = EmployeeModel(id: 0, name: '', phone_number: 0,email: '',address: '',token:'').obs;
  @override
  void onInit() {
    fetchEmployee();
  }

  Future<void> fetchEmployee() async {
    try {
      final EmployeeModel fetchedUser = await ApiServicesUser.getEmployeeInfo();
      user.value = fetchedUser;
    } catch (e) {
      print('Error fetching user: $e');
    }
  }
}