import 'Home/home.page.dart';

import '../../Resources/Constants/global_variables.dart';
import '../../Resources/Constants/responsive.dart';
import '../../Resources/Models/Menu/menu.model.dart';
import '../../Resources/Providers/app_state_provider.dart';
import '../../Resources/Providers/menu_provider.dart';
import '../../Resources/Providers/users_provider.dart';
import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      context.read<AppStateProvider>().checkApiConnectivity();
      context.read<AppStateProvider>().getStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: !Responsive.isWeb(context)
        //     ? AppBar(
        //         actions: [
        //           Align(
        //               child: Card(
        //                   elevation: 0,
        //                   shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadius.circular(100)),
        //                   child: Icon(Icons.person,
        //                       color: AppColors.kPrimaryColor)))
        //         ],
        //       )
        //     : null,
        drawer: !Responsive.isWeb(context)
            ? const Drawer(
                child: MenuWidget(),
              )
            : null,
        backgroundColor: AppColors.kScaffoldColor,
        // bottomNavigationBar:
        //     !Responsive.isWeb(context) ? const BottomNavBar() : null,
        body: Row(
          children: [
            if (Responsive.isWeb(context))
              Container(
                  width: 300,
                  padding: const EdgeInsets.all(0),
                  child: const MenuWidget()),
            // if (Responsive.isWeb(context)) const SizedBox(width: 8),
            Expanded(child: context.watch<MenuProvider>().activePage.page),
          ],
        ));
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final Color dividerColor = AppColors.kWhiteColor.withOpacity(0.5);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.kPrimaryColor,
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          // Expanded(
          //     child: BottomNavBarItem(
          //   icon: Icons.home_filled,
          //   title: "Accueil",
          //   callback: () {
          //     selected = "Accueil";
          //     setPage(
          //       menu: MenuModel(
          //           title: "Accueil", page: const HomePage(), icon: Icons.home),
          //     );
          //     setState(() {});
          //   },
          // )),
          VerticalDivider(
            color: dividerColor,
            thickness: 1.0,
          ),
          Expanded(child: Container()),
          VerticalDivider(
            color: dividerColor,
            thickness: 1.0,
          ),
          Expanded(child: Container()),
          VerticalDivider(
            color: dividerColor,
            thickness: 1.0,
          ),
          Expanded(child: Container()),
        ]));
  }

  setPage({required MenuModel menu}) {
    if (context.read<MenuProvider>().getActivePage()?.title == menu.title) {
      return;
    }
    context.read<MenuProvider>().setActivePage(newPage: menu);
  }
}

class BottomNavBarItem extends StatefulWidget {
  final IconData icon;
  final String title;
  void Function()? callback;

  BottomNavBarItem(
      {Key? key, required this.icon, required this.title, this.callback})
      : super(key: key);

  @override
  State<BottomNavBarItem> createState() => _BottomNavBarItemState();
}

class _BottomNavBarItemState extends State<BottomNavBarItem> {
  final Color labelColor = AppColors.kWhiteColor,
      iconColor = AppColors.kWhiteColor.withOpacity(0.5);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
      splashColor: AppColors.kWhiteDarkColor,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Align(
          child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: selected == widget.title ? 70 : 30,
              decoration: BoxDecoration(
                color: selected == widget.title
                    ? AppColors.kWhiteColor
                    : AppColors.kTransparentColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(widget.icon,
                  color: selected == widget.title
                      ? AppColors.kPrimaryColor
                      : iconColor)),
        ),
        // if (selected == widget.title)
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          // width: selected == widget.title ? double.maxFinite : 0,
          // height: selected == widget.title ? 14 : 0,
          child: FittedBox(
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 14,
                color: labelColor,
              ),
            ),
          ),
        )
      ]),
    );
  }
}

String selected =
    navKey.currentContext!.read<MenuProvider>().getActivePage()?.title;
