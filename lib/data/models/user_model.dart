class UserModel {
  final String email;
  final String firstName;
  final String lastName;
  final String mobile;
  //  final String password;
 String get fullName{
    return "$firstName $lastName";
 }
  UserModel({

    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    //required this.password,
  });
  factory UserModel.fromJson(Map<String, dynamic> jsonData) {
    //used factory to create object of class UserModel and
    //return it to caller function and handle it accordingly in caller function
    //this function is used to convert json data to object of class UserModel because api
    // returns json data and we need to convert it to object of class UserModel
    // and return it to caller function and handle it accordingly in caller function
    return UserModel(
     //passed id :   jsonData["_id"] because id is key in json data and value is _id in json data
      email:
          jsonData["email"], //passed email :   jsonData["email"] because email is key in json data and value is email in json data
      firstName:
          jsonData["firstName"], //passed firstName :   jsonData["firstName"] because firstName is key in json data and value is firstName in json data
      lastName:
          jsonData["lastName"], //passed lastName :   jsonData["lastName"] because lastName is key in json data and value is lastName in json data
      mobile:
          jsonData["mobile"], //passed mobile :   jsonData["mobile"] because mobile is key in json data and value is mobile in json data
      /* password:
          jsonData["password"], //passed password :   jsonData["password"] because password is key in json data and value is password in json data*/
    );
  }
  Map<String, dynamic> toJson() {
    //used to convert object of class UserModel to json data and return it to caller function and handle it accordingly in caller function
    return {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };
  }
  // final String createdDate = "createdDate";
}

///"email": "em123ail@gmail.com",
//         "firstName": "abwefc",
//         "lastName": "afwbc",
//         "mobile": "017777777777",
//         "password": "123456",
//         "createdDate": "2025-10-02T06:21:41.011Z",
//         "_id": "69271291880cc5d30a300877"
