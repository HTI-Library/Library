import 'package:hti_library/core/models/old/product_details_model.dart';

class SearchFeedsModel {
  final SearchDataModel data;
  final int status;

  const SearchFeedsModel({
    required this.data,
    required this.status,
  });

  factory SearchFeedsModel.fromJson(Map<String, dynamic> json) {
    return SearchFeedsModel(
      data: SearchDataModel.fromJson(json['data'] ?? 'empty'),
      status: (json['status'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'status': status,
    };
  }
}

class SearchDataModel {
  SearchDataModel({
    required this.products,
    required this.title,
    required this.count_products,
  });

  late final ProductsModel products;
  late final String title;
  late final int count_products;

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    products = ProductsModel.fromJson(json['products']);
    title = json['title'];
    count_products = json['count_products'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['products'] = products;
    _data['title'] = title;
    _data['count_products'] = count_products;
    return _data;
  }
}

class ProductsModel {
  ProductsModel({
    required this.current_page,
    required this.data,
  });

  late final int current_page;
  late final List<ProductModel> data;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    if (json['data'] != null) {
      data = List.from((json['data'] as List))
          .map((e) => ProductModel.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = current_page;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}
