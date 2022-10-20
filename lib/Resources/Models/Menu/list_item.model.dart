import 'package:flutter/material.dart';

class ListItemModel {
  final String title, value;
  final Widget? icon;
  bool? displayLabel;
  ListItemModel(
      {required this.title,
      required this.value,
      this.icon,
      this.displayLabel = true});

  static fromJSON(json) {
    return ListItemModel(
        title: json['title']?.toString() ?? "",
        value: json['value']?.toString() ?? "",
        icon: json['icon'] ?? Container(),
        displayLabel: json['displayLabel'] ?? true);
  }
}
