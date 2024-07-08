class EndPoints {
  static String baseUrl = "http://mohamedsadek.c1.is/api/";
  static String signIn = "user/Login";
  static String signUp = "user/Register";
  // static String getUserDataEndPoint(id){
  //   return "user/Profile/$id";
  // }
  static String Profile = "profile/ProfileUser";
  static String LogOut = "user/Logout";
  static String forgetpassword = "emailExists";
  static String checkCode = "checkCode";
  static String resetPassword = "resetPassword";
  static String resendCode = "sendCode";
  static String addItem = "item/create";
  static String updateProfile = "profile/updateprofile";
  static String alldata = "item/alldata";
  static String allcategory = "item/allcategory";
  static String expire = "item/expire";
  static String soonexpire = "item/soonexpire";

  static String admin_login = "admin/login";
  static String admin_logout = "admin/logout";
  static String search = "item/search";
  static String searchsoonexpire = "item/searchsoonexpire";
  static String searchexpire = "item/searchexpire";
  static String searchdate = "item/searchdate";
  static String userindex = "api/index";
  static String admin_countuser = "admin/countUsers";
  static String admin_getAllUsers = "admin/getAllUsers";
  static String admin_latestUsers = "admin/latestUsers";
  static String admin_countitem = "admin/countItems";
  static String admin_latestItems = "admin/latestItems";
  static const String admin_dashboard = 'api/admin/index';

  static String updatedata(int id) {
    return "item/updatedata/$id";
  }

  static String showone(id) {
    return "item/showone/$id";
  }

  static String delete(int id) {
    return "item/delete/$id";
  }

  static String deleteItem(int id) {
    return "admin/delete/$id";
  }

  static String deleteUser(int id) {
    return "admin/deleteUser/$id";
  }
}

class ApiKey {
  static String status = "status";
  static String error = "error";
  static String email = "email";
  static String password = "password";
  static String token = "token";
  static String api_token = "api_token";
  static String message = "message";
  static String msg = "msg";
  static String success = "success";
  static String id = "id";
  static String name = "name";
  static String image = "image";
  static String confirm_password = "confirm_password";

  static String title = "title";
  static String item_image = "item_image";
  static String pro_date = "pro_date";
  static String start_reminder = "start_reminder";
  static String exp_date = "exp_date";
  static String description = "description";
  static String category_id = "category_id";
  static String type = "type";
  static String code = "code";
  static String quantity = "quantity";
  static String search = "search";

  static String user_count = "user_count";
  static String all_users = "all_users";
}
