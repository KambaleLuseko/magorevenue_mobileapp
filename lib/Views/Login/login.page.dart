import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:tax_payment_app/Resources/Components/button.dart';
import 'package:tax_payment_app/Resources/Components/text_fields.dart';
import 'package:tax_payment_app/Resources/Components/texts.dart';
import 'package:tax_payment_app/Resources/Constants/enums.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Constants/navigators.dart';
import 'package:tax_payment_app/Resources/Providers/users_provider.dart';
import 'package:tax_payment_app/Views/Divisions/division.page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameCtrller = TextEditingController(),
      _pwdCtrller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: -100,
              left: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    color: AppColors.kWhiteColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(1000)),
              ),
            ),
            Positioned(
              bottom: -200,
              left: -150,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    color: AppColors.kWhiteColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(1000)),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextWidgets.textBold(
                        title: 'Bienvenu',
                        fontSize: 24,
                        textColor: AppColors.kWhiteColor),
                    Container(
                        padding: const EdgeInsets.all(0),
                        child:
                            Image.asset("Assets/Images/auth.png", width: 400)),
                    TextFormFieldWidget(
                        maxLines: 1,
                        editCtrller: _usernameCtrller,
                        hintText: "Username",
                        textColor: AppColors.kWhiteColor,
                        backColor: AppColors.kTextFormWhiteColor),
                    TextFormFieldWidget(
                      editCtrller: _pwdCtrller,
                      hintText: "Mot de passe",
                      textColor: AppColors.kWhiteColor,
                      backColor: AppColors.kTextFormWhiteColor,
                      isObsCured: true,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomButton(
                        canSync: true,
                        size: double.maxFinite,
                        text: 'Je me connecte',
                        backColor: AppColors.kScaffoldColor,
                        textColor: AppColors.kWhiteColor,
                        callback: () {
                          if (_usernameCtrller.text.isEmpty ||
                              _pwdCtrller.text.isEmpty) {
                            return ToastNotification.showToast(
                                msg:
                                    'Veuillez renseigner un username et un mot de passe',
                                msgType: MessageType.error,
                                title: 'Erreur');
                          }
                          context.read<UserProvider>().login(
                              data: {
                                'username': _usernameCtrller.text.trim(),
                                'password': _pwdCtrller.text.trim()
                              },
                              callback: () {
                                Navigation.pushRemove(
                                    page: const DivisionPage());
                              });
                        })
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: TextWidgets.text300(
                    title: 'by Mago Corporate',
                    fontSize: 12,
                    textColor: AppColors.kWhiteColor.withOpacity(0.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
