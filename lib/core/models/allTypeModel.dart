class AllTypeModel {
  AllTypeModel({
    required this.types,
    required this.allTypes,
  });
  late final List<Types> types;
  late final int allTypes;

  AllTypeModel.fromJson(Map<String, dynamic> json){
    types = List.from(json['types']).map((e)=>Types.fromJson(e)).toList();
    allTypes = json['allTypes'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['types'] = types.map((e)=>e.toJson()).toList();
    _data['allTypes'] = allTypes;
    return _data;
  }
}

class Types {
  Types({
    required this.id,
    required this.name,
    required this.image,
    required this.library,
    required this.createdAt,
    required this.updatedAt,
  });
  late final String id;
  late final String name;
  late final String image;
  late final String library;
  late final String createdAt;
  late final String updatedAt;

  Types.fromJson(Map<String, dynamic> json){
    id = json['_id'] ?? "";
    name = json['name']?? "";
    image = json['image']?? "";
    library = json['library']?? "";
    createdAt = json['createdAt']?? "";
    updatedAt = json['updatedAt']?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    _data['library'] = library;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}