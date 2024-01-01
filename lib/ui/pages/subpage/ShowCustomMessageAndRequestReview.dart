import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';

void showCustomMessageAndRequestReview(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('喜欢我们的应用吗？'),
        content: Text('如果您喜欢我们的应用，请花一点时间给我们评分。您的反馈对我们非常重要！'),
        actions: <Widget>[
          TextButton(
            child: Text('评分'),
            onPressed: () {
              Navigator.of(context).pop();
              requestReview();
            },
          ),
          TextButton(
            child: Text('稍后'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void requestReview() async {
  if (await InAppReview.instance.isAvailable()) {
    InAppReview.instance.requestReview();
  }
}
