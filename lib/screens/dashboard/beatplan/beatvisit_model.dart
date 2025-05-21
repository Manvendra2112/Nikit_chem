import 'dart:convert';

class VisitModel {
  final int code;
  final String message;
  final List<Dealer> data;

  VisitModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Dealer.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Dealer {
  final String delearname;
  final String visitDate;
  final int id;
  final String phone;
  final String city;
  final String? state;
  final String address;
  final String mapLink;
  final int totalVisits;
  final int totalCarpenters;
  final List<Carpenter> carpenderList;
  final String successRate;
  final String totalOrders;

  Dealer({
    required this.delearname,
    required this.visitDate,
    required this.id,
    required this.phone,
    required this.city,
    this.state,
    required this.address,
    required this.mapLink,
    required this.totalVisits,
    required this.totalCarpenters,
    required this.carpenderList,
    required this.successRate,
    required this.totalOrders,
  });

  factory Dealer.fromJson(Map<String, dynamic> json) {
    return Dealer(
      delearname: json['delearname'] ?? '',
      visitDate: json['visit_date'] ?? '',
      id: json['id'] ?? 0,
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
      state: json['state'],
      address: json['address'] ?? '',
      mapLink: json['map_link'] ?? '',
      totalVisits: json['totalVisits'] ?? 0,
      totalCarpenters: json['totalCarpenters'] ?? 0,
      carpenderList: (json['carpenderList'] as List<dynamic>?)
          ?.map((e) => Carpenter.fromJson(e))
          .toList() ??
          [],
      successRate: json['success_rate'] ?? '0%',
      totalOrders: json['total_orders'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'delearname': delearname,
      'visit_date': visitDate,
      'id': id,
      'phone': phone,
      'city': city,
      'state': state,
      'address': address,
      'map_link': mapLink,
      'totalVisits': totalVisits,
      'totalCarpenters': totalCarpenters,
      'carpenderList': carpenderList.map((e) => e.toJson()).toList(),
      'success_rate': successRate,
      'total_orders': totalOrders,
    };
  }
}

class Carpenter {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String createdAt;
  final String updatedAt;
  final String role;
  final int staff;
  final String? otp;
  final String isVerified;
  final String phone;
  final String? profile;
  final String status;
  final int addBy;
  final String? city;
  final String? state;
  final String? headquater;
  final String? address;
  final String? lat;
  final String? long;
  final String? mapLink;
  final String workUnder;
  final String? officelocationId;
  final String? floor;
  final String? nearByLand;

  Carpenter({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.role,
    required this.staff,
    this.otp,
    required this.isVerified,
    required this.phone,
    this.profile,
    required this.status,
    required this.addBy,
    this.city,
    this.state,
    this.headquater,
    this.address,
    this.lat,
    this.long,
    this.mapLink,
    required this.workUnder,
    this.officelocationId,
    this.floor,
    this.nearByLand,
  });

  factory Carpenter.fromJson(Map<String, dynamic> json) {
    return Carpenter(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      role: json['role'] ?? '',
      staff: json['staff'] ?? 0,
      otp: json['otp'],
      isVerified: json['is_verified'] ?? '0',
      phone: json['phone'] ?? '',
      profile: json['profile'],
      status: json['status'] ?? '0',
      addBy: json['add_by'] ?? 0,
      city: json['city'],
      state: json['state'],
      headquater: json['headquater'],
      address: json['address'],
      lat: json['lat'],
      long: json['long'],
      mapLink: json['map_link'],
      workUnder: json['work_under'] ?? '',
      officelocationId: json['officelocation_id'],
      floor: json['floor'],
      nearByLand: json['near_by_land'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'role': role,
      'staff': staff,
      'otp': otp,
      'is_verified': isVerified,
      'phone': phone,
      'profile': profile,
      'status': status,
      'add_by': addBy,
      'city': city,
      'state': state,
      'headquater': headquater,
      'address': address,
      'lat': lat,
      'long': long,
      'map_link': mapLink,
      'work_under': workUnder,
      'officelocation_id': officelocationId,
      'floor': floor,
      'near_by_land': nearByLand,
    };
  }
}