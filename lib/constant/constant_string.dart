class ConstantString {
  static final String base_Url = "https://pob.volvrit.in/api/v1/users";

  static final String register = "${base_Url}/users/register";
  static final String verifyotp = "${base_Url}/users/verify-otp";
  static final String login = "${base_Url}/login";
  static final String punchin = "${base_Url}/punchin";
  static final String check_punchin = "${base_Url}/check-punchin";
  static final String punchout = "${base_Url}/punchout";
  static const String userIdKey = "user_id";
  static final String myDealer = "${base_Url}/my-dealer";
  static final String createCarpenter = "${base_Url}/create-carpenter";
  static final String getStates = "${base_Url}/get-states";
  static final String getCities = "${base_Url}/cities"; // Base for /cities/{state}
  static final String createAccount = "${base_Url}/create-account";


  static const String get = 'GET';
  static const String post = 'POST';
  static const String put = 'PUT';
  static const String delete = 'DELETE';

  //------------Shared Preference----------
  static final String loginKey = "LOGIN_DETAIL_KEY";
  static final String language = "LANGUAGE";
  static String location = "LOCATION";
  static String tokenKey = "TOKEN";
}
