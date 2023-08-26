import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/employee_model.dart';
import '../../view/control_view.dart';
import 'ApiServices.dart';

class LoginController extends GetxController{
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    Future<void> signInWithEmailAndPassword() async {
        final email = emailController.text;
        final password = passwordController.text;

        try {
            final EmployeeModel user =
            await ApiService.signInWithEmailAndPassword(email, password);
            EasyLoading.showSuccess('done...',
                maskType: EasyLoadingMaskType.black,
                duration: const Duration(milliseconds: 500));
            _saveToken(user.token.toString());
            _saveID(user.id.toString());
            _saveGarageID(user.gID.toString());
            Get.offAll(ControlView());
            emailController.clear();
            passwordController.clear();
        } catch (e) {
            print(e.toString());
            EasyLoading.showError(
                "Wrong login",
                maskType: EasyLoadingMaskType.black,
            );
        }
    }
    _saveToken(String token) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        const key = 'token';
        final value = token;
        preferences.setString(key, value);
    }

    read() async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        const key = 'token';
        final value = preferences.getString(key) ?? 0;
    }
    _saveID(String id) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        const key = 'ID';
        final value = id;
        preferences.setString(key, value);
    }

    readID() async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        const key = 'ID';
        final value = preferences.getString(key) ?? 0;
    }

    _saveGarageID(String id) async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        const key = 'GID';
        final value = id;
        preferences.setString(key, value);
    }

    readGarageID() async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        const key = 'GID';
        final value = preferences.getString(key) ?? 0;
    }

    bool isValidEmail(String email) {
        String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
        RegExp regExp = RegExp(emailPattern);
        return regExp.hasMatch(email);
    }

    void deleteUser() async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.getString('token');
        await preferences.remove('token');
    }
    void deleteID() async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.getString('ID');
        await preferences.remove('ID');
    }
}