class Validations {
  static String isEmptyValidation(String val) {
    if (val.isEmpty) return 'field can\'t be empty';
    return null;
  }

  static String emailValidation(String val) {
    if (val.isEmpty) return 'email can\'t be empty.';
    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(val)) return 'invalid email format';
    return null;
  }

  static String passwordValidation(String val) {
    if (val.isEmpty) return 'password can\'t be empty';
    if (val.length < 6) return 'minimum 6 characters';
    return null;
  }
}
