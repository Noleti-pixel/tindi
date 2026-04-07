import 'package:get/get.dart';

class Logincontroller extends GetxController {
  var username = "".obs;
  var password = "".obs;
  var PasswordVisible = false.obs;
  login(user, pass) {
    username.value = user;
    password.value = pass;
    if (username.value == "admin" && password == "123") {
      return true;
    } else {
      return false;
    }
  }

  togglePassword() {
    passwordVisible.value = !passwordVisible.value;
    // Implement password visibility toggle logic here
  }
}
