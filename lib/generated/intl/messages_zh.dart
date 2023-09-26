// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static String m0(date) => "${date} 与前一日的吸烟数量持平，继续加油！";

  static String m1(date) => "${date} 的吸烟数量比前一日少，做得好！";

  static String m2(date) => "${date} 的吸烟数量比前一日多，再接再厲！";

  static String m3(count, yesterday, dayBefore) =>
      "恭喜！你${yesterday}比${dayBefore}少抽${count}根烟。";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about_app": MessageLookupByLibrary.simpleMessage("关于本程序"),
        "contact_author": MessageLookupByLibrary.simpleMessage("联系作者"),
        "image_Share": MessageLookupByLibrary.simpleMessage("分享"),
        "image_Smoking_Equal": m0,
        "image_Smoking_Less": m1,
        "image_Smoking_More": m2,
        "image_Smoking_feel": MessageLookupByLibrary.simpleMessage("輸入感受"),
        "image_compare_this": MessageLookupByLibrary.simpleMessage("比较今日"),
        "image_compare_yesterday": MessageLookupByLibrary.simpleMessage("比较昨日"),
        "msg_congratulationsReduced": m3,
        "msg_endTimeFutureError":
            MessageLookupByLibrary.simpleMessage("结束时间不能在未来！"),
        "msg_keepItUp":
            MessageLookupByLibrary.simpleMessage("我们再接再厉！慢慢减少吸烟数量。"),
        "page_add": MessageLookupByLibrary.simpleMessage("新增"),
        "page_home": MessageLookupByLibrary.simpleMessage("吸烟记录"),
        "page_imageDisplayPage": MessageLookupByLibrary.simpleMessage("分享图片"),
        "page_list": MessageLookupByLibrary.simpleMessage("清单"),
        "page_next": MessageLookupByLibrary.simpleMessage("下一页"),
        "page_previous": MessageLookupByLibrary.simpleMessage("上一页"),
        "page_report": MessageLookupByLibrary.simpleMessage("报告"),
        "page_setting": MessageLookupByLibrary.simpleMessage("设置"),
        "page_title": MessageLookupByLibrary.simpleMessage("标题"),
        "setting_changeDayNotification":
            MessageLookupByLibrary.simpleMessage("换日通知"),
        "setting_changeDayTime": MessageLookupByLibrary.simpleMessage("换日时间"),
        "setting_dataProcessing": MessageLookupByLibrary.simpleMessage("数据处理"),
        "setting_edit": MessageLookupByLibrary.simpleMessage("编辑"),
        "setting_edit_one": MessageLookupByLibrary.simpleMessage("单笔数据编辑"),
        "setting_exportCsv": MessageLookupByLibrary.simpleMessage("数据导出CSV"),
        "setting_importCsv": MessageLookupByLibrary.simpleMessage("导入CSV"),
        "setting_importData": MessageLookupByLibrary.simpleMessage("数据导入"),
        "setting_language": MessageLookupByLibrary.simpleMessage("语言设置"),
        "setting_privacyAndServiceTerms":
            MessageLookupByLibrary.simpleMessage("隐私与服务条款"),
        "setting_recordNotification":
            MessageLookupByLibrary.simpleMessage("记录通知"),
        "setting_recordNotificationTime":
            MessageLookupByLibrary.simpleMessage("记录通知的时间"),
        "setting_save": MessageLookupByLibrary.simpleMessage("保存"),
        "setting_saveByCount": MessageLookupByLibrary.simpleMessage("依照数量保存"),
        "setting_singleCigaretteTime":
            MessageLookupByLibrary.simpleMessage("单根烟的时间"),
        "smokingStatus_cumulativeTime":
            MessageLookupByLibrary.simpleMessage("累计时间"),
        "smokingStatus_evaluate": MessageLookupByLibrary.simpleMessage("感受评分"),
        "smokingStatus_smokeCount": MessageLookupByLibrary.simpleMessage("烟数"),
        "smokingStatus_spacing": MessageLookupByLibrary.simpleMessage("间隔时间"),
        "smokingStatus_status": MessageLookupByLibrary.simpleMessage("吸烟状态"),
        "time_by_day": MessageLookupByLibrary.simpleMessage("今日(昨日)"),
        "time_by_week": MessageLookupByLibrary.simpleMessage("本周(上周)"),
        "time_date": MessageLookupByLibrary.simpleMessage("日期"),
        "time_end": MessageLookupByLibrary.simpleMessage("结束"),
        "time_endTime": MessageLookupByLibrary.simpleMessage("结束时间"),
        "time_spacingTime": MessageLookupByLibrary.simpleMessage("间隔时间"),
        "time_start": MessageLookupByLibrary.simpleMessage("开始"),
        "time_startTime": MessageLookupByLibrary.simpleMessage("开始时间"),
        "time_unit": MessageLookupByLibrary.simpleMessage("(分鐘)")
      };
}
