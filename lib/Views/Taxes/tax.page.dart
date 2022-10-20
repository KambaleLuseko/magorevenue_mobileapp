import 'package:flutter/material.dart';
import 'package:tax_payment_app/Resources/Components/shimmer_placeholder.dart';
import 'package:tax_payment_app/Resources/Constants/global_variables.dart';
import 'package:tax_payment_app/Views/Taxes/tax_list.page.dart';

class TaxPage extends StatelessWidget {
  const TaxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Taxes')),
      body: const TaxListPage(),
    );
  }
}
