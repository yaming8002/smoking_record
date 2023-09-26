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
      "${date} had the same smoking count as the previous day. Keep it up!";

  static String m1(date) =>
      "${date}\'s smoking count is less than the previous day. Good job!";

  static String m2(date) =>
      "${date}\'s smoking count is more than the previous day. Stay strong and push on!";

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
            MessageLookupByLibrary.simpleMessage("input feel"),
        "image_compare_this":
            MessageLookupByLibrary.simpleMessage("Compare Today"),
        "image_compare_yesterday":
            MessageLookupByLibrary.simpleMessage("Compare Yesterday"),
        "msg_congratulationsReduced": m3,
        "msg_endTimeFutureError": MessageLookupByLibrary.simpleMessage(
            "End time cannot be in the future!"),
        "msg_keepItUp": MessageLookupByLibrary.simpleMessage(
            "Keep it up! Gradually reduce your smoking."),
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
            MessageLookupByLibrary.simpleMessage("Language Setting"),
        "setting_privacyAndServiceTerms":
            MessageLookupByLibrary.simpleMessage("Privacy & Service Terms"),
        "setting_recordNotification":
            MessageLookupByLibrary.simpleMessage("Record Notification"),
        "setting_recordNotificationTime":
            MessageLookupByLibrary.simpleMessage("Record Notification Time"),
        "setting_save": MessageLookupByLibrary.simpleMessage("Save"),
        "setting_saveByCount":
            MessageLookupByLibrary.simpleMessage("Save By Count"),
        "setting_singleCigaretteTime":
            MessageLookupByLibrary.simpleMessage("Single Cigarette Time"),
        "smokingStatus_cumulativeTime":
            MessageLookupByLibrary.simpleMessage("Cumulative Time"),
        "smokingStatus_evaluate":
            MessageLookupByLibrary.simpleMessage("Feeling Rating"),
        "smokingStatus_smokeCount":
            MessageLookupByLibrary.simpleMessage("Cigarette Count"),
        "smokingStatus_spacing":
            MessageLookupByLibrary.simpleMessage("Spacing Time"),
        "smokingStatus_status":
            MessageLookupByLibrary.simpleMessage("Smoking Status"),
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
        "time_unit": MessageLookupByLibrary.simpleMessage("(mins)")
      };
}
