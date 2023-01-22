class PhoneUtils {
  static String trimePhone(String phone) {
    phone = phone.trim();
    phone = phone.replaceAll("(0)", "+33");
    phone = phone.replaceAll(" ", "");
    return phone;
  }

  static bool isPhoneRight(String phone) {
    return true;
  }
}
