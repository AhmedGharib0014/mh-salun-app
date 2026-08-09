import 'package:flutter/material.dart';

class Service {
  const Service({
    required this.icon,
    required this.name,
    required this.description,
    required this.duration,
    required this.price,
    this.iconUrl,
  });

  final IconData icon;
  final String name;
  final String description;
  final String duration;
  final String price;

  /// Remote SVG icon for this service, when the backend supplies one. Falls
  /// back to [icon] while loading, on error, or when null.
  final String? iconUrl;
}
