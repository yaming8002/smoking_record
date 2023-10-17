import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/providers/ImageDisplayRovider.dart';
import '../../generated/l10n.dart';
import '../widgets/AppFrame.dart';

class ImageDisplayPage extends StatefulWidget {
  ImageDisplayPage({super.key});

  @override
  _ImageDisplayPage createState() => _ImageDisplayPage();
}

class _ImageDisplayPage extends State<ImageDisplayPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageDisplayProvider(context),
      child: Consumer<ImageDisplayProvider>(
        builder: (context, provider, child) {
          return AppFrame(
            appBarTitle: S.current.page_imageDisplayPage,
            body: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    provider.toggleComparison();
                    // 你可以在這裡添加邏輯以決定如何更新 _textOnImage，或者在 ImageDisplayProvider 的 toggleComparison 方法中添加
                  },
                  child: Text(provider.compareTodayAndYesterday
                      ? S.current.image_compare_this
                      : S.current.image_compare_yesterday),
                ),
                TextFormField(
                  maxLines: null, // null makes it grow automatically
                  keyboardType: TextInputType.multiline,
                  onChanged: (text) {
                    provider.updateText(text);
                  },
                  decoration: InputDecoration(
                    hintText: S.current.image_Smoking_feel,
                    border:
                        const OutlineInputBorder(), // adds a border around the TextFormField
                  ),
                ),
                provider.imageWithText,
                ElevatedButton(
                  onPressed: provider.shareImage,
                  child: Text(S.current.image_Share),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
