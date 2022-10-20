import './texts.dart';
import 'package:flutter/material.dart';

class DisapearingWidget extends StatefulWidget {
  final String message;
  final int duration;
  final Color backColor, textColor;
  bool? canBeDisplayed = false;
  DisapearingWidget(
      {Key? key,
      required this.message,
      required this.duration,
      required this.backColor,
      required this.textColor,
      this.canBeDisplayed})
      : super(key: key);

  @override
  _DisapearingWidgetState createState() => _DisapearingWidgetState();
}

class _DisapearingWidgetState extends State<DisapearingWidget> {
  bool isWidgetVisible = true;
  bool canRemoveWidget = false;
  @override
  void initState() {
    super.initState();
    removeWidget();
  }

  removeWidget() async {
    await Future.delayed(const Duration(seconds: 3));
    isWidgetVisible = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: canRemoveWidget == true || widget.canBeDisplayed! == false
            ? false
            : true,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 800),
          opacity: isWidgetVisible == true ? 1 : 0,
          onEnd: () {
            canRemoveWidget = true;
            setState(() {});
          },
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  color: widget.backColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10)),
              child: TextWidgets.text300(
                  title: widget.message,
                  fontSize: 14,
                  textColor: widget.textColor)),
        ));
  }
}
