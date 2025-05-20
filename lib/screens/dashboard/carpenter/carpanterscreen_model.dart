import 'dart:convert';

class CarpenterModel {
  final int id;
  final String carpenterName;
  final String phone;
  final String address;
  final int totalDealers;
  final List<DealerModel> dealerList;

  CarpenterModel({
    required this.id,
    required this.carpenterName,
    required this.phone,
    required this.address,
    required this.totalDealers,
    required this.dealerList,
  });

  factory CarpenterModel.fromJson(Map<String, dynamic> json) {
    return CarpenterModel(
      id: json['id'] ?? 0,
      carpenterName: json['carpentername'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      totalDealers: json['totalDealers'] ?? 0,
      dealerList: (json['DealerList'] as List<dynamic>?)
          ?.map((e) => DealerModel.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'carpentername': carpenterName,
      'phone': phone,
      'address': address,
      'totalDealers': totalDealers,
      'DealerList': dealerList.map((e) => e.toJson()).toList(),
    };
  }
}

class DealerModel {
  final String name;
  final String address;
  final String role;

  DealerModel({
    required this.name,
    required this.address,
    required this.role,
  });

  factory DealerModel.fromJson(Map<String, dynamic> json) {
    return DealerModel(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      role: json['role'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'role': role,
    };
  }
}

List<CarpenterModel> carpenterListFromJson(String str) =>
    List<CarpenterModel>.from(
        json.decode(str)['data'].map((x) => CarpenterModel.fromJson(x)));