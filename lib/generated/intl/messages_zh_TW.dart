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

  static String m0(date) => "請等待\n${date}";

  static String m1(date) => "${date} 與前一日的吸菸數量持平，繼續加油！";

  static String m2(date) => "${date} 的吸菸數量比前一日少，做得好！";

  static String m3(date) => "${date} 的吸菸數量比前一日多，再接再厲！";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutAppTitle": MessageLookupByLibrary.simpleMessage("關於本程式"),
        "about_app": MessageLookupByLibrary.simpleMessage("關於本程式"),
        "add_Estimate": MessageLookupByLibrary.simpleMessage("估算"),
        "all": MessageLookupByLibrary.simpleMessage("全部"),
        "appGoalContent": MessageLookupByLibrary.simpleMessage(
            "期望透過記錄吸菸的情況，在透過紀錄的習慣跟延長時間。可以逐步降低吸菸的頻率，以達到戒菸的目的。"),
        "appGoalTitle": MessageLookupByLibrary.simpleMessage("目標"),
        "appName": MessageLookupByLibrary.simpleMessage("吸煙紀錄"),
        "authorTitle": MessageLookupByLibrary.simpleMessage("作者"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "contact_author": MessageLookupByLibrary.simpleMessage("聯絡作者"),
        "daily": MessageLookupByLibrary.simpleMessage("單日"),
        "date_range": MessageLookupByLibrary.simpleMessage("日期範圍"),
        "freq_unit": MessageLookupByLibrary.simpleMessage("(根)"),
        "home_interval": m0,
        "home_start": MessageLookupByLibrary.simpleMessage("開始記錄"),
        "image_Share": MessageLookupByLibrary.simpleMessage("分享"),
        "image_Smoking_Equal": m1,
        "image_Smoking_Less": m2,
        "image_Smoking_More": m3,
        "image_Smoking_feel": MessageLookupByLibrary.simpleMessage("輸入感受"),
        "image_compare_this": MessageLookupByLibrary.simpleMessage("比較今日"),
        "image_compare_yesterday": MessageLookupByLibrary.simpleMessage("比較昨日"),
        "item": MessageLookupByLibrary.simpleMessage("項目"),
        "legalNoticeContent": MessageLookupByLibrary.simpleMessage(
            "本應用程序使用了多個受不同開源授權管理的第三方軟件組件。以下是根據授權類型分類的組件列表：\n\nBSD-2-Clause 授權:\n- sqflite\n\nBSD-3-Clause 授權:\n- shared_preferences\n- intl_translation\n- share_plus\n- flutter_local_notifications\n- url_launcher\n\nMIT 授權:\n- fl_chart\n- provider\n- csv\n- file_picker\n- workmanager\n- permission_handler\n- auto_size_text\n- flutter_launcher_icons\n\nApache-2.0 授權:\n- google_mobile_ads\n\n每個組件均遵循其指定的授權條款進行使用，並尊重原作者的版權。請注意，使用這些開源組件並不代表得到其原作者的直接認可。有關各個授權的詳細信息，請參閱相應軟件的官方文檔。"),
        "legalNoticeTitle": MessageLookupByLibrary.simpleMessage("法律聲明"),
        "msg_endTimeFutureError":
            MessageLookupByLibrary.simpleMessage("結束時間不能在未來！"),
        "notification_msg1":
            MessageLookupByLibrary.simpleMessage("有了紀錄，我們就有了方向，持續走向更好的自己。"),
        "notification_msg2":
            MessageLookupByLibrary.simpleMessage("每一筆紀錄都將幫助你更好地理解自己，繼續前進。"),
        "notification_msg3":
            MessageLookupByLibrary.simpleMessage("讓每一次的紀錄成為探索自我、提升生活品質的契機。"),
        "notification_msg4":
            MessageLookupByLibrary.simpleMessage("讓我們用記錄來感受生活，一步一步邁向更健康的生活。"),
        "page_add": MessageLookupByLibrary.simpleMessage("新增"),
        "page_home": MessageLookupByLibrary.simpleMessage("吸煙紀錄"),
        "page_imageDisplayPage": MessageLookupByLibrary.simpleMessage("分享圖片"),
        "page_list": MessageLookupByLibrary.simpleMessage("清單"),
        "page_next": MessageLookupByLibrary.simpleMessage("下一頁"),
        "page_previous": MessageLookupByLibrary.simpleMessage("上一頁"),
        "page_report": MessageLookupByLibrary.simpleMessage("報告"),
        "page_setting": MessageLookupByLibrary.simpleMessage("設定"),
        "page_title": MessageLookupByLibrary.simpleMessage("標題"),
        "privacyPolicyContent": MessageLookupByLibrary.simpleMessage(
            "1. 資料的蒐集：我們的App專注於記錄用戶的習慣。我們只蒐集與用戶習慣相關的材料，且這些數據完全匿名，不含任何能夠識別用戶身份的信息。\n\n2. 資料的使用：收集到的資料僅用於幫助用戶追蹤其習慣。我們不會將這些資料分享、出售或轉讓給任何第三方。\n\n3. 資料匯出與匯入：使用者可以選擇匯出或匯入其習慣資料。需要注意的是，匯出或匯入的資料僅包含使用者的習慣，不包含其他任何可以識別使用者身分的資料。\n\n4. 分享功能：我們的App提供分享功能，允許用戶分享他們的習慣資料。這些分享的資料是匿名的，不含任何個人標識資訊。\n\n5. 資料的保護：我們重視您的資料保護。雖然資料是存放在本地，但我們已採取適當的保護措施，確保資料的安全性。\n\n6. 第三方廣告服務：我們的App使用Google的廣告服務。請注意，Google可能會使用cookies或其他技術來提供廣告。這些技術與我們App中的習慣資料無關，且不會用於識別使用者身分。"),
        "privacyPolicyTitle": MessageLookupByLibrary.simpleMessage("隱私權說明"),
        "query": MessageLookupByLibrary.simpleMessage("查詢"),
        "query_criteria": MessageLookupByLibrary.simpleMessage("查詢條件"),
        "setting_changeDayTime": MessageLookupByLibrary.simpleMessage("換日時間"),
        "setting_crossoverTime": MessageLookupByLibrary.simpleMessage("換日時間"),
        "setting_dataProcessing": MessageLookupByLibrary.simpleMessage("資料處裡"),
        "setting_data_processing_in_progress":
            MessageLookupByLibrary.simpleMessage("資料處理中..."),
        "setting_data_recalculation":
            MessageLookupByLibrary.simpleMessage("資料重新計算"),
        "setting_edit": MessageLookupByLibrary.simpleMessage("編輯"),
        "setting_edit_one": MessageLookupByLibrary.simpleMessage("單一資料編輯"),
        "setting_export": MessageLookupByLibrary.simpleMessage("匯出"),
        "setting_exportData": MessageLookupByLibrary.simpleMessage("資料匯出"),
        "setting_import": MessageLookupByLibrary.simpleMessage("匯入"),
        "setting_importData": MessageLookupByLibrary.simpleMessage("資料匯入"),
        "setting_isWeekStartMonday":
            MessageLookupByLibrary.simpleMessage("週統計起始為週一"),
        "setting_language": MessageLookupByLibrary.simpleMessage("語言設定"),
        "setting_languageSettings":
            MessageLookupByLibrary.simpleMessage("語言設定"),
        "setting_notifications": MessageLookupByLibrary.simpleMessage("通知"),
        "setting_privacyAndServiceTerms":
            MessageLookupByLibrary.simpleMessage("隱私與服務條款"),
        "setting_recalculation": MessageLookupByLibrary.simpleMessage("重新計算"),
        "setting_save": MessageLookupByLibrary.simpleMessage("儲存"),
        "setting_saveByCount": MessageLookupByLibrary.simpleMessage("依數量儲存"),
        "setting_settings": MessageLookupByLibrary.simpleMessage("偏好設定"),
        "setting_singleCigaretteTime":
            MessageLookupByLibrary.simpleMessage("單根菸的時間"),
        "setting_stopAd": MessageLookupByLibrary.simpleMessage("停用廣告"),
        "smokingStatus_evaluate": MessageLookupByLibrary.simpleMessage("感受評分"),
        "smokingStatus_interval": MessageLookupByLibrary.simpleMessage("間隔時間"),
        "smokingStatus_smokeCount":
            MessageLookupByLibrary.simpleMessage("吸菸數量"),
        "smokingStatus_status": MessageLookupByLibrary.simpleMessage("吸煙狀態"),
        "smokingStatus_total_time": MessageLookupByLibrary.simpleMessage("總時間"),
        "submit": MessageLookupByLibrary.simpleMessage("提交"),
        "time_Time": MessageLookupByLibrary.simpleMessage("時間"),
        "time_by_day": MessageLookupByLibrary.simpleMessage("今日 / 昨日"),
        "time_by_week": MessageLookupByLibrary.simpleMessage("本週 / 上週"),
        "time_date": MessageLookupByLibrary.simpleMessage("日期"),
        "time_end": MessageLookupByLibrary.simpleMessage("結束"),
        "time_endTime": MessageLookupByLibrary.simpleMessage("結束時間"),
        "time_intervalTime": MessageLookupByLibrary.simpleMessage("平均間隔時間"),
        "time_seconds": MessageLookupByLibrary.simpleMessage("(秒)"),
        "time_start": MessageLookupByLibrary.simpleMessage("開始"),
        "time_startTime": MessageLookupByLibrary.simpleMessage("開始時間"),
        "time_unit": MessageLookupByLibrary.simpleMessage("(分)"),
        "versionNumberTitle": MessageLookupByLibrary.simpleMessage("版本號"),
        "weekly": MessageLookupByLibrary.simpleMessage("單週")
      };
}
