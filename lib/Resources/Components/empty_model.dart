import './texts.dart';
import 'package:flutter/material.dart';

class EmptyModel extends StatelessWidget {
  final Color color;
  String? text = "Aucune donnée trouvée";

  EmptyModel({Key? key, required this.color, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Icon(Icons.delete_outline_rounded, size: 40, color: color),
          const SizedBox(
            height: 4,
          ),
          TextWidgets.text300(
              title: text ?? "Aucune donnée trouvée",
              fontSize: 14,
              textColor: color)
        ],
      ),
    );
  }
}
