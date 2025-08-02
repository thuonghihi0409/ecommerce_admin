import 'package:flutter/material.dart';

class VariantInput {
  final String id;
  final String name;
  final String? cover;
  final int price;
  final int stock;
  final TextEditingController controller = TextEditingController();

  VariantInput(
      {required this.id,
      required this.name,
      required this.price,
      required this.stock,
      required this.cover});
}
