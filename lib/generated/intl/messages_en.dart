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

  static String m3(count, yesterday, dayBefore) =>
      "Congratulations! You smoked ${count} fewer cigarettes on ${yesterday} than on ${dayBefore}.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about_app": MessageLookupByLibrary.simpleMessage("About This App"),
        "contact_author":
            MessageLookupByLibrary.simpleMessage("Contact Author"),
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
        "msg_congratulationsReduced": m3,
        "msg_endTimeFutureError": MessageLookupByLibrary.simpleMessage(
            "End time cannot be in the future!"),
        "msg_keepItUp": MessageLookupByLibrary.simpleMessage(
            "Keep it up! Gradually reduce the number of cigarettes."),
        "page_add": MessageLookupByLibrary.simpleMessage("Add"),
        "page_home": MessageLookupByLibrary.simpleMessage("Smoking Record"),
        "page_imageDisplayPage":
            MessageLookupByLibrary.simpleMessage("Share Image"),
        "page_list": MessageLookupByLibrary.simpleMessage("List"),
        "page_next": MessageLookupByLibrary.simpleMessage("Next Page"),
        "page_previous": MessageLookupByLibrary.simpleMessage("Previous Page"),
        "page_report": MessageLookupByLibrary.simpleMessage("Report"),
        "page_setting": MessageLookupByLibrary.simpleMessage("Settings"),
        "page_title": MessageLookupByLibrary.simpleMessage("Title"),
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
        "setting_changeDayNotification":
            MessageLookupByLibrary.simpleMessage("Change Day Notification"),
        "setting_changeDayTime":
            MessageLookupByLibrary.simpleMessage("Change Day Time"),
        "setting_dataProcessing":
            MessageLookupByLibrary.simpleMessage("Data Processing"),
        "setting_edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "setting_edit_one":
            MessageLookupByLibrary.simpleMessage("Edit Single Data"),
        "setting_exportCsv":
            MessageLookupByLibrary.simpleMessage("Export Data to CSV"),
        "setting_importCsv": MessageLookupByLibrary.simpleMessage("Import CSV"),
        "setting_importData":
            MessageLookupByLibrary.simpleMessage("Data Import"),
        "setting_language":
            MessageLookupByLibrary.simpleMessage("Language Settings"),
        "setting_privacyAndServiceTerms":
            MessageLookupByLibrary.simpleMessage("Privacy and Service Terms"),
        "setting_recordNotification":
            MessageLookupByLibrary.simpleMessage("Record Notification"),
        "setting_recordNotificationTime":
            MessageLookupByLibrary.simpleMessage("Record Notification Time"),
        "setting_save": MessageLookupByLibrary.simpleMessage("Save"),
        "setting_saveByCount":
            MessageLookupByLibrary.simpleMessage("Save by Count"),
        "setting_singleCigaretteTime":
            MessageLookupByLibrary.simpleMessage("Single Cigarette Time"),
        "setting_stopAd": MessageLookupByLibrary.simpleMessage("stop Ad"),
        "smokingStatus_cumulativeTime":
            MessageLookupByLibrary.simpleMessage("Cumulative Time"),
        "smokingStatus_evaluate":
            MessageLookupByLibrary.simpleMessage("Evaluation Rating"),
        "smokingStatus_smokeCount":
            MessageLookupByLibrary.simpleMessage("Number of Cigarettes"),
        "smokingStatus_spacing":
            MessageLookupByLibrary.simpleMessage("Spacing Time"),
        "smokingStatus_status":
            MessageLookupByLibrary.simpleMessage("Smoking Status"),
        "time_Time": MessageLookupByLibrary.simpleMessage("Time"),
        "time_by_day":
            MessageLookupByLibrary.simpleMessage("Today (Yesterday)"),
        "time_by_week":
            MessageLookupByLibrary.simpleMessage("This Week (Last Week)"),
        "time_date": MessageLookupByLibrary.simpleMessage("Date"),
        "time_end": MessageLookupByLibrary.simpleMessage("End"),
        "time_endTime": MessageLookupByLibrary.simpleMessage("End Time"),
        "time_spacingTime":
            MessageLookupByLibrary.simpleMessage("Spacing Time"),
        "time_start": MessageLookupByLibrary.simpleMessage("Start"),
        "time_startTime": MessageLookupByLibrary.simpleMessage("Start Time"),
        "time_unit": MessageLookupByLibrary.simpleMessage("(Minutes)")
      };
}
