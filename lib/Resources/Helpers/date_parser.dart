import 'package:date_format/date_format.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../Resources/Providers/users_provider.dart';

parseDate({required String date}) {
  return formatDate(DateTime.parse(date.toString().trim()),
      [dd, '/', mm, '/', yyyy, ' ', HH, '\\h ', nn, 'min ', ss, '\\s']);
}

numberFormat({required double number}) {
  return number.toStringAsFixed(number.truncateToDouble() == number ? 0 : 2);
}

// amountConversion({required String amount, required String currency}) {
//   if (navKey.currentContext!.read<UserProvider>().defaultCurrency != null) {
//     if (navKey.currentContext!
//             .read<UserProvider>()
//             .defaultCurrency
//             ?.name
//             .toLowerCase() !=
//         'usd') {
//       if (currency.toLowerCase() == 'usd') {
//         return double.parse(amount) *
//             double.parse(navKey.currentContext!
//                 .read<UserProvider>()
//                 .defaultCurrency!
//                 .rateFromUSD);
//       }
//     }
//     if (navKey.currentContext!
//             .read<UserProvider>()
//             .defaultCurrency
//             ?.name
//             .toLowerCase() ==
//         'usd') {
//       if (currency.toLowerCase() != 'usd') {
//         return double.parse(amount) /
//             double.parse(navKey.currentContext!
//                 .read<UserProvider>()
//                 .defaultCurrency!
//                 .rateFromUSD);
//       }
//     }
//     if (navKey.currentContext!
//             .read<UserProvider>()
//             .defaultCurrency
//             ?.name
//             .toLowerCase() ==
//         'usd') {
//       if (currency.toLowerCase() == 'usd') {
//         return double.parse(amount);
//       }
//     }
//   }
//   return double.parse(amount);
// }
