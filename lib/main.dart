import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Providers/app_state_provider.dart';
import 'package:tax_payment_app/Resources/Providers/client.provider.dart';
import 'package:tax_payment_app/Resources/Providers/taxation.provider.dart';
import 'package:tax_payment_app/Resources/Providers/division.provider.dart';
import 'package:tax_payment_app/Resources/Providers/menu_provider.dart';
import 'package:tax_payment_app/Resources/Providers/users_provider.dart';
import 'package:tax_payment_app/Views/Divisions/division.page.dart';
import 'package:tax_payment_app/Views/Login/login.page.dart';

List<String> storeNames = ["clients", "client_taxes", "taxes", "divisions"];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // for (var i = 0; i < storeNames.length; i++) {

  // }
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

late SharedPreferences prefs;
GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => MenuProvider()),
        ChangeNotifierProvider(create: (_) => DivisionProvider()),
        ChangeNotifierProvider(create: (_) => TaxationProvider()),
        ChangeNotifierProvider(create: (_) => ClientProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mago Revenue',
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch}),
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: AppColors.kPrimaryColor,
            appBarTheme: AppBarTheme(
                elevation: 0, backgroundColor: AppColors.kPrimaryColor)),
        navigatorKey: navKey,
        home: prefs.getString('loggedUser') == null
            ? LoginPage()
            : DivisionPage(),

        // DivisionPage(),
      ),
    );
  }
}
