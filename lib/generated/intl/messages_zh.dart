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

  static String m0(date) => "请等待\n${date}";

  static String m1(date) => "${date} 与前一日的吸烟数量持平，继续加油！";

  static String m2(date) => "${date} 的吸烟数量比前一日少，做得好！";

  static String m3(date) => "${date} 的吸烟数量比前一日多，再接再厉！";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutAppTitle": MessageLookupByLibrary.simpleMessage("關於本程式"),
        "about_app": MessageLookupByLibrary.simpleMessage("关于本程式"),
        "add_Estimate": MessageLookupByLibrary.simpleMessage("估算"),
        "all": MessageLookupByLibrary.simpleMessage("全部"),
        "appGoalContent": MessageLookupByLibrary.simpleMessage(
            "期望透過記錄吸菸的情況，在透過紀錄的習慣跟延長時間。可以逐步降低吸菸的頻率，以達到戒菸的目的。"),
        "appGoalTitle": MessageLookupByLibrary.simpleMessage("目標"),
        "appName": MessageLookupByLibrary.simpleMessage("吸烟纪录"),
        "authorTitle": MessageLookupByLibrary.simpleMessage("作者"),
        "avg": MessageLookupByLibrary.simpleMessage("(平均)"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "contact_author": MessageLookupByLibrary.simpleMessage("联系作者"),
        "daily": MessageLookupByLibrary.simpleMessage("单日"),
        "date_range": MessageLookupByLibrary.simpleMessage("日期范围"),
        "freq_unit": MessageLookupByLibrary.simpleMessage("(根)"),
        "home_interval": m0,
        "home_start": MessageLookupByLibrary.simpleMessage("开始记录"),
        "image_Share": MessageLookupByLibrary.simpleMessage("分享"),
        "image_Smoking_Equal": m1,
        "image_Smoking_Less": m2,
        "image_Smoking_More": m3,
        "image_Smoking_feel": MessageLookupByLibrary.simpleMessage("输入感受"),
        "image_compare_this": MessageLookupByLibrary.simpleMessage("比较今日"),
        "image_compare_yesterday": MessageLookupByLibrary.simpleMessage("比较昨日"),
        "item": MessageLookupByLibrary.simpleMessage("项目"),
        "legalNoticeContent": MessageLookupByLibrary.simpleMessage(
            "本應用程序使用了多個受不同開源授權管理的第三方軟件組件。以下是根據授權類型分類的組件列表：\n\nBSD-2-Clause 授權:\n- sqflite\n\nBSD-3-Clause 授權:\n- shared_preferences\n- intl_translation\n- share_plus\n- flutter_local_notifications\n- url_launcher\n\nMIT 授權:\n- fl_chart\n- provider\n- csv\n- file_picker\n- workmanager\n- permission_handler\n- auto_size_text\n-  in_app_review\n- flutter_launcher_icons\n\nApache-2.0 授權:\n- google_mobile_ads\n\n每個組件均遵循其指定的授權條款進行使用，並尊重原作者的版權。請注意，使用這些開源組件並不代表得到其原作者的直接認可。有關各個授權的詳細信息，請參閱相應軟件的官方文檔。"),
        "legalNoticeTitle": MessageLookupByLibrary.simpleMessage("法律聲明"),
        "msg_endTimeFutureError":
            MessageLookupByLibrary.simpleMessage("结束时间不能在未来！"),
        "notification_msg1":
            MessageLookupByLibrary.simpleMessage("有了纪录，我们就有了方向，持续走向更好的自己。"),
        "notification_msg2":
            MessageLookupByLibrary.simpleMessage("每一笔纪录都将帮助你更好地理解自己，继续前进。"),
        "notification_msg3":
            MessageLookupByLibrary.simpleMessage("让每一次的纪录成为探索自我、提升生活品质的契机。"),
        "notification_msg4":
            MessageLookupByLibrary.simpleMessage("让我们用记录来感受生活，一步一步迈向更健康的生活。"),
        "page_add": MessageLookupByLibrary.simpleMessage("新增"),
        "page_home": MessageLookupByLibrary.simpleMessage("吸烟纪录"),
        "page_imageDisplayPage": MessageLookupByLibrary.simpleMessage("分享图片"),
        "page_list": MessageLookupByLibrary.simpleMessage("清单"),
        "page_next": MessageLookupByLibrary.simpleMessage("下一页"),
        "page_previous": MessageLookupByLibrary.simpleMessage("上一页"),
        "page_report": MessageLookupByLibrary.simpleMessage("报告"),
        "page_setting": MessageLookupByLibrary.simpleMessage("设定"),
        "page_title": MessageLookupByLibrary.simpleMessage("标题"),
        "privacyPolicyContent": MessageLookupByLibrary.simpleMessage(
            "1. 资料的搜集：我们的App专注于记录用户的习惯。我们只搜集与用户习惯相关的材料，且这些数据完全匿名，不含任何能够识别用户身份的信息。\n\n2. 资料的使用：收集到的资料仅用于帮助用户追踪其习惯。我们不会将这些资料分享、出售或转让给任何第三方。\n\n3. 资料汇出与汇入：使用者可以选择汇出或汇入其习惯资料。需要注意的是，汇出或汇入的资料仅包含使用者的习惯，不包含其他任何可以识别使用者身分的资料。\n\n4. 资料的保护：我们重视您的资料保护。虽然资料是存放在本地，但我们已采取适当的保护措施，确保资料的安全性。\n\n5. 第三方广告服务：我们的App使用Google的广告服务。请注意，Google可能会使用cookies或其他技术来提供广告。这些技术与我们App中的习惯资料无关，且不会用于识别使用者身分。"),
        "privacyPolicyTitle": MessageLookupByLibrary.simpleMessage("隱私權說明"),
        "query": MessageLookupByLibrary.simpleMessage("查询"),
        "query_criteria": MessageLookupByLibrary.simpleMessage("查询条件"),
        "setting_changeDayTime": MessageLookupByLibrary.simpleMessage("换日时间"),
        "setting_crossoverTime": MessageLookupByLibrary.simpleMessage("换日时间"),
        "setting_dataProcessing": MessageLookupByLibrary.simpleMessage("资料处里"),
        "setting_data_processing_in_progress":
            MessageLookupByLibrary.simpleMessage("资料处理中..."),
        "setting_data_recalculation":
            MessageLookupByLibrary.simpleMessage("资料重新计算"),
        "setting_edit": MessageLookupByLibrary.simpleMessage("编辑"),
        "setting_edit_one": MessageLookupByLibrary.simpleMessage("单笔资料编辑"),
        "setting_export": MessageLookupByLibrary.simpleMessage("汇出"),
        "setting_exportData": MessageLookupByLibrary.simpleMessage("资料汇出"),
        "setting_import": MessageLookupByLibrary.simpleMessage("汇入"),
        "setting_importData": MessageLookupByLibrary.simpleMessage("资料汇入"),
        "setting_isWeekStartMonday":
            MessageLookupByLibrary.simpleMessage("周统计起始为周一"),
        "setting_language": MessageLookupByLibrary.simpleMessage("语言设定"),
        "setting_languageSettings":
            MessageLookupByLibrary.simpleMessage("语言设置"),
        "setting_notifications": MessageLookupByLibrary.simpleMessage("通知"),
        "setting_privacyAndServiceTerms":
            MessageLookupByLibrary.simpleMessage("隐私与服务条款"),
        "setting_recalculation": MessageLookupByLibrary.simpleMessage("重新计算"),
        "setting_save": MessageLookupByLibrary.simpleMessage("保存"),
        "setting_saveByCount": MessageLookupByLibrary.simpleMessage("依照数量保存"),
        "setting_settings": MessageLookupByLibrary.simpleMessage("偏好设置"),
        "setting_singleCigaretteTime":
            MessageLookupByLibrary.simpleMessage("单根烟的时间"),
        "setting_stopAd": MessageLookupByLibrary.simpleMessage("停用广告"),
        "smokingStatus_evaluate": MessageLookupByLibrary.simpleMessage("感受评分"),
        "smokingStatus_interval": MessageLookupByLibrary.simpleMessage("间隔时间"),
        "smokingStatus_smokeCount":
            MessageLookupByLibrary.simpleMessage("吸烟数量"),
        "smokingStatus_status": MessageLookupByLibrary.simpleMessage("吸烟状态"),
        "smokingStatus_total_time": MessageLookupByLibrary.simpleMessage("总时间"),
        "submit": MessageLookupByLibrary.simpleMessage("提交"),
        "time_Time": MessageLookupByLibrary.simpleMessage("时间"),
        "time_by_day": MessageLookupByLibrary.simpleMessage("今日 / 昨日"),
        "time_by_week": MessageLookupByLibrary.simpleMessage("本周 / 上周"),
        "time_date": MessageLookupByLibrary.simpleMessage("日期"),
        "time_end": MessageLookupByLibrary.simpleMessage("结束"),
        "time_endTime": MessageLookupByLibrary.simpleMessage("结束时间"),
        "time_hours": MessageLookupByLibrary.simpleMessage("(時)"),
        "time_intervalTime": MessageLookupByLibrary.simpleMessage("间隔时间"),
        "time_minutes": MessageLookupByLibrary.simpleMessage("(分)"),
        "time_seconds": MessageLookupByLibrary.simpleMessage("(秒)"),
        "time_start": MessageLookupByLibrary.simpleMessage("开始"),
        "time_startTime": MessageLookupByLibrary.simpleMessage("开始时间"),
        "time_stopTime": MessageLookupByLibrary.simpleMessage("停止時間时间"),
        "versionNumberTitle": MessageLookupByLibrary.simpleMessage("版本號"),
        "weekly": MessageLookupByLibrary.simpleMessage("单周")
      };
}
