import '../../Resources/Components/button.dart';
import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Constants/responsive.dart';
import '../../main.dart';
import 'package:flutter/material.dart';

class PageListTitleWidget extends StatelessWidget {
  final Function addCallback, refreshCallback;
  final String title;
  final String description;
  String? buttonText;
  PageListTitleWidget(
      {Key? key,
      required this.addCallback,
      required this.refreshCallback,
      required this.title,
      required this.description,
      buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(8),
      child: Flex(
          mainAxisSize: Responsive.isMobile(navKey.currentContext!)
              ? MainAxisSize.min
              : MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Responsive.isWeb(navKey.currentContext!)
              ? Axis.horizontal
              : Axis.vertical,
          children: [
            Flexible(
                fit: FlexFit.loose,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidgets.textBold(
                          title: title,
                          fontSize: 18,
                          textColor: AppColors.kPrimaryColor),
                      TextWidgets.text300(
                          title: description,
                          fontSize: 12,
                          textColor: AppColors.kPrimaryColor),
                    ])),
            Flexible(
              fit: FlexFit.loose,
              child: Row(
                mainAxisSize: Responsive.isMobile(navKey.currentContext!)
                    ? MainAxisSize.max
                    : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                      text: buttonText ?? "Ajouter",
                      backColor: AppColors.kPrimaryColor,
                      textColor: AppColors.kScaffoldColor,
                      callback: () async {
                        addCallback();
                        // Dialogs.showModal(child: AddStorePage());
                      }),
                  IconButton(
                      onPressed: () {
                        refreshCallback();
                        // context.read<StoresProvider>().get(isRefresh: true);
                      },
                      icon: Icon(Icons.autorenew, color: AppColors.kBlackColor))
                ],
              ),
            )
          ]),
    );
  }
}

filterButton(
    {required String title,
    required bool isActive,
    Color? backColor,
    FlexFit? flexFit = FlexFit.tight,
    required var callback}) {
  backColor ??= AppColors.kScaffoldColor;
  return Flexible(
    fit: flexFit!,
    child: GestureDetector(
      onTap: callback,
      child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          color: isActive ? AppColors.kPrimaryColor : backColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topRight: Radius.circular(16))),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextWidgets.textNormal(
                title: title,
                fontSize: 14,
                textColor:
                    isActive ? AppColors.kWhiteColor : AppColors.kBlackColor),
          )),
    ),
  );
}

class TabFilterWidget extends StatefulWidget {
  Function callback;
  final List<String> titles;
  Color backColor;
  FlexFit? flexFit;
  TabFilterWidget(
      {Key? key,
      required this.callback,
      required this.titles,
      this.flexFit = FlexFit.tight,
      this.backColor = Colors.white})
      : super(key: key);

  @override
  State<TabFilterWidget> createState() => _TabFilterWidgetState();
}

class _TabFilterWidgetState extends State<TabFilterWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      currentFilter = widget.titles[0];
      widget.callback(currentFilter);
    });
  }

  String currentFilter = "";
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Card(
        margin: const EdgeInsets.all(0),
        color: widget.backColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                topRight: Radius.circular(16))),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.titles.length, (index) {
              return filterButton(
                  flexFit: FlexFit.loose,
                  backColor: widget.backColor,
                  title: widget.titles[index],
                  isActive: currentFilter == widget.titles[index],
                  callback: () {
                    setState(() {
                      currentFilter = widget.titles[index];
                      widget.callback(currentFilter);
                      setState(() {});
                    });
                  });
            })),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String title, price, quantity;
  final String? status;

  const ProductItem(
      {Key? key,
      required this.title,
      required this.price,
      required this.quantity,
      this.status = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kWhiteColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Stack(children: [
        SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.kTransparentColor)),
              child: Image.asset(
                "Assets/Images/noimage.png",
                fit: BoxFit.cover,
              ),
            )),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidgets.textBold(
                        title: title,
                        fontSize: 12,
                        textColor: AppColors.kWhiteColor),
                    const SizedBox(height: 4),
                    Row(children: [
                      // TextWidgets.textBold(
                      //     title: "$price\$",
                      //     fontSize: 14,
                      //     textColor: AppColors.kWhiteColor),
                      Expanded(child: Container()),
                      if (status != null && status != '')
                        TextWidgets.text300(
                            title: status!,
                            fontSize: 10,
                            textColor: AppColors.kWhiteColor),
                    ])
                  ],
                ),
              ),
            )),
        Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8)),
              child: TextWidgets.textNormal(
                  title: "${quantity}g",
                  fontSize: 10,
                  textColor: AppColors.kWhiteColor),
            ))
      ]),
    );
  }
}
