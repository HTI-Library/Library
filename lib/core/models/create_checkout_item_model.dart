

class CreateCheckoutItemModel {
  CreateCheckoutItemModel({
    required this.id,
    required this.price,
    required this.quantity,
    required this.attributes,
  });

  late final int id;
  late final int price;
  late final int quantity;
  late final CreateCheckoutItemModelAttributes attributes;

  CreateCheckoutItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    price = json['price'] ?? 0;
    quantity = json['quantity'] ?? 0;
    attributes = CreateCheckoutItemModelAttributes.fromJson(json['attributes']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['price'] = price;
    _data['quantity'] = quantity;
    _data['attributes'] = attributes;
    return _data;
  }
}

class CreateCheckoutItemModelAttributes {
  CreateCheckoutItemModelAttributes({
    required this.size,
    required this.color,
    required this.type,
    required this.image,
  });

  // late final LanguageModel size;
  // late final LanguageModel color;

  late final dynamic size;
  late final dynamic color;
  late final String type;
  late final String image;

  CreateCheckoutItemModelAttributes.fromJson(Map<String, dynamic> json) {
    // size = LanguageModel.fromMap(parseMapFromServer(json['size']));
    // color = LanguageModel.fromMap(parseMapFromServer(json['color']));
    size = json['size']??'';
    color = json['color']??'';
    type = json['type'] ?? '';
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['size'] = size;
    _data['color'] = color;
    _data['type'] = type;
    _data['image'] = image;
    return _data;
  }
}
