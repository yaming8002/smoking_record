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

  static String m2(date) => "${date} 的吸烟数量比前一日多，再接再厉！";

  static String m3(count, yesterday, dayBefore) =>
      "恭喜！你${yesterday}有比${dayBefore}减少${count}根烟。";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about_app": MessageLookupByLibrary.simpleMessage("关于本程式"),
        "add_Estimate": MessageLookupByLibrary.simpleMessage("估算"),
        "all": MessageLookupByLibrary.simpleMessage("全部"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "contact_author": MessageLookupByLibrary.simpleMessage("联系作者"),
        "daily": MessageLookupByLibrary.simpleMessage("单日"),
        "date_range": MessageLookupByLibrary.simpleMessage("日期范围"),
        "image_Share": MessageLookupByLibrary.simpleMessage("分享"),
        "image_Smoking_Equal": m0,
        "image_Smoking_Less": m1,
        "image_Smoking_More": m2,
        "image_Smoking_feel": MessageLookupByLibrary.simpleMessage("输入感受"),
        "image_compare_this": MessageLookupByLibrary.simpleMessage("比较今日"),
        "image_compare_yesterday": MessageLookupByLibrary.simpleMessage("比较昨日"),
        "item": MessageLookupByLibrary.simpleMessage("项目"),
        "msg_congratulationsReduced": m3,
        "msg_endTimeFutureError":
            MessageLookupByLibrary.simpleMessage("结束时间不能在未来！"),
        "msg_keepItUp":
            MessageLookupByLibrary.simpleMessage("我们再接再厉！慢慢减少吸烟数量。"),
        "page_add": MessageLookupByLibrary.simpleMessage("新增"),
        "page_home": MessageLookupByLibrary.simpleMessage("吸烟纪录"),
        "page_imageDisplayPage": MessageLookupByLibrary.simpleMessage("分享图片"),
        "page_list": MessageLookupByLibrary.simpleMessage("清单"),
        "page_next": MessageLookupByLibrary.simpleMessage("下一页"),
        "page_previous": MessageLookupByLibrary.simpleMessage("上一页"),
        "page_report": MessageLookupByLibrary.simpleMessage("报告"),
        "page_setting": MessageLookupByLibrary.simpleMessage("设定"),
        "page_title": MessageLookupByLibrary.simpleMessage("标题"),
        "privacyPolicy_section1_content": MessageLookupByLibrary.simpleMessage(
            "我们的App专注于纪录用户的习惯。我们只搜集与用户习惯相关的资料，且这些资料完全匿名，不含任何能够识别用户身份的资讯。"),
        "privacyPolicy_section1_title":
            MessageLookupByLibrary.simpleMessage("1. 资料的搜集"),
        "privacyPolicy_section2_content": MessageLookupByLibrary.simpleMessage(
            "搜集到的资料仅用于帮助用户追踪其习惯。我们不会将这些资料分享、出售或转让给任何第三方。"),
        "privacyPolicy_section2_title":
            MessageLookupByLibrary.simpleMessage("2. 资料的使用"),
        "privacyPolicy_section3_content": MessageLookupByLibrary.simpleMessage(
            "用户可以选择汇出或汇入其习惯资料。需要注意的是，汇出或汇入的资料仅包含用户的习惯，不包含其他任何可以识别用户身份的资料。"),
        "privacyPolicy_section3_title":
            MessageLookupByLibrary.simpleMessage("3. 资料汇出及汇入"),
        "privacyPolicy_section4_content": MessageLookupByLibrary.simpleMessage(
            "我们的App提供分享功能，允许用户分享他们的习惯资料。这些分享的资料是匿名的，不含任何个人标识资讯。"),
        "privacyPolicy_section4_title":
            MessageLookupByLibrary.simpleMessage("4. 分享功能"),
        "privacyPolicy_section5_content": MessageLookupByLibrary.simpleMessage(
            "我们重视您的资料保护。虽然资料是存放在本地，但我们已采取适当的保护措施，确保资料的安全性。"),
        "privacyPolicy_section5_title":
            MessageLookupByLibrary.simpleMessage("5. 资料的保护"),
        "privacyPolicy_section6_content": MessageLookupByLibrary.simpleMessage(
            "我们的App使用Google的广告服务。请注意，Google可能会使用cookies或其他技术来提供广告。这些技术与我们App中的习惯资料无关，且不会用于识别用户身份。"),
        "privacyPolicy_section6_title":
            MessageLookupByLibrary.simpleMessage("6. 第三方广告服务"),
        "privacyPolicy_title": MessageLookupByLibrary.simpleMessage("隐私权说明"),
        "query": MessageLookupByLibrary.simpleMessage("查询"),
        "query_criteria": MessageLookupByLibrary.simpleMessage("查询条件"),
        "setting_changeDayNotification":
            MessageLookupByLibrary.simpleMessage("换日通知"),
        "setting_changeDayTime": MessageLookupByLibrary.simpleMessage("换日时间"),
        "setting_dataProcessing": MessageLookupByLibrary.simpleMessage("资料处里"),
        "setting_edit": MessageLookupByLibrary.simpleMessage("编辑"),
        "setting_edit_one": MessageLookupByLibrary.simpleMessage("单笔资料编辑"),
        "setting_exportCsv": MessageLookupByLibrary.simpleMessage("资料汇出CSV"),
        "setting_importCsv": MessageLookupByLibrary.simpleMessage("导入CSV"),
        "setting_importData": MessageLookupByLibrary.simpleMessage("资料汇入"),
        "setting_language": MessageLookupByLibrary.simpleMessage("语言设定"),
        "setting_privacyAndServiceTerms":
            MessageLookupByLibrary.simpleMessage("隐私与服务条款"),
        "setting_recordNotification":
            MessageLookupByLibrary.simpleMessage("纪录通知"),
        "setting_recordNotificationTime":
            MessageLookupByLibrary.simpleMessage("纪录通知的时间"),
        "setting_save": MessageLookupByLibrary.simpleMessage("保存"),
        "setting_saveByCount": MessageLookupByLibrary.simpleMessage("依照数量保存"),
        "setting_singleCigaretteTime":
            MessageLookupByLibrary.simpleMessage("单根烟的时间"),
        "setting_stopAd": MessageLookupByLibrary.simpleMessage("停用广告"),
        "smokingStatus_evaluate": MessageLookupByLibrary.simpleMessage("感受评分"),
        "smokingStatus_smokeCount":
            MessageLookupByLibrary.simpleMessage("吸烟数量"),
        "smokingStatus_spacing": MessageLookupByLibrary.simpleMessage("间隔时间"),
        "smokingStatus_status": MessageLookupByLibrary.simpleMessage("吸烟状态"),
        "smokingStatus_total_time": MessageLookupByLibrary.simpleMessage("总时间"),
        "submit": MessageLookupByLibrary.simpleMessage("提交"),
        "time_Time": MessageLookupByLibrary.simpleMessage("时间"),
        "time_by_day": MessageLookupByLibrary.simpleMessage("今日(昨日)"),
        "time_by_week": MessageLookupByLibrary.simpleMessage("本周(上周)"),
        "time_date": MessageLookupByLibrary.simpleMessage("日期"),
        "time_end": MessageLookupByLibrary.simpleMessage("结束"),
        "time_endTime": MessageLookupByLibrary.simpleMessage("结束时间"),
        "time_spacingTime": MessageLookupByLibrary.simpleMessage("间隔时间"),
        "time_start": MessageLookupByLibrary.simpleMessage("开始"),
        "time_startTime": MessageLookupByLibrary.simpleMessage("开始时间"),
        "time_unit": MessageLookupByLibrary.simpleMessage("(分钟)"),
        "weekly": MessageLookupByLibrary.simpleMessage("单周")
      };
}
