import 'package:json_annotation/json_annotation.dart';

part 'postalDetail.g.dart';

@JsonSerializable()
class PostalDetail {
  String? fr_address;
  String? det_county;
  String? pay_amount;
  String? fr_tel;
  String? cod_amount;
  String? fr_postcode;
  String? dimension;
  String? service_items;
  String? det_name;
  String? det_address;
  String? cod_account;
  String? det_moo;
  String? app;
  String? tracking;
  String? fr_district;
  String? fr_country_iso;
  String? price;
  String? merchant;
  String? weight;
  String? sta;
  String? det_district;
  String? itm;
  String? itm_sku;
  String? fr_county;
  String? det_country_iso;
  String? fr_gps;
  String? pay_id;
  String? det_tel;
  String? serv;
  String? log;
  String? fr_province;
  String? fr_name;
  String? fr_moo;
  String? det_province;
  String? det_gps;
  String? det_postcode;
  String? distance;

  PostalDetail(
      this.fr_address,
      this.det_county,
      this.pay_amount,
      this.fr_tel,
      this.cod_amount,
      this.fr_postcode,
      this.dimension,
      this.service_items,
      this.det_name,
      this.det_address,
      this.cod_account,
      this.det_moo,
      this.app,
      this.tracking,
      this.fr_district,
      this.fr_country_iso,
      this.price,
      this.merchant,
      this.weight,
      this.sta,
      this.det_district,
      this.itm,
      this.itm_sku,
      this.fr_county,
      this.det_country_iso,
      this.fr_gps,
      this.pay_id,
      this.det_tel,
      this.serv,
      this.log,
      this.fr_province,
      this.fr_name,
      this.fr_moo,
      this.det_province,
      this.det_gps,
      this.det_postcode,
      this.distance);

  factory PostalDetail.fromJson(Map<String, dynamic> json) =>
      _$PostalDetailFromJson(json);

  Map<String, dynamic> toJson() => _$PostalDetailToJson(this);
}
