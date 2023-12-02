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

  static String m0(date) =>
      "${date} has the same number of cigarettes as the previous day, keep it up!";

  static String m1(date) =>
      "The number of cigarettes smoked on ${date} is less than the previous day, well done!";

  static String m2(date) =>
      "The number of cigarettes smoked on ${date} is more than the previous day, keep going!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about_app": MessageLookupByLibrary.simpleMessage("About This App"),
        "add_Estimate": MessageLookupByLibrary.simpleMessage("Estimate"),
        "all": MessageLookupByLibrary.simpleMessage("all"),
        "appName": MessageLookupByLibrary.simpleMessage("Smoking Record"),
        "cancel": MessageLookupByLibrary.simpleMessage("cancel"),
        "contact_author":
            MessageLookupByLibrary.simpleMessage("Contact Author"),
        "daily": MessageLookupByLibrary.simpleMessage("single day"),
        "date_range": MessageLookupByLibrary.simpleMessage("date range"),
        "freq_unit": MessageLookupByLibrary.simpleMessage("(Freq.)"),
        "home_start": MessageLookupByLibrary.simpleMessage("Start Recording"),
        "image_Share": MessageLookupByLibrary.simpleMessage("Share"),
        "image_Smoking_Equal": m0,
        "image_Smoking_Less": m1,
        "image_Smoking_More": m2,
        "image_Smoking_feel":
            MessageLookupByLibrary.simpleMessage("Enter feelings"),
        "image_compare_this":
            MessageLookupByLibrary.simpleMessage("Compare Today"),
        "image_compare_yesterday":
            MessageLookupByLibrary.simpleMessage("Compare Yesterday"),
        "item": MessageLookupByLibrary.simpleMessage("item"),
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
        "privacyPolicy_section1_content": MessageLookupByLibrary.simpleMessage(
            "Our App focuses on recording user habits. We only collect data related to user habits, and this data is completely anonymous, without any identifiable information."),
        "privacyPolicy_section1_title":
            MessageLookupByLibrary.simpleMessage("1. Data Collection"),
        "privacyPolicy_section2_content": MessageLookupByLibrary.simpleMessage(
            "The collected data is only used to help users track their habits. We will not share, sell, or transfer this data to any third party."),
        "privacyPolicy_section2_title":
            MessageLookupByLibrary.simpleMessage("2. Use of Data"),
        "privacyPolicy_section3_content": MessageLookupByLibrary.simpleMessage(
            "Users can choose to export or import their habit data. It should be noted that the exported or imported data only contains the user\'s habits and does not contain any identifiable information."),
        "privacyPolicy_section3_title":
            MessageLookupByLibrary.simpleMessage("3. Data Export and Import"),
        "privacyPolicy_section4_content": MessageLookupByLibrary.simpleMessage(
            "Our App provides a sharing function, allowing users to share their habit data. This shared data is anonymous and does not contain any personal identifiable information."),
        "privacyPolicy_section4_title":
            MessageLookupByLibrary.simpleMessage("4. Sharing Function"),
        "privacyPolicy_section5_content": MessageLookupByLibrary.simpleMessage(
            "We value your data protection. Although the data is stored locally, we have taken appropriate measures to ensure the security of the data."),
        "privacyPolicy_section5_title":
            MessageLookupByLibrary.simpleMessage("5. Data Protection"),
        "privacyPolicy_section6_content": MessageLookupByLibrary.simpleMessage(
            "Our App uses Google\'s advertising service. Please note that Google may use cookies or other technologies to provide advertisements. These technologies are unrelated to the habit data in our App and will not be used to identify users."),
        "privacyPolicy_section6_title": MessageLookupByLibrary.simpleMessage(
            "6. Third-party Advertising Service"),
        "privacyPolicy_title":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "query": MessageLookupByLibrary.simpleMessage("query"),
        "query_criteria":
            MessageLookupByLibrary.simpleMessage("query criteria"),
        "setting_changeDayNotification":
            MessageLookupByLibrary.simpleMessage("Day change notification"),
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
        "setting_recordNotification":
            MessageLookupByLibrary.simpleMessage("Record Notification"),
        "setting_recordNotificationTime":
            MessageLookupByLibrary.simpleMessage("Record notification time"),
        "setting_save": MessageLookupByLibrary.simpleMessage("save"),
        "setting_saveByCount":
            MessageLookupByLibrary.simpleMessage("Save by quantity"),
        "setting_settings": MessageLookupByLibrary.simpleMessage("Preferences"),
        "setting_singleCigaretteTime":
            MessageLookupByLibrary.simpleMessage("Single cigarette time"),
        "setting_stopAd": MessageLookupByLibrary.simpleMessage("Disable ads"),
        "smokingStatus_evaluate":
            MessageLookupByLibrary.simpleMessage("SmokingStatus_evaluate"),
        "smokingStatus_smokeCount":
            MessageLookupByLibrary.simpleMessage("Smoking count"),
        "smokingStatus_spacing":
            MessageLookupByLibrary.simpleMessage("spacing time"),
        "smokingStatus_status":
            MessageLookupByLibrary.simpleMessage("SmokingStatus"),
        "smokingStatus_total_time":
            MessageLookupByLibrary.simpleMessage("Total time"),
        "submit": MessageLookupByLibrary.simpleMessage("submit"),
        "time_Time": MessageLookupByLibrary.simpleMessage("Time"),
        "time_by_day":
            MessageLookupByLibrary.simpleMessage(" Today / yesterday"),
        "time_by_week":
            MessageLookupByLibrary.simpleMessage("This week / last week"),
        "time_date": MessageLookupByLibrary.simpleMessage("Date"),
        "time_end": MessageLookupByLibrary.simpleMessage("End"),
        "time_endTime": MessageLookupByLibrary.simpleMessage("End time"),
        "time_seconds": MessageLookupByLibrary.simpleMessage("(s)"),
        "time_spacingTime":
            MessageLookupByLibrary.simpleMessage("Interval time"),
        "time_start": MessageLookupByLibrary.simpleMessage("start"),
        "time_startTime": MessageLookupByLibrary.simpleMessage("Start time"),
        "time_unit": MessageLookupByLibrary.simpleMessage("(minute)"),
        "weekly": MessageLookupByLibrary.simpleMessage("single week")
      };
}
