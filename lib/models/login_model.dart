class LoginModle {
  bool? status;
  String? message;
  UserData? data;
  LoginModle.fromeJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromeJson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;
  //ياخذ بيانات
  // UserData({
  //   this.id,
  //   this.name,
  //   this.email,
  //   this.phone,
  //   this.image,
  //   this.points,
  //   this.credit,
  //   this.token,
  // });
  //named Constructor
  UserData.fromeJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}


/*
{
    "status": true,
    "message": "تم تسجيل الدخول بنجاح",
    "data": {
        "id": 19235,
        "name": "Essam Ezi ALhemyri",
        "email": "essamaa11@gmail.com",
        "phone": "00967715352126",
        "image": "https://student.valuxapps.com/storage/uploads/users/d5Irg2B107_1663107550.jpeg",
        "points": 0,
        "credit": 0,
        "token": "gKmBO8DG0V7imBXvXWjJE45hAVQOazOsWmgHas4Y2OzOGJNfpsPapzhLCCHhbCwGM44oMl"
    }
}
*/



