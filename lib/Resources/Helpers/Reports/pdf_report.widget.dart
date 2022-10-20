// import 'dart:convert';
// import 'package:bf_app/Resources/Helpers/Reports/block.model.dart';
// import 'package:flutter/foundation.dart';
// import 'package:pdf/pdf.dart';
// import 'dart:io';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:path_provider/path_provider.dart';
// // import 'package:universal_html/html.dart' as webFile;
// // ignore: avoid_web_libraries_in_flutter
// import 'package:universal_html/html.dart' as webFile;

// buildReport(
//     {required String title,
//     String? listTitle,
//     blockContentTitle,
//     required List data,
//     required List fields,
//     required List<BlockModel> blocks,
//     List<List<BlockModel>>? contentBlocks,
//     required String orientation}) async {
//   // if (data.isEmpty) {
//   //   ToastNotification.showToast(
//   //       msgType: MessageType.error,
//   //       title: "Error",
//   //       msg: "Impossible de produire le rapport, la liste est vide");
//   //   return;
//   // }
//   final pw.Document pdf = pw.Document();

//   pdf.addPage(pw.MultiPage(
//       orientation: orientation.toLowerCase().contains('land')
//           ? pw.PageOrientation.landscape
//           : pw.PageOrientation.portrait,
//       pageFormat: PdfPageFormat.a4.copyWith(
//           marginBottom: 0.5 * PdfPageFormat.cm,
//           marginLeft: 1.5 * PdfPageFormat.cm,
//           marginRight: 1.5 * PdfPageFormat.cm),
//       crossAxisAlignment: pw.CrossAxisAlignment.start,
//       header: (pw.Context context) {
//         return pw.Container(
//             alignment: pw.Alignment.centerRight,
//             margin: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
//             padding: const pw.EdgeInsets.only(bottom: 3.0 * PdfPageFormat.mm),
//             decoration: pw.BoxDecoration(),
//             child: pw.Row(children: [
//               pw.Expanded(
//                   child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       children: [
//                     pw.Text('BINJA & FLORA',
//                         style: textStyle(
//                             fontSize: 16,
//                             weight: pw.FontWeight.bold,
//                             color: PdfColors.black)),
//                     pw.Text('RCCM:7388327',
//                         style: textStyle(
//                             fontSize: 12,
//                             weight: pw.FontWeight.normal,
//                             color: PdfColors.grey))
//                   ])),
//               pw.Text(
//                 'Report',
//               )
//             ]));
//       },
//       footer: (pw.Context context) {
//         return pw.Container(
//             alignment: pw.Alignment.centerRight,
//             margin: const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
//             child: pw.Text(
//               'Page ${context.pageNumber} of ${context.pagesCount}',
//             ));
//       },
//       build: (pw.Context context) => <pw.Widget>[
//             pw.Header(
//                 level: 0,
//                 child: pw.Row(
//                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                     children: <pw.Widget>[
//                       pw.Text(title, textScaleFactor: 2),
//                       // pw.PdfLogo()
//                     ])),
//             // pw.Header(level: 1, text: title),
//             // pw.Padding(padding: const pw.EdgeInsets.all(10)),
//             pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: [
//                   ...List.generate(
//                       blocks.length,
//                       (index) => pw.Column(
//                               crossAxisAlignment: pw.CrossAxisAlignment.start,
//                               children: [
//                                 if (blocks[index].title != '')
//                                   pw.Container(
//                                       width: double.maxFinite,
//                                       padding: const pw.EdgeInsets.symmetric(
//                                           horizontal: 8, vertical: 4),
//                                       decoration: pw.BoxDecoration(
//                                           color: PdfColors.grey300),
//                                       child: pw.Row(
//                                           crossAxisAlignment:
//                                               pw.CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                               pw.MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             pw.Text(
//                                                 blocks[index]
//                                                     .title
//                                                     .toUpperCase(),
//                                                 style: textStyle(
//                                                     fontSize: 12,
//                                                     weight: pw.FontWeight.bold,
//                                                     color: PdfColors.black)),
//                                             pw.Text(
//                                                 blocks[index]
//                                                         .blockFooter
//                                                         ?.toUpperCase() ??
//                                                     '',
//                                                 style: textStyle(
//                                                     fontSize: 12,
//                                                     weight:
//                                                         pw.FontWeight.normal,
//                                                     color: PdfColors.red)),
//                                           ])),
//                                 if (blocks[index].fields.isNotEmpty &&
//                                     blocks[index].data.isNotEmpty &&
//                                     blocks[index].type?.toLowerCase() == 'row')
//                                   pw.Wrap(
//                                       alignment: pw.WrapAlignment.start,
//                                       crossAxisAlignment:
//                                           pw.WrapCrossAlignment.start,
//                                       runAlignment: pw.WrapAlignment.start,
//                                       children: [
//                                         ...List.generate(
//                                             blocks[index].fields.length,
//                                             (fieldIndex) {
//                                           return pw.Container(
//                                               padding:
//                                                   const pw.EdgeInsets.all(8),
//                                               child: pw.Column(
//                                                   crossAxisAlignment: pw
//                                                       .CrossAxisAlignment.start,
//                                                   children: [
//                                                     pw.Text(
//                                                         blocks[index]
//                                                             .fields[fieldIndex]
//                                                             .toString()
//                                                             .toUpperCase(),
//                                                         style: textStyle(
//                                                             fontSize: 10,
//                                                             weight: pw
//                                                                 .FontWeight
//                                                                 .normal,
//                                                             color: PdfColors
//                                                                 .black)),
//                                                     pw.Text(
//                                                         blocks[index]
//                                                                 .data[blocks[
//                                                                             index]
//                                                                         .fields[
//                                                                     fieldIndex]]
//                                                                 ?.toString() ??
//                                                             '',
//                                                         style: textStyle(
//                                                             fontSize: 10,
//                                                             weight: pw
//                                                                 .FontWeight
//                                                                 .bold,
//                                                             color: PdfColors
//                                                                 .black)),
//                                                   ]));
//                                         })
//                                       ]),
//                                 if (blocks[index].fields.isNotEmpty &&
//                                     blocks[index].data.isNotEmpty &&
//                                     blocks[index].type?.toLowerCase() ==
//                                         'column')
//                                   pw.Column(
//                                       crossAxisAlignment:
//                                           pw.CrossAxisAlignment.start,
//                                       children: [
//                                         ...List.generate(
//                                             blocks[index].fields.length,
//                                             (fieldIndex) {
//                                           return pw.Container(
//                                               padding:
//                                                   const pw.EdgeInsets.symmetric(
//                                                       horizontal: 8,
//                                                       vertical: 2),
//                                               child: pw.Row(
//                                                   crossAxisAlignment: pw
//                                                       .CrossAxisAlignment.start,
//                                                   children: [
//                                                     pw.Expanded(
//                                                         child: pw.Text(
//                                                             "${blocks[index].fields[fieldIndex].toString().toUpperCase()}:",
//                                                             style: textStyle(
//                                                                 fontSize: 10,
//                                                                 weight: pw
//                                                                     .FontWeight
//                                                                     .normal,
//                                                                 color: PdfColors
//                                                                     .black))),
//                                                     pw.Expanded(
//                                                         child: pw.Text(
//                                                             blocks[index]
//                                                                     .data[blocks[index]
//                                                                             .fields[
//                                                                         fieldIndex]]
//                                                                     ?.toString() ??
//                                                                 '',
//                                                             style: textStyle(
//                                                                 fontSize: 10,
//                                                                 weight: pw
//                                                                     .FontWeight
//                                                                     .bold,
//                                                                 color: PdfColors
//                                                                     .black))),
//                                                   ]));
//                                         })
//                                       ]),
//                                 pw.SizedBox(height: 16),
//                               ]))
//                 ]),
//             pw.Divider(color: PdfColors.black, thickness: 1),
//             if (blockContentTitle != null &&
//                 blockContentTitle != '' &&
//                 contentBlocks != null &&
//                 contentBlocks.isNotEmpty)
//               pw.Container(
//                   width: double.maxFinite,
//                   padding:
//                       const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: pw.BoxDecoration(color: PdfColors.grey300),
//                   child: pw.Text(blockContentTitle.toUpperCase(),
//                       style: textStyle(
//                           fontSize: 12,
//                           weight: pw.FontWeight.bold,
//                           color: PdfColors.black))),
//             pw.SizedBox(height: 4),
//             if (contentBlocks != null && contentBlocks.isNotEmpty)
//               ...List.generate(contentBlocks.length, (index) {
//                 return pw.Column(children: [
//                   ...List.generate(contentBlocks[index].length, (contentIndex) {
//                     return pw.Column(children: [
//                       if (contentBlocks[index][contentIndex].title != '')
//                         pw.Container(
//                             width: double.maxFinite,
//                             padding: const pw.EdgeInsets.symmetric(
//                                 horizontal: 8, vertical: 4),
//                             decoration:
//                                 pw.BoxDecoration(color: PdfColors.grey100),
//                             child: pw.Row(
//                                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                                 mainAxisAlignment:
//                                     pw.MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   pw.Text(
//                                       contentBlocks[index][contentIndex]
//                                           .title
//                                           .toUpperCase(),
//                                       style: textStyle(
//                                           fontSize: 10,
//                                           weight: pw.FontWeight.bold,
//                                           color: PdfColors.black)),
//                                   pw.Text(
//                                       contentBlocks[index][contentIndex]
//                                               .blockFooter
//                                               ?.toUpperCase() ??
//                                           '',
//                                       style: textStyle(
//                                           fontSize: 10,
//                                           weight: pw.FontWeight.normal,
//                                           color: PdfColors.red)),
//                                 ])),
//                       pw.Column(
//                           // alignment: pw.WrapAlignment.start,
//                           crossAxisAlignment: pw.CrossAxisAlignment.start,
//                           // runAlignment: pw.WrapAlignment.start,
//                           children: [
//                             pw.Container(
//                                 padding: const pw.EdgeInsets.all(2),
//                                 child: pw.Row(
//                                     crossAxisAlignment:
//                                         pw.CrossAxisAlignment.start,
//                                     mainAxisAlignment:
//                                         pw.MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       ...List.generate(
//                                           contentBlocks[index][contentIndex]
//                                               .fields
//                                               .length, (fieldIndex) {
//                                         return pw.Expanded(
//                                             child: pw.Text(
//                                                 contentBlocks[index]
//                                                         [contentIndex]
//                                                     .fields[fieldIndex]
//                                                     .toString()
//                                                     .toUpperCase(),
//                                                 style: textStyle(
//                                                     fontSize: 10,
//                                                     weight:
//                                                         pw.FontWeight.normal,
//                                                     color: PdfColors.black)));
//                                       })
//                                     ]))
//                           ]),
//                     ]);
//                   }),
//                   pw.Divider(color: PdfColors.grey200, thickness: 1),
//                 ]);
//               }),
//             if (listTitle != null && listTitle != '')
//               pw.Container(
//                   width: double.maxFinite,
//                   padding:
//                       const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: pw.BoxDecoration(color: PdfColors.grey300),
//                   child: pw.Text(listTitle.toUpperCase(),
//                       style: textStyle(
//                           fontSize: 12,
//                           weight: pw.FontWeight.bold,
//                           color: PdfColors.black))),
//             pw.SizedBox(height: 8),
//             pw.Table.fromTextArray(
//                 cellAlignment: pw.Alignment.centerLeft,
//                 rowDecoration: pw.BoxDecoration(color: PdfColors.white),
//                 border: pw.TableBorder.all(color: PdfColors.grey200),
//                 oddRowDecoration:
//                     pw.BoxDecoration(color: PdfColors.blue100.shade(0.4)),
//                 context: context,
//                 // headers
//                 data: <List<String>>[
//                   List.generate(fields.length,
//                       (index) => fields[index].toString().toUpperCase()),
//                   ...data.map((e) {
//                     // print(e);
//                     return List.generate(fields.length,
//                         (indexCol) => e[fields[indexCol]]?.toString() ?? '');
//                   })
//                 ]),
//           ]));

//   if (kIsWeb) {
//     webFile.AnchorElement(
//         href:
//             "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(await pdf.save())}")
//       ..setAttribute("download", "$title${DateTime.now().toString()}.pdf")
//       ..click();
//   } else {
//     final String dir = (await getApplicationDocumentsDirectory()).path;
//     final String path = "$dir/$title${DateTime.now().toString()}.pdf";
//     final File file = File(path);
//     await file.writeAsBytes(await pdf.save());
//   }
// }

// textStyle(
//     {required double fontSize,
//     required pw.FontWeight weight,
//     required PdfColor color}) {
//   return pw.TextStyle(fontSize: fontSize, fontWeight: weight, color: color);
// }
