import 'package:flutter/material.dart';

// class CategoryFilter {
//   final int id;
//   final String name;
//   final String createdAt;
//   final String updatedAt;
//   final int parentId;  // Change type to int?
//   final bool isMain;  // Change type to bool
//   final int categoryId;  // Change type to int?
//   final List<dynamic> translations;
//
//   CategoryFilter({
//     @required this.id,
//     @required this.name,
//     @required this.createdAt,
//     @required this.updatedAt,
//     this.parentId,  // Allow null
//     @required this.isMain,
//     this.categoryId,  // Allow null
//     @required this.translations,
//   });
//
//   factory CategoryFilter.fromJson(Map<String, dynamic> json) {
//     return CategoryFilter(
//       id: json['id'],
//       name: json['name'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       parentId: json['Parent_Id'],
//       isMain: json['IsMain'] == 1,  // Convert integer to boolean
//       categoryId: json['category_id'],
//       translations: json['translations'],
//     );
//   }
// }
//
class CategoryFilter {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;
  final int parentId;
  final bool isMain;
  final int categoryId;
  final List<dynamic> translations;
  final List<CategoryFilter> children;

  CategoryFilter({
    @required this.id,
    @required this.name,
    @required this.createdAt,
    @required this.updatedAt,
    this.parentId,
    @required this.isMain,
    this.categoryId,
    @required this.translations,
    @required this.children,  // Add a parameter for the child attributes
  });

  factory CategoryFilter.fromJson(Map<String, dynamic> json) {
    return CategoryFilter(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      parentId: json['Parent_Id'],
      isMain: json['IsMain'] == 1,
      categoryId: json['category_id'],
      translations: json['translations'],
      children: json['children'] != null ? json['children'].map((item) => CategoryFilter.fromJson(item)).toList() : [],  // Add a null check
    );
  }

}
