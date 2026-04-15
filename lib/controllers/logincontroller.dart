import 'package:get/get.dart';

class Logincontroller extends GetxController {
  var username = "".obs;
  var password = "".obs;
  var PasswordVisible = false.obs;
  login(user, pass) {
    username.value = user;
    password.value = pass;
    if (username.value == "admin" && password.value == "123456") {
      return true;
    } else {
      return false;
    }
  }

  togglePassword() {
    PasswordVisible.value = !PasswordVisible.value;
    // Implement password visibility toggle logic here
  }
}
