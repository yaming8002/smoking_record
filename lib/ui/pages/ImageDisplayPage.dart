// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:provider/provider.dart';
//
// import '../../core/providers/ImageDisplayRovider.dart';
// import '../../generated/l10n.dart';
// import '../AppFrame.dart';
//
// class ImageDisplayPage extends StatefulWidget {
//   final Uint8List imageBytes; // 声明 imageBytes 为 final，因为它在构造函数中被赋值
//
//   ImageDisplayPage({Key? key, required this.imageBytes})
//       : super(key: key); // 添加 required 关键字和 this.imageBytes
//
//   @override
//   _ImageDisplayPage createState() => _ImageDisplayPage();
// }
//
// class _ImageDisplayPage extends State<ImageDisplayPage> {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ImageDisplayProvider(context),
//       child: Consumer<ImageDisplayProvider>(
//         builder: (context, provider, child) {
//           return AppFrame(
//             appBarTitle: S.current.page_imageDisplayPage,
//             body: Column(
//               children: <Widget>[
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     provider.toggleComparison();
//                 //     // 你可以在這裡添加邏輯以決定如何更新 _textOnImage，或者在 ImageDisplayProvider 的 toggleComparison 方法中添加
//                 //   },
//                 //   child: Text(provider.compareTodayAndYesterday
//                 //       ? S.current.image_compare_this
//                 //       : S.current.image_compare_yesterday),
//                 // ),
//                 ElevatedButton(
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: const Text('Choose a background color'),
//                           content: SingleChildScrollView(
//                             child: ColorPicker(
//                               pickerColor:
//                                   provider.backgroundColor, // 使用provider中的颜色
//                               onColorChanged: (Color color) {
//                                 provider.updateBackgroundColor(color);
//                               },
//                               showLabel: true,
//                               pickerAreaHeightPercent: 0.8,
//                             ),
//                           ),
//                           actions: <Widget>[
//                             ElevatedButton(
//                               child: const Text('Done'),
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   },
//                   child: Text('Change Background Color'),
//                 ),
//                 TextFormField(
//                   maxLines: null, // null makes it grow automatically
//                   keyboardType: TextInputType.multiline,
//                   onChanged: (text) {
//                     provider.updateText(text);
//                   },
//                   decoration: InputDecoration(
//                     hintText: S.current.image_Smoking_feel,
//                     border:
//                         const OutlineInputBorder(), // adds a border around the TextFormField
//                   ),
//                 ),
//                 provider.imageWithText(widget.imageBytes),
//                 ElevatedButton(
//                   onPressed: provider.shareImage,
//                   child: Text(S.current.image_Share),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
