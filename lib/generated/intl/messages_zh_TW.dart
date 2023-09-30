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
        "image_Share": MessageLookupByLibrary.simpleMessage("分享"),
        "image_Smoking_Equal": m0,
        "image_Smoking_Less": m1,
        "image_Smoking_More": m2,
        "image_Smoking_feel": MessageLookupByLibrary.simpleMessage("輸入感受"),
        "image_compare_this": MessageLookupByLibrary.simpleMessage("比較今日"),
        "image_compare_yesterday": MessageLookupByLibrary.simpleMessage("比較昨日"),
        "msg_congratulationsReduced": m3,
        "msg_endTimeFutureError":
            MessageLookupByLibrary.simpleMessage("結束時間不能在未來！"),
        "msg_keepItUp":
            MessageLookupByLibrary.simpleMessage("我們再接再厲！慢慢減少吸菸數量。"),
        "page_add": MessageLookupByLibrary.simpleMessage("新增"),
        "page_home": MessageLookupByLibrary.simpleMessage("吸菸紀錄"),
        "page_imageDisplayPage": MessageLookupByLibrary.simpleMessage("分享圖片"),
        "page_list": MessageLookupByLibrary.simpleMessage("清單"),
        "page_next": MessageLookupByLibrary.simpleMessage("下一頁"),
        "page_previous": MessageLookupByLibrary.simpleMessage("上一頁"),
        "page_report": MessageLookupByLibrary.simpleMessage("報告"),
        "page_setting": MessageLookupByLibrary.simpleMessage("設定"),
        "page_title": MessageLookupByLibrary.simpleMessage("標題"),
        "privacyPolicy_section1_content": MessageLookupByLibrary.simpleMessage(
            "我們的App專注於紀錄用戶的習慣。我們只蒐集與用戶習慣相關的資料，且這些資料完全匿名，不含任何能夠識別用戶身份的資訊。"),
        "privacyPolicy_section1_title":
            MessageLookupByLibrary.simpleMessage("1. 資料的蒐集"),
        "privacyPolicy_section2_content": MessageLookupByLibrary.simpleMessage(
            "蒐集到的資料僅用於幫助用戶追踪其習慣。我們不會將這些資料分享、出售或轉讓給任何第三方。"),
        "privacyPolicy_section2_title":
            MessageLookupByLibrary.simpleMessage("2. 資料的使用"),
        "privacyPolicy_section3_content": MessageLookupByLibrary.simpleMessage(
            "用戶可以選擇匯出或匯入其習慣資料。需要注意的是，匯出或匯入的資料僅包含用戶的習慣，不包含其他任何可以識別用戶身份的資料。"),
        "privacyPolicy_section3_title":
            MessageLookupByLibrary.simpleMessage("3. 資料匯出及匯入"),
        "privacyPolicy_section4_content": MessageLookupByLibrary.simpleMessage(
            "我們的App提供分享功能，允許用戶分享他們的習慣資料。這些分享的資料是匿名的，不含任何個人標識資訊。"),
        "privacyPolicy_section4_title":
            MessageLookupByLibrary.simpleMessage("4. 分享功能"),
        "privacyPolicy_section5_content": MessageLookupByLibrary.simpleMessage(
            "我們重視您的資料保護。雖然資料是存放在本地，但我們已採取適當的保護措施，確保資料的安全性。"),
        "privacyPolicy_section5_title":
            MessageLookupByLibrary.simpleMessage("5. 資料的保護"),
        "privacyPolicy_section6_content": MessageLookupByLibrary.simpleMessage(
            "我們的App使用Google的廣告服務。請注意，Google可能會使用cookies或其他技術來提供廣告。這些技術與我們App中的習慣資料無關，且不會用於識別用戶身份。"),
        "privacyPolicy_section6_title":
            MessageLookupByLibrary.simpleMessage("6. 第三方廣告服務"),
        "privacyPolicy_title": MessageLookupByLibrary.simpleMessage("隱私權說明"),
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
        "setting_stopAd": MessageLookupByLibrary.simpleMessage("停用廣告"),
        "smokingStatus_cumulativeTime":
            MessageLookupByLibrary.simpleMessage("累計時間"),
        "smokingStatus_evaluate": MessageLookupByLibrary.simpleMessage("感受評分"),
        "smokingStatus_smokeCount": MessageLookupByLibrary.simpleMessage("菸數"),
        "smokingStatus_spacing": MessageLookupByLibrary.simpleMessage("間隔時間"),
        "smokingStatus_status": MessageLookupByLibrary.simpleMessage("吸煙狀態"),
        "time_Time": MessageLookupByLibrary.simpleMessage("時間"),
        "time_by_day": MessageLookupByLibrary.simpleMessage("今日(昨日)"),
        "time_by_week": MessageLookupByLibrary.simpleMessage("本週(上週)"),
        "time_date": MessageLookupByLibrary.simpleMessage("日期"),
        "time_end": MessageLookupByLibrary.simpleMessage("結束"),
        "time_endTime": MessageLookupByLibrary.simpleMessage("結束時間"),
        "time_spacingTime": MessageLookupByLibrary.simpleMessage("間隔時間"),
        "time_start": MessageLookupByLibrary.simpleMessage("開始"),
        "time_startTime": MessageLookupByLibrary.simpleMessage("開始時間"),
        "time_unit": MessageLookupByLibrary.simpleMessage("(分鐘)")
      };
}
