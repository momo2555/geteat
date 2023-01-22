class UserModel {
  late String _email;
  late String _password;
  late String _phone;
  late String _uid;
  late String _checkId;

  UserModel(email, phone, password, [uid = '', checkId = ""]) {
    _email = email;
    _password = password;
    _uid = uid;
    _phone = phone;
    _checkId =  checkId;
  }

  set uid(value) {
    _uid = value;
  }
  set checkId(value) {
    _checkId = value;
  }
  set phone(value) {
    _phone = value;
  }
   set email(value) {
    _email = value;
  }
  get email {
    return _email;
  }
  get phone {
    return _phone;
  }
  get uid {
    return _uid;
  }
  get checkId {
    return _checkId;
  }
  get password {
    return _password;
  }

  bool isConnected() {
    return _uid != "";
  }
}
