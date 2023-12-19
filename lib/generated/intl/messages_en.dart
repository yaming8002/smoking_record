// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(date) => "Please Wait\n${date}";

  static String m1(date) =>
      "${date} has the same number of cigarettes as the previous day, keep it up!";

  static String m2(date) =>
      "The number of cigarettes smoked on ${date} is less than the previous day, well done!";

  static String m3(date) =>
      "The number of cigarettes smoked on ${date} is more than the previous day, keep going!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aboutAppTitle": MessageLookupByLibrary.simpleMessage("About the App"),
        "about_app": MessageLookupByLibrary.simpleMessage("About This App"),
        "add_Estimate": MessageLookupByLibrary.simpleMessage("Estimate"),
        "all": MessageLookupByLibrary.simpleMessage("all"),
        "appGoalContent": MessageLookupByLibrary.simpleMessage(
            "The goal is to gradually reduce smoking frequency by recording smoking habits and extending the time between them, with the ultimate aim of quitting smoking."),
        "appGoalTitle": MessageLookupByLibrary.simpleMessage("Goal"),
        "appName": MessageLookupByLibrary.simpleMessage("Smoking Record"),
        "authorTitle": MessageLookupByLibrary.simpleMessage("Author"),
        "cancel": MessageLookupByLibrary.simpleMessage("cancel"),
        "contact_author":
            MessageLookupByLibrary.simpleMessage("Contact Author"),
        "daily": MessageLookupByLibrary.simpleMessage("single day"),
        "date_range": MessageLookupByLibrary.simpleMessage("date range"),
        "freq_unit": MessageLookupByLibrary.simpleMessage("(Freq.)"),
        "home_interval": m0,
        "home_start": MessageLookupByLibrary.simpleMessage("Start Recording"),
        "image_Share": MessageLookupByLibrary.simpleMessage("Share"),
        "image_Smoking_Equal": m1,
        "image_Smoking_Less": m2,
        "image_Smoking_More": m3,
        "image_Smoking_feel":
            MessageLookupByLibrary.simpleMessage("Enter feelings"),
        "image_compare_this":
            MessageLookupByLibrary.simpleMessage("Compare Today"),
        "image_compare_yesterday":
            MessageLookupByLibrary.simpleMessage("Compare Yesterday"),
        "item": MessageLookupByLibrary.simpleMessage("item"),
        "legalNoticeContent": MessageLookupByLibrary.simpleMessage(
            "This application uses multiple third-party software components governed by different open source licenses. Below is a list of these components categorized by their license types:\n\nBSD-2-Clause License:\n- sqflite\n\nBSD-3-Clause License:\n- shared_preferences\n- intl_translation\n- share_plus\n- flutter_local_notifications\n- url_launcher\n\nMIT License:\n- fl_chart\n- provider\n- csv\n- file_picker\n- workmanager\n- permission_handler\n- auto_size_text\n- flutter_launcher_icons\n\nApache-2.0 License:\n- google_mobile_ads\n\nEach component is used in compliance with its specified license terms, respecting the copyright of the original authors. Please note that the use of these open-source components does not imply direct endorsement by the original authors. For more details on the licenses, please refer to the official documentation of the respective software."),
        "legalNoticeTitle":
            MessageLookupByLibrary.simpleMessage("Legal Notice"),
        "msg_endTimeFutureError": MessageLookupByLibrary.simpleMessage(
            "End time cannot be in the future!"),
        "notification_msg1": MessageLookupByLibrary.simpleMessage(
            "With each record, we find our direction, continuously moving towards a better self."),
        "notification_msg2": MessageLookupByLibrary.simpleMessage(
            "Every entry helps you understand yourself better, keep moving forward."),
        "notification_msg3": MessageLookupByLibrary.simpleMessage(
            "Let each record be an opportunity to explore yourself and enhance the quality of life"),
        "notification_msg4": MessageLookupByLibrary.simpleMessage(
            "Let us use these records to feel the life, step by step towards a healthier lifestyle."),
        "page_add": MessageLookupByLibrary.simpleMessage("New"),
        "page_home": MessageLookupByLibrary.simpleMessage("Smoking Record"),
        "page_imageDisplayPage":
            MessageLookupByLibrary.simpleMessage("Share pictures"),
        "page_list": MessageLookupByLibrary.simpleMessage("list"),
        "page_next": MessageLookupByLibrary.simpleMessage("Next page"),
        "page_previous": MessageLookupByLibrary.simpleMessage("Previous page"),
        "page_report": MessageLookupByLibrary.simpleMessage("report"),
        "page_setting": MessageLookupByLibrary.simpleMessage("setting"),
        "page_title": MessageLookupByLibrary.simpleMessage("title"),
        "privacyPolicyContent": MessageLookupByLibrary.simpleMessage(
            "1. Data Collection: Our app focuses on recording user habits. We only collect materials related to user habits, and this data is completely anonymous, without any identifiable personal information.\n\n2. Use of Data: The collected data is only used to help users track their habits. We will not share, sell, or transfer this data to any third party.\n\n3. Data Export and Import: Users can choose to export or import their habit data. It should be noted that the exported or imported data only contains the user\'s habits and does not contain any identifiable information.\n\n4. Sharing Function: Our app provides a sharing function, allowing users to share their habit data. This shared data is anonymous and does not contain any personal identification information.\n\n5. Data Protection: We value your data protection. Although the data is stored locally, we have taken appropriate measures to ensure the security of the data.\n\n6. Third-party Advertising Service: Our app uses Google\'s advertising service. Please note that Google may use cookies or other technologies to provide advertisements. These technologies are unrelated to the habit data in our app and will not be used to identify users."),
        "privacyPolicyTitle":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "query": MessageLookupByLibrary.simpleMessage("query"),
        "query_criteria":
            MessageLookupByLibrary.simpleMessage("query criteria"),
        "setting_changeDayTime":
            MessageLookupByLibrary.simpleMessage("Change day time"),
        "setting_crossoverTime":
            MessageLookupByLibrary.simpleMessage("Crossover Time"),
        "setting_dataProcessing":
            MessageLookupByLibrary.simpleMessage("Data Processing"),
        "setting_data_processing_in_progress":
            MessageLookupByLibrary.simpleMessage(
                "Data Processing In Progress..."),
        "setting_data_recalculation":
            MessageLookupByLibrary.simpleMessage("Data Recalculation"),
        "setting_edit": MessageLookupByLibrary.simpleMessage("edit"),
        "setting_edit_one":
            MessageLookupByLibrary.simpleMessage("Single data editing"),
        "setting_export": MessageLookupByLibrary.simpleMessage("export"),
        "setting_exportData":
            MessageLookupByLibrary.simpleMessage("Data export"),
        "setting_import": MessageLookupByLibrary.simpleMessage("import"),
        "setting_importData":
            MessageLookupByLibrary.simpleMessage("Data import"),
        "setting_isWeekStartMonday":
            MessageLookupByLibrary.simpleMessage("Start Week on Monday"),
        "setting_language":
            MessageLookupByLibrary.simpleMessage("Language setting"),
        "setting_languageSettings":
            MessageLookupByLibrary.simpleMessage("Language Settings"),
        "setting_notifications":
            MessageLookupByLibrary.simpleMessage("Notifications"),
        "setting_privacyAndServiceTerms":
            MessageLookupByLibrary.simpleMessage("Privacy and Service Terms"),
        "setting_recalculation":
            MessageLookupByLibrary.simpleMessage("Recalculation"),
        "setting_save": MessageLookupByLibrary.simpleMessage("save"),
        "setting_saveByCount":
            MessageLookupByLibrary.simpleMessage("Save by quantity"),
        "setting_settings": MessageLookupByLibrary.simpleMessage("Preferences"),
        "setting_singleCigaretteTime":
            MessageLookupByLibrary.simpleMessage("Single cigarette time"),
        "setting_stopAd": MessageLookupByLibrary.simpleMessage("Disable ads"),
        "smokingStatus_evaluate":
            MessageLookupByLibrary.simpleMessage("SmokingStatus_evaluate"),
        "smokingStatus_interval":
            MessageLookupByLibrary.simpleMessage("interva time"),
        "smokingStatus_smokeCount":
            MessageLookupByLibrary.simpleMessage("Smoking count"),
        "smokingStatus_status":
            MessageLookupByLibrary.simpleMessage("SmokingStatus"),
        "smokingStatus_total_time":
            MessageLookupByLibrary.simpleMessage("Total time"),
        "submit": MessageLookupByLibrary.simpleMessage("submit"),
        "time_Time": MessageLookupByLibrary.simpleMessage("Time"),
        "time_by_day":
            MessageLookupByLibrary.simpleMessage("Today / yesterday"),
        "time_by_week":
            MessageLookupByLibrary.simpleMessage("This week / last week"),
        "time_date": MessageLookupByLibrary.simpleMessage("Date"),
        "time_end": MessageLookupByLibrary.simpleMessage("End"),
        "time_endTime": MessageLookupByLibrary.simpleMessage("End time"),
        "time_intervalTime":
            MessageLookupByLibrary.simpleMessage("Interval time(avg.)"),
        "time_seconds": MessageLookupByLibrary.simpleMessage("(s)"),
        "time_start": MessageLookupByLibrary.simpleMessage("start"),
        "time_startTime": MessageLookupByLibrary.simpleMessage("Start time"),
        "time_unit": MessageLookupByLibrary.simpleMessage("(minute)"),
        "versionNumberTitle":
            MessageLookupByLibrary.simpleMessage("Version Number"),
        "weekly": MessageLookupByLibrary.simpleMessage("single week")
      };
}
