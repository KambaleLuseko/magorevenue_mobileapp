// import '../../Resources/Components/empty_model.dart';
// import '../../Resources/Components/search_textfield.dart';
// import '../../Resources/Components/texts.dart';
// import '../../Resources/Constants/global_variables.dart';
// import '../../Resources/Models/partner.model.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/src/provider.dart';

// class ClientListWidget extends StatefulWidget {
//   PartnerModel? partner;
//   final String category;
//   Function callback;
//   ClientListWidget(
//       {Key? key, this.partner, required this.category, required this.callback})
//       : super(key: key);

//   @override
//   State<ClientListWidget> createState() => _ClientListWidgetState();
// }

// class _ClientListWidgetState extends State<ClientListWidget> {
//   List<PartnerModel> clientData = [], filteredClient = [];

//   @override
//   void initState() {
//     super.initState();
//     _searchCtrller.addListener(() {
//       if (_searchCtrller.text.isEmpty) {
//         filteredClient = clientData;
//         setState(() {});
//         return;
//       }
//       filteredClient = clientData
//           .where((client) =>
//               client.fullname
//                   .toLowerCase()
//                   .contains(_searchCtrller.text.trim().toLowerCase()) ||
//               client.phone
//                   .toLowerCase()
//                   .contains(_searchCtrller.text.trim().toLowerCase()))
//           .toList();
//       setState(() {});
//     });
//     WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
//       // clientData = context.read<PartnerProvider>().offlineData;
//       filteredClient = clientData;
//     });
//   }

//   final TextEditingController _searchCtrller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextWidgets.textBold(
//             title: 'Choisissez un ${widget.category}',
//             fontSize: 12,
//             textColor: AppColors.kBlackColor,
//           ),
//           Container(
//             width: double.maxFinite,
//             alignment: Alignment.centerLeft,
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
//             child: Stack(
//               children: [
//                 // const SizedBox(height: 32),
//                 SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                         mainAxisSize: MainAxisSize.max,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: filteredClient.isNotEmpty
//                             ? List.generate(
//                                 filteredClient.length,
//                                 (index) => clientItem(
//                                     partnerData: filteredClient[index]))
//                             : [EmptyModel(color: AppColors.kGreyColor)])),
//                 Positioned(
//                     top: 0,
//                     left: 0,
//                     child: Container(
//                         width: displaySearchClient == true ? 200 : 20,
//                         decoration: BoxDecoration(
//                           color: Colors.grey[300],
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(children: [
//                           GestureDetector(
//                             onTap: () {
//                               displaySearchClient = !displaySearchClient;
//                               setState(() {});
//                             },
//                             child: Icon(
//                                 displaySearchClient == false
//                                     ? Icons.search_sharp
//                                     : Icons.close,
//                                 color: AppColors.kPrimaryColor,
//                                 size: 20),
//                           ),
//                           if (displaySearchClient == true)
//                             Expanded(
//                               child: SearchTextFormFieldWidget(
//                                   hintText: "Search...",
//                                   textColor: AppColors.kBlackColor,
//                                   backColor: AppColors.kTextFormBackColor,
//                                   editCtrller: _searchCtrller,
//                                   maxLines: 1),
//                             ),
//                         ])))
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   bool displaySearchClient = false;

//   clientsList() {
//     return;
//   }

//   clientItem({required PartnerModel partnerData}) {
//     return GestureDetector(
//       onTap: () {
//         widget.partner = partnerData;
//         setState(() {});
//         widget.callback(partnerData);
//       },
//       child: Container(
//           margin: const EdgeInsets.all(8),
//           padding: const EdgeInsets.all(8),
//           width: 250,
//           decoration: BoxDecoration(
//               color: AppColors.kPrimaryColor.withOpacity(0.08),
//               border: Border.all(
//                   color: widget.partner?.uuid?.toString() ==
//                           partnerData.uuid!.toString()
//                       ? AppColors.kPrimaryColor
//                       : AppColors.kTransparentColor,
//                   width: 1),
//               borderRadius: BorderRadius.circular(8)),
//           child: Row(children: [
//             Stack(
//               children: [
//                 CircleAvatar(
//                     backgroundColor: AppColors.kBlackColor.withOpacity(0.2),
//                     child: TextWidgets.textBold(
//                         title:
//                             partnerData.fullname.substring(0, 1).toUpperCase(),
//                         fontSize: 18,
//                         textColor: AppColors.kBlackColor)),
//                 if (widget.partner?.uuid?.toString() ==
//                     partnerData.uuid!.toString())
//                   Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: Icon(Icons.check_circle,
//                           color: AppColors.kPrimaryColor, size: 18))
//               ],
//             ),
//             const SizedBox(width: 8),
//             Expanded(
//                 child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                   TextWidgets.textBold(
//                       title: partnerData.fullname,
//                       fontSize: 14,
//                       textColor: AppColors.kBlackColor),
//                   const SizedBox(height: 8),
//                   TextWidgets.textNormal(
//                       title: partnerData.phone,
//                       fontSize: 14,
//                       textColor: AppColors.kBlackColor),
//                 ]))
//           ])),
//     );
//   }
// }
