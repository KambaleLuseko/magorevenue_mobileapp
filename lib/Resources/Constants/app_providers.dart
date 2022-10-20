import 'package:provider/src/provider.dart';
import 'package:tax_payment_app/Resources/Providers/app_state_provider.dart';
import 'package:tax_payment_app/main.dart';

class AppProviders {
  static AppStateProvider appProvider =
      navKey.currentContext!.read<AppStateProvider>();
}
