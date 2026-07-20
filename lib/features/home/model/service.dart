import 'package:flutter/material.dart';

class Service {
  const Service({
    required this.icon,
    required this.name,
    required this.description,
    required this.duration,
    required this.price,
  });

  final IconData icon;
  final String name;
  final String description;
  final String duration;
  final String price;
}
