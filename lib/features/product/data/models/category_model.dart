// features/category/data/models/category_model.dart

import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel(
      {required super.id,
      required super.cover,
      required super.name,
      required super.description,
      required super.total});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      cover: json['cover'],
      name: json['name'],
      description: json['discription'],
      total: (json['total']?[0]?["count"]) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cover': cover,
      'name': name,
      'description': description,
    };
  }
}
