
import 'package:hti_library/core/util/constants.dart';
import 'package:hti_library/core/util/language_model.dart';

class BrandsModel {
  final BrandsDataModel brands;
  final int status;

  const BrandsModel({
    required this.brands,
    required this.status,
  });

  factory BrandsModel.fromJson(Map<String, dynamic> json) {
    return BrandsModel(
      brands: BrandsDataModel.fromJson(json['brands'] ?? 'empty'),
      status: (json['status'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'brands': brands,
      'status': status,
    };
  }
}

class BrandsDataModel {
  BrandsDataModel({
    required this.brands,
  });

  late final List<Brand> brands;

  BrandsDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      brands = List.from(json['data']).map((e) => Brand.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = brands.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Brand {
  Brand({
    required this.id,
    required this.name,
    required this.image,
  });

  late final int id;
  late final LanguageModel name;
  late final String image;

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = LanguageModel.fromMap(parseMapFromServer(json['name']));
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    return _data;
  }
}
