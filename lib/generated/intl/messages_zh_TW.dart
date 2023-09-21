// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_TW locale. All the
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
  String get localeName => 'zh_TW';

  static String m0(date) => "${date} 與前一日的吸菸數量持平，繼續加油！";

  static String m1(date) => "${date} 的吸菸數量比前一日少，做得好！";

  static String m2(date) => "${date} 的吸菸數量比前一日多，再接再厲！";

  static String m3(count, yesterday, dayBefore) =>
      "恭喜！你${yesterday}有比${dayBefore}減少${count}根菸。";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about_app": MessageLookupByLibrary.simpleMessage("關於本程式"),
        "contact_author": MessageLookupByLibrary.simpleMessage("聯繫作者"),
        "image_Smoking_Equal": m0,
        "image_Smoking_Less": m1,
        "image_Smoking_More": m2,
        "msg_congratulationsReduced": m3,
        "msg_endTimeFutureError":
            MessageLookupByLibrary.simpleMessage("結束時間不能在未來！"),
        "msg_keepItUp":
            MessageLookupByLibrary.simpleMessage("我們再接再厲！慢慢減少吸菸數量。"),
        "page_add": MessageLookupByLibrary.simpleMessage("新增"),
        "page_home": MessageLookupByLibrary.simpleMessage("吸菸紀錄"),
        "page_list": MessageLookupByLibrary.simpleMessage("清單"),
        "page_next": MessageLookupByLibrary.simpleMessage("下一頁"),
        "page_previous": MessageLookupByLibrary.simpleMessage("上一頁"),
        "page_report": MessageLookupByLibrary.simpleMessage("報告"),
        "page_setting": MessageLookupByLibrary.simpleMessage("設定"),
        "page_title": MessageLookupByLibrary.simpleMessage("標題"),
        "setting_changeDayNotification":
            MessageLookupByLibrary.simpleMessage("換日通知"),
        "setting_changeDayTime": MessageLookupByLibrary.simpleMessage("換日時間"),
        "setting_dataProcessing": MessageLookupByLibrary.simpleMessage("資料處裡"),
        "setting_edit": MessageLookupByLibrary.simpleMessage("編輯"),
        "setting_edit_one": MessageLookupByLibrary.simpleMessage("單筆資料編輯"),
        "setting_exportCsv": MessageLookupByLibrary.simpleMessage("資料匯出CSV"),
        "setting_importCsv": MessageLookupByLibrary.simpleMessage("導入CSV"),
        "setting_importData": MessageLookupByLibrary.simpleMessage("資料匯入"),
        "setting_language": MessageLookupByLibrary.simpleMessage("語言設定"),
        "setting_privacyAndServiceTerms":
            MessageLookupByLibrary.simpleMessage("隱私與服務條款"),
        "setting_recordNotification":
            MessageLookupByLibrary.simpleMessage("紀錄通知"),
        "setting_recordNotificationTime":
            MessageLookupByLibrary.simpleMessage("紀錄通知的時間"),
        "setting_save": MessageLookupByLibrary.simpleMessage("保存"),
        "setting_saveByCount": MessageLookupByLibrary.simpleMessage("依照數量保存"),
        "setting_singleCigaretteTime":
            MessageLookupByLibrary.simpleMessage("單根菸的時間"),
        "smokingStatus_cumulativeTime":
            MessageLookupByLibrary.simpleMessage("累計時間"),
        "smokingStatus_evaluate": MessageLookupByLibrary.simpleMessage("感受評分"),
        "smokingStatus_smokeCount": MessageLookupByLibrary.simpleMessage("菸數"),
        "smokingStatus_spacing": MessageLookupByLibrary.simpleMessage("間隔時間"),
        "smokingStatus_status": MessageLookupByLibrary.simpleMessage("吸煙狀態"),
        "time_by_day": MessageLookupByLibrary.simpleMessage("今日(昨日)"),
        "time_by_week": MessageLookupByLibrary.simpleMessage("本週(上週)"),
        "time_date": MessageLookupByLibrary.simpleMessage("日期"),
        "time_end": MessageLookupByLibrary.simpleMessage("結束"),
        "time_endTime": MessageLookupByLibrary.simpleMessage("結束時間"),
        "time_spacingTime": MessageLookupByLibrary.simpleMessage("間隔時間"),
        "time_start": MessageLookupByLibrary.simpleMessage("開始"),
        "time_startTime": MessageLookupByLibrary.simpleMessage("開始時間")
      };
}
