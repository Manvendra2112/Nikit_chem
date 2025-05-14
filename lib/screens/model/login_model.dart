import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({this.code, this.message, this.user});

    int? code;
    String? message;
    User? user;

    factory LoginModel.fromJson(Map<String, dynamic> json) {
        return LoginModel(
            code: json['code'] as int?,
            message: json['message'] as String?,
            user: json['user'] != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
        );
    }

    Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "user": user?.toJson(),
    };
}

class User {
    User({
        this.role,
        this.addBy,
        this.address,
        this.city,
        this.createdAt,
        this.staff,
        this.isVerified,
        this.updatedAt,
        this.phone,
        this.name,
        this.id,
        this.state,
        this.email,
        this.officelocationId,
        this.status,
    });

    String? role;
    int? addBy;
    String? address;
    String? city;
    DateTime? createdAt;
    int? staff;
    String? isVerified;
    DateTime? updatedAt;
    String? phone;
    String? name;
    int? id;
    String? state;
    String? email;
    int? officelocationId;
    String? status;

    factory User.fromJson(Map<String, dynamic> json) {
        return User(
            role: json["role"] as String?,
            addBy: json["add_by"] as int?,
            address: json["address"] as String?,
            city: json["city"] as String?,
            createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"] as String) : null,
            staff: json["staff"] as int?,
            isVerified: json["is_verified"]?.toString(), // Handle int or String
            updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"] as String) : null,
            phone: json["phone"] as String?,
            name: json["name"] as String?,
            id: json["id"] as int?,
            state: json["state"] as String?,
            email: json["email"] as String?,
            officelocationId: json["officelocation_id"] as int?,
            status: json["status"]?.toString(), // Handle int or String
        );
    }

    Map<String, dynamic> toJson() => {
        "role": role,
        "add_by": addBy,
        "address": address,
        "city": city,
        "created_at": createdAt?.toIso8601String(),
        "staff": staff,
        "is_verified": isVerified,
        "updated_at": updatedAt?.toIso8601String(),
        "phone": phone,
        "name": name,
        "id": id,
        "state": state,
        "email": email,
        "officelocation_id": officelocationId,
        "status": status,
    };
}