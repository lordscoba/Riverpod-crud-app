class EnvironmentConfig {
  static const String getUsersUrl =
      "http://192.168.28.216:3000/api/admin/getall/user";
  static const String getUsersListUrl =
      "http://jsonplaceholder.typicode.com/users";
  static const String getSingleUsersListUrl =
      "http://localhost:3000/api/admin/getbyid/user/";
  static const String updateUsersListUrl =
      "http://localhost:3000/api/admin/update/user/";
  static const String createUsersListUrl =
      "http://localhost:3000/api/admin/create/user";
  static const String deleteUsersListUrl =
      "http://localhost:3000/api/admin/delete/user/";
  static const String healthUrl =
      "https://bible-compass.onrender.com/api/v1/health";
  // static const String adminGetUrl =
  //     "https://bible-compass.onrender.com/api/v1/admin/getusers";
  static const String adminGetUrl =
      "http://localhost:8080/api/v1/admin/getusers";
}
