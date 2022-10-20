import 'package:flutter/material.dart';

class TextWidgets {
  static textWithLabel(
      {required String title,
      required double fontSize,
      required Color textColor,
      required String value,
      CrossAxisAlignment? align = CrossAxisAlignment.start}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: align!,
        children: [
          Container(
            // width: double.maxFinite,
            padding: EdgeInsets.zero,
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: fontSize, color: textColor.withOpacity(0.7)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            // width: double.maxFinite,
            padding: EdgeInsets.zero,
            child: Text(
              value,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontSize,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static textHorizontalWithLabel(
      {required String title,
      required double fontSize,
      required Color textColor,
      required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              // width: double.maxFinite,
              padding: EdgeInsets.zero,
              child: Text(
                title,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: fontSize, color: textColor.withOpacity(0.7)),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            // width: double.maxFinite,
            padding: EdgeInsets.zero,
            child: Text(
              value,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontSize,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static textNormal(
      {required String title,
      required double fontSize,
      required Color textColor,
      int? maxLines = 100,
      TextAlign align = TextAlign.left}) {
    return Container(
      // width: double.maxFinite,
      padding: EdgeInsets.zero,
      child: Text(
        title,
        textAlign: align,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: fontSize, color: textColor),
      ),
    );
  }

  static text300(
      {required String title,
      required double fontSize,
      required Color textColor,
      IconData? icon,
      int? maxLines = 5,
      TextAlign align = TextAlign.left}) {
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, color: textColor, size: fontSize + 8),
          if (icon != null) const SizedBox(width: 16),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              title,
              textAlign: align,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w300,
                  color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  static text500(
      {required String title,
      required double fontSize,
      required Color textColor,
      int? maxLines = 5,
      TextAlign align = TextAlign.left}) {
    return Container(
      padding: EdgeInsets.zero,
      child: Text(
        title,
        textAlign: align,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.w500, color: textColor),
      ),
    );
  }

  static textBold(
      {required String title,
      required double fontSize,
      required Color textColor,
      IconData? icon,
      TextAlign align = TextAlign.left,
      int? maxLines = 5}) {
    return Container(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, color: textColor, size: fontSize + 8),
          if (icon != null) const SizedBox(width: 16),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              title,
              textAlign: align,
              maxLines: maxLines,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
