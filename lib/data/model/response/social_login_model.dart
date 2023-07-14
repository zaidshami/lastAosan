class SocialLoginModel {
  String token;
  String uniqueId;
  String medium;
  String email;

  SocialLoginModel({this.token, this.uniqueId, this.medium, this.email});

  SocialLoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    uniqueId = json['unique_id'];
    medium = json['medium'];
    email = json['email'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['unique_id'] = this.uniqueId;
    data['medium'] = this.medium;
    data['email'] = this.email;
    return data;
  }
}


class SocialLoginModelApple {
  String token;
  String unique_id;
  String email;
  String id;
  String givenName;
  String familyName;
  String medium;


  SocialLoginModelApple({this.token, this.unique_id, this.email,this.id,this.givenName,this.familyName, this.medium, });

  SocialLoginModelApple.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    unique_id = json['unique_id'];
    email = json['email'];
    id = json['id'];
    givenName = json['givenName'];
    familyName = json['familyName'];
    medium = json['medium'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['unique_id'] = this.unique_id;
    data['email'] = this.email;
    data['id'] = this.id;
    data['givenName'] = this.givenName;
    data['familyName'] = this.familyName;
    data['medium'] = this.medium;

    return data;
  }
}
