// import 'package:flutter/material.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pdfWidgets;
// import 'dart:io';
//
// import '../Model/accountmodel.dart';
//
// class PDFGenerator {
//   Future<void> generatePDF(List<Account> table2Data) async {
//     final pdf = pw.Document();
//     final pdfPageTheme = pw.PageTheme(
//       margin: pw.EdgeInsets.all(32),
//     );
//
//     pdf.addPage(
//       pw.Page(
//         pageTheme: pdfPageTheme,
//         build: (pw.Context context) {
//           return pw.Column(
//             children: [
//               pw.Text('Data Table', style: pw.TextStyle(fontSize: 24)),
//               pw.SizedBox(height: 20),
//               pw.Table.fromTextArray(
//                 headers: [
//                   'م',
//                   'اسم المادة',
//                   'تصنيف المادة',
//                   'التخفيف',
//                   'النوته',
//                   'كمية المواد',
//                   'الكمية من 100%',
//                   'الكمية المطلوب العمل عليها',
//                   'كمية المواد الفرعية داخل المادة',
//                   'التأثير النسبي',
//                   'وصف الرائحة',
//                   'الملاحظات',
//                   'القيود',
//                   'قيد المواد الفرعية',
//                 ],
//                 data: table2Data.map((material) {
//                   return [
//                     material.id?.toString() ?? '',
//                     material.materialname.toString(),
//                     material.materialcategory.toString(),
//                     material.dilution.toString(),
//                     material.noteA.toString(),
//                     material.quantityOfMaterials.toString(),
//                     _calculateQuantityFrom100(material).toString(),
//                     _calculateQuantityToBeWorkedOn(material).toString(),
//                     material.amountOfSubSubstancesWithinSubstance.toString(),
//                     material.relativeInfluence.toString(),
//                     material.descriptionOfSmell.toString(),
//                     material.notes.toString(),
//                     material.restrictions.toString(),
//                     material.registrationOfSubSubjects.toString(),
//                   ];
//                 }).toList(),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//
//     final outputFile = await _createFile();
//     final file = File(outputFile.path);
//     await file.writeAsBytes(await pdf.save());
//     print('PDF saved to ${file.path}');
//   }
//
//   Future<File> _createFile() async {
//     final directory = await getApplicationDocumentsDirectory();
//     final file = File('${directory.path}/table_data.pdf');
//     return file;
//   }
//
//   String _calculateQuantityFrom100(Account material) {
//     final totalAmount = _calculateTotalAmount(); // Implement this method based on your data
//     final oneAmount = double.tryParse(material.quantityOfMaterials.toString()) ?? 0.0;
//     return totalAmount == 0.0 ? '0%' : ((oneAmount / totalAmount) * 100).toStringAsFixed(2) + '%';
//   }
//
//   String _calculateQuantityToBeWorkedOn(Account material) {
//     final totalAmount = _calculateTotalAmount(); // Implement this method based on your data
//     final needWorkValue = double.tryParse(needworkevalue.toString()) ?? 0.0;
//     final oneAmount = double.tryParse(material.quantityOfMaterials.toString()) ?? 0.0;
//     return totalAmount == 0.0 || needWorkValue == 0.0
//         ? '0 ml'
//         : ((oneAmount / totalAmount) * needWorkValue).toStringAsFixed(2) + ' ml';
//   }
//
//   double _calculateTotalAmount() {
//     // Implement this method to return the total amount from your data
//     return table2Data.fold(0.0, (sum, material) {
//       return sum + (double.tryParse(material.quantityOfMaterials.toString()) ?? 0.0);
//     });
//   }
// }
