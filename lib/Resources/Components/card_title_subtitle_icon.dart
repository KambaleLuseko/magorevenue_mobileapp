import './texts.dart';
import 'package:flutter/material.dart';

class CardWithIconTitleSubtitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor, titleColor, subtitleColor;
  final double width;
  final String? imageUrl;
  const CardWithIconTitleSubtitle(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.iconColor,
      required this.titleColor,
      required this.subtitleColor,
      required this.width,
      this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
          color: titleColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          imageUrl != null
              ? Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ))
              : Container(),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: imageUrl != null
                        ? Colors.black.withOpacity(0.6)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10)),
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Icon(icon, color: iconColor, size: 50),
                const SizedBox(height: 20),
                TextWidgets.textBold(
                    align: TextAlign.center,
                    title: title,
                    fontSize: 20,
                    textColor: titleColor),
                const SizedBox(height: 20),
                TextWidgets.text300(
                    align: TextAlign.center,
                    title: subtitle,
                    fontSize: 16,
                    textColor: subtitleColor),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
