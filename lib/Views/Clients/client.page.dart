import 'package:flutter/material.dart';
import 'package:tax_payment_app/Resources/Components/shimmer_placeholder.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Resources/Constants/navigators.dart';
import 'package:tax_payment_app/Views/Clients/client_form.widget.dart';
import 'package:tax_payment_app/Views/Clients/client_list.page.dart';

class ClientPage extends StatelessWidget {
  const ClientPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assujetis')),
      floatingActionButton: FloatingActionButton(
        heroTag: 'client',
        backgroundColor: AppColors.kScaffoldColor,
        mini: true,
        onPressed: () {
          Navigation.pushNavigate(
              page: Scaffold(
            appBar: AppBar(
              title: Text('Nouveau client'),
            ),
            body: Column(
              children: [
                ClientFormWidget(
                  canSave: true,
                ),
              ],
            ),
          ));
        },
        child: Icon(Icons.person_add),
      ),
      body: ClientListPage(),
    );
  }
}
