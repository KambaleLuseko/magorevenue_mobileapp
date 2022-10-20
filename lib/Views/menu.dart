import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tax_payment_app/Resources/Constants/navigators.dart';
import '../../Resources/Components/dialogs.dart';
import '../../Resources/Components/texts.dart';
import '../../Resources/Constants/app_providers.dart';
import '../../Resources/Constants/enums.dart';
import '../../Resources/Constants/responsive.dart';
import '../../Resources/Models/Menu/menu.model.dart';
import '../../Resources/Providers/app_state_provider.dart';
import '../../Resources/Providers/users_provider.dart';
import '../../Resources/Providers/menu_provider.dart';
import '../../Resources/Constants/global_variables.dart';

// com.magocorporate.magorevenue

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key? key}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.kWhiteColor,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Consumer<MenuProvider>(
            builder: (context, menuStateProvider, child) {
          return Column(
            children: [
              Card(
                margin: const EdgeInsets.all(0),
                color: AppColors.kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 64, bottom: 10, left: 16, right: 16),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              border: Border.all(
                                color: AppColors.kWhiteColor,
                                width: 2,
                              )),
                          child: Icon(Icons.person,
                              size: 40, color: AppColors.kWhiteColor),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidgets.textBold(
                              title: context
                                      .read<UserProvider>()
                                      .userLogged
                                      ?.fullname ??
                                  'Mago Revenue',
                              fontSize: 16,
                              textColor: AppColors.kWhiteColor),
                          const SizedBox(
                            height: 10,
                          ),
                          TextWidgets.text300(
                              title: context
                                      .read<UserProvider>()
                                      .userLogged
                                      ?.phone ??
                                  'contact@magorevenue.com',
                              fontSize: 12,
                              textColor: AppColors.kWhiteColor),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: AppColors.kScaffoldColor),
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconStateItem(
                      icon: Icons.sync,
                      validState: context.select<AppStateProvider, bool>(
                          (provider) => provider.isApiReachable),
                    ),
                    IconStateItem(
                      icon: Icons.notifications_active,
                      validState: false,
                      errorIcon: Text(
                        '0'.padLeft(2, '0'),
                        style: TextStyle(
                            fontSize: 6, color: AppColors.kWhiteColor),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        AppProviders.appProvider.checkApiConnectivity();
                        ToastNotification.showToast(
                            msg: "Verification de la connectivité en cours ...",
                            msgType: MessageType.info,
                            title: "Information");
                      },
                      child: IconStateItem(
                        icon: Icons.wifi,
                        validState: context.select<AppStateProvider, bool>(
                            (provider) => provider.isApiReachable),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                      controller: ScrollController(keepScrollOffset: false),
                      children: [
                    ...List.generate(menuStateProvider.menus.length, (index) {
                      return MenuItem(
                          menu: menuStateProvider.menus[index],
                          textColor: AppColors.kPrimaryColor,
                          hoverColor: AppColors.kPrimaryColor.withOpacity(0.7),
                          backColor: AppColors.kWhiteColor);
                    }),
                    const SizedBox(
                      height: 32,
                    ),
                  ])),
              GestureDetector(
                onTap: () {
                  Dialogs.showDialogWithAction(
                      title: "Deconnexion",
                      content:
                          "Voulez-vous deconnecter votre compte?\nVous serez obligé de vous reconnecter",
                      callback: () {
                        context.read<UserProvider>().logOut();
                      },
                      dialogType: MessageType.warning);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  margin: const EdgeInsets.only(left: 8, top: 0, bottom: 0),
                  decoration: BoxDecoration(
                    color: AppColors.kTransparentColor.withOpacity(0),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        topLeft: Radius.circular(16)),
                  ),
                  // menuStateProvider.currentMenu == widget.title || isButtonHovered
                  //     ? widget.textColor
                  //     : widget.backColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.exit_to_app,
                                    color: AppColors.kGreyColor,
                                  ),
                                  const SizedBox(width: 16.0),
                                  Container(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        "Deconnexion",
                                        style: TextStyle(
                                            color: AppColors.kGreyColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          );
        }));
  }
}

class IconStateItem extends StatelessWidget {
  bool validState;
  final IconData icon;
  Widget? errorIcon;

  IconStateItem(
      {Key? key, required this.icon, this.errorIcon, this.validState = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: null,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              icon,
              color: AppColors.kWhiteColor,
              size: 20,
            ),
          ),
          if (validState == false)
            Positioned(
                top: 0,
                right: 0,
                child: Card(
                  color: AppColors.kRedColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100)),
                  margin: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: errorIcon ??
                        Icon(
                          Icons.warning_amber_rounded,
                          color: AppColors.kWhiteColor,
                          size: 8,
                        ),
                  ),
                ))
        ],
      ),
    );
  }
}

class MenuItem extends StatefulWidget {
  final MenuModel menu;
  Color textColor;
  Color hoverColor;
  Color backColor;

  MenuItem(
      {Key? key,
      required this.menu,
      required this.backColor,
      required this.hoverColor,
      required this.textColor})
      : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool isButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(builder: (context, menuStateProvider, child) {
      return GestureDetector(
        onTap: () {
          if (!Responsive.isWeb(context)) {
            Navigator.pop(context);
          }
          if (menuStateProvider.getActivePage()?.title == widget.menu.title) {
            return;
          }
          // menuStateProvider.setActivePage(newPage: widget.menu);
          Navigation.pushNavigate(page: widget.menu.page);
        },
        child: MouseRegion(
          // cursor: MouseCursor.,
          onHover: (value) => setState(() {
            isButtonHovered = true;
          }),
          onEnter: (value) => setState(() {
            isButtonHovered = true;
          }),
          onExit: (value) => setState(() {
            isButtonHovered = false;
          }),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            margin: const EdgeInsets.only(left: 8, top: 0, bottom: 0),
            decoration: BoxDecoration(
              color: menuStateProvider.activePage.title == widget.menu.title
                  ? widget.textColor.withOpacity(0.05)
                  : widget.backColor,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  topLeft: Radius.circular(16)),
            ),
            // menuStateProvider.currentMenu == widget.title || isButtonHovered
            //     ? widget.textColor
            //     : widget.backColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Icon(
                              widget.menu.icon,
                              color: menuStateProvider.activePage.title ==
                                          widget.menu.title ||
                                      isButtonHovered
                                  ? widget.hoverColor
                                  : widget.textColor,
                            ),
                            const SizedBox(width: 16.0),
                            Container(
                                padding: EdgeInsets.zero,
                                child: Text(
                                  widget.menu.title,
                                  style: TextStyle(
                                      color:
                                          menuStateProvider.activePage.title ==
                                                      widget.menu.title ||
                                                  isButtonHovered
                                              ? widget.hoverColor
                                              : widget.textColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 5,
                      height: 40,
                      decoration: BoxDecoration(
                        color: menuStateProvider.activePage.title ==
                                widget.menu.title
                            ? AppColors.kPrimaryColor.withOpacity(1)
                            : widget.backColor,
                        // borderRadius: const BorderRadius.only(
                        //     topRight: Radius.circular(16),
                        //     bottomRight: Radius.circular(10)),
                      ),
                    )
                  ],
                ),
                // !Responsive.isWeb(context)
                //     ? const Divider(
                //         height: 2,
                //         color: Colors.black45,
                //         thickness: 1,
                //       )
                //     : Container()
              ],
            ),
          ),
        ),
      );
    });
  }
}
