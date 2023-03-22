class Api {

  

  static const base = 'https://devapi.cosmicagps.in/';
  static const Userss = base + 'Userss';
  static const login = Userss + '/login';
  static const vehicles = base + 'Userss';
  static const orgs = base + 'orgs';

  //////////VEHICLE API GETTERS////////////
  static String editUsersById(String id){
    return '$vehicles/$id';
  }
  static String getUsersList(){
    return '$vehicles/list';
  }
  static String addUserss(){
    return '$vehicles/create';
  }
  static String deleteUserssById(String id){
    return '$vehicles/delete/$id';
  }

  
  //////////VEHICLE API GETTERS////////////
  static String editStudentById(String id){
    return '$vehicles/$id';
  }
  static String getStudentsList(){
    return '$vehicles/list';
  }
  static String addStudents(){
    return '$vehicles/create';
  }
  static String deleteStudentById(String id){
    return '$vehicles/delete/$id';
  }
}