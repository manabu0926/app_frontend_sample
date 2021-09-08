import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'shop.freezed.dart';
part 'shop.g.dart';

@freezed
class Shop with _$Shop {
  const factory Shop({
    required String name,
    required String logo,
    required String label,
  }) = _Shop;
  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
}
