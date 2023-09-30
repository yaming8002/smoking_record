// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Add`
  String get page_add {
    return Intl.message(
      'Add',
      name: 'page_add',
      desc: '',
      args: [],
    );
  }

  /// `Smoking Record`
  String get page_home {
    return Intl.message(
      'Smoking Record',
      name: 'page_home',
      desc: '',
      args: [],
    );
  }

  /// `List`
  String get page_list {
    return Intl.message(
      'List',
      name: 'page_list',
      desc: '',
      args: [],
    );
  }

  /// `Previous Page`
  String get page_previous {
    return Intl.message(
      'Previous Page',
      name: 'page_previous',
      desc: '',
      args: [],
    );
  }

  /// `Next Page`
  String get page_next {
    return Intl.message(
      'Next Page',
      name: 'page_next',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get page_setting {
    return Intl.message(
      'Settings',
      name: 'page_setting',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get page_report {
    return Intl.message(
      'Report',
      name: 'page_report',
      desc: '',
      args: [],
    );
  }

  /// `Share Image`
  String get page_imageDisplayPage {
    return Intl.message(
      'Share Image',
      name: 'page_imageDisplayPage',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get page_title {
    return Intl.message(
      'Title',
      name: 'page_title',
      desc: '',
      args: [],
    );
  }

  /// `Smoking Status`
  String get smokingStatus_status {
    return Intl.message(
      'Smoking Status',
      name: 'smokingStatus_status',
      desc: '',
      args: [],
    );
  }

  /// `Cumulative Time`
  String get smokingStatus_cumulativeTime {
    return Intl.message(
      'Cumulative Time',
      name: 'smokingStatus_cumulativeTime',
      desc: '',
      args: [],
    );
  }

  /// `Evaluation Rating`
  String get smokingStatus_evaluate {
    return Intl.message(
      'Evaluation Rating',
      name: 'smokingStatus_evaluate',
      desc: '',
      args: [],
    );
  }

  /// `Number of Cigarettes`
  String get smokingStatus_smokeCount {
    return Intl.message(
      'Number of Cigarettes',
      name: 'smokingStatus_smokeCount',
      desc: '',
      args: [],
    );
  }

  /// `Spacing Time`
  String get smokingStatus_spacing {
    return Intl.message(
      'Spacing Time',
      name: 'smokingStatus_spacing',
      desc: '',
      args: [],
    );
  }

  /// `Edit Single Data`
  String get setting_edit_one {
    return Intl.message(
      'Edit Single Data',
      name: 'setting_edit_one',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get setting_edit {
    return Intl.message(
      'Edit',
      name: 'setting_edit',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get setting_save {
    return Intl.message(
      'Save',
      name: 'setting_save',
      desc: '',
      args: [],
    );
  }

  /// `stop Ad`
  String get setting_stopAd {
    return Intl.message(
      'stop Ad',
      name: 'setting_stopAd',
      desc: '',
      args: [],
    );
  }

  /// `Save by Count`
  String get setting_saveByCount {
    return Intl.message(
      'Save by Count',
      name: 'setting_saveByCount',
      desc: '',
      args: [],
    );
  }

  /// `Privacy and Service Terms`
  String get setting_privacyAndServiceTerms {
    return Intl.message(
      'Privacy and Service Terms',
      name: 'setting_privacyAndServiceTerms',
      desc: '',
      args: [],
    );
  }

  /// `Import CSV`
  String get setting_importCsv {
    return Intl.message(
      'Import CSV',
      name: 'setting_importCsv',
      desc: '',
      args: [],
    );
  }

  /// `Export Data to CSV`
  String get setting_exportCsv {
    return Intl.message(
      'Export Data to CSV',
      name: 'setting_exportCsv',
      desc: '',
      args: [],
    );
  }

  /// `Data Import`
  String get setting_importData {
    return Intl.message(
      'Data Import',
      name: 'setting_importData',
      desc: '',
      args: [],
    );
  }

  /// `Data Processing`
  String get setting_dataProcessing {
    return Intl.message(
      'Data Processing',
      name: 'setting_dataProcessing',
      desc: '',
      args: [],
    );
  }

  /// `Language Settings`
  String get setting_language {
    return Intl.message(
      'Language Settings',
      name: 'setting_language',
      desc: '',
      args: [],
    );
  }

  /// `Change Day Time`
  String get setting_changeDayTime {
    return Intl.message(
      'Change Day Time',
      name: 'setting_changeDayTime',
      desc: '',
      args: [],
    );
  }

  /// `Single Cigarette Time`
  String get setting_singleCigaretteTime {
    return Intl.message(
      'Single Cigarette Time',
      name: 'setting_singleCigaretteTime',
      desc: '',
      args: [],
    );
  }

  /// `Change Day Notification`
  String get setting_changeDayNotification {
    return Intl.message(
      'Change Day Notification',
      name: 'setting_changeDayNotification',
      desc: '',
      args: [],
    );
  }

  /// `Record Notification`
  String get setting_recordNotification {
    return Intl.message(
      'Record Notification',
      name: 'setting_recordNotification',
      desc: '',
      args: [],
    );
  }

  /// `Record Notification Time`
  String get setting_recordNotificationTime {
    return Intl.message(
      'Record Notification Time',
      name: 'setting_recordNotificationTime',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get time_date {
    return Intl.message(
      'Date',
      name: 'time_date',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time_Time {
    return Intl.message(
      'Time',
      name: 'time_Time',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get time_startTime {
    return Intl.message(
      'Start Time',
      name: 'time_startTime',
      desc: '',
      args: [],
    );
  }

  /// `End Time`
  String get time_endTime {
    return Intl.message(
      'End Time',
      name: 'time_endTime',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get time_start {
    return Intl.message(
      'Start',
      name: 'time_start',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get time_end {
    return Intl.message(
      'End',
      name: 'time_end',
      desc: '',
      args: [],
    );
  }

  /// `Today (Yesterday)`
  String get time_by_day {
    return Intl.message(
      'Today (Yesterday)',
      name: 'time_by_day',
      desc: '',
      args: [],
    );
  }

  /// `This Week (Last Week)`
  String get time_by_week {
    return Intl.message(
      'This Week (Last Week)',
      name: 'time_by_week',
      desc: '',
      args: [],
    );
  }

  /// `Spacing Time`
  String get time_spacingTime {
    return Intl.message(
      'Spacing Time',
      name: 'time_spacingTime',
      desc: '',
      args: [],
    );
  }

  /// `(Minutes)`
  String get time_unit {
    return Intl.message(
      '(Minutes)',
      name: 'time_unit',
      desc: '',
      args: [],
    );
  }

  /// `End time cannot be in the future!`
  String get msg_endTimeFutureError {
    return Intl.message(
      'End time cannot be in the future!',
      name: 'msg_endTimeFutureError',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations! You smoked {count} fewer cigarettes on {yesterday} than on {dayBefore}.`
  String msg_congratulationsReduced(
      Object count, Object yesterday, Object dayBefore) {
    return Intl.message(
      'Congratulations! You smoked $count fewer cigarettes on $yesterday than on $dayBefore.',
      name: 'msg_congratulationsReduced',
      desc: '',
      args: [count, yesterday, dayBefore],
    );
  }

  /// `Keep it up! Gradually reduce the number of cigarettes.`
  String get msg_keepItUp {
    return Intl.message(
      'Keep it up! Gradually reduce the number of cigarettes.',
      name: 'msg_keepItUp',
      desc: '',
      args: [],
    );
  }

  /// `About This App`
  String get about_app {
    return Intl.message(
      'About This App',
      name: 'about_app',
      desc: '',
      args: [],
    );
  }

  /// `Contact Author`
  String get contact_author {
    return Intl.message(
      'Contact Author',
      name: 'contact_author',
      desc: '',
      args: [],
    );
  }

  /// `Compare Today`
  String get image_compare_this {
    return Intl.message(
      'Compare Today',
      name: 'image_compare_this',
      desc: '',
      args: [],
    );
  }

  /// `Compare Yesterday`
  String get image_compare_yesterday {
    return Intl.message(
      'Compare Yesterday',
      name: 'image_compare_yesterday',
      desc: '',
      args: [],
    );
  }

  /// `The number of cigarettes smoked on {date} is less than the previous day, well done!`
  String image_Smoking_Less(Object date) {
    return Intl.message(
      'The number of cigarettes smoked on $date is less than the previous day, well done!',
      name: 'image_Smoking_Less',
      desc: '',
      args: [date],
    );
  }

  /// `{date} has the same number of cigarettes as the previous day, keep it up!`
  String image_Smoking_Equal(Object date) {
    return Intl.message(
      '$date has the same number of cigarettes as the previous day, keep it up!',
      name: 'image_Smoking_Equal',
      desc: '',
      args: [date],
    );
  }

  /// `The number of cigarettes smoked on {date} is more than the previous day, keep going!`
  String image_Smoking_More(Object date) {
    return Intl.message(
      'The number of cigarettes smoked on $date is more than the previous day, keep going!',
      name: 'image_Smoking_More',
      desc: '',
      args: [date],
    );
  }

  /// `Share`
  String get image_Share {
    return Intl.message(
      'Share',
      name: 'image_Share',
      desc: '',
      args: [],
    );
  }

  /// `Enter feelings`
  String get image_Smoking_feel {
    return Intl.message(
      'Enter feelings',
      name: 'image_Smoking_feel',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy_title {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy_title',
      desc: '',
      args: [],
    );
  }

  /// `1. Data Collection`
  String get privacyPolicy_section1_title {
    return Intl.message(
      '1. Data Collection',
      name: 'privacyPolicy_section1_title',
      desc: '',
      args: [],
    );
  }

  /// `Our App focuses on recording user habits. We only collect data related to user habits, and this data is completely anonymous, without any identifiable information.`
  String get privacyPolicy_section1_content {
    return Intl.message(
      'Our App focuses on recording user habits. We only collect data related to user habits, and this data is completely anonymous, without any identifiable information.',
      name: 'privacyPolicy_section1_content',
      desc: '',
      args: [],
    );
  }

  /// `2. Use of Data`
  String get privacyPolicy_section2_title {
    return Intl.message(
      '2. Use of Data',
      name: 'privacyPolicy_section2_title',
      desc: '',
      args: [],
    );
  }

  /// `The collected data is only used to help users track their habits. We will not share, sell, or transfer this data to any third party.`
  String get privacyPolicy_section2_content {
    return Intl.message(
      'The collected data is only used to help users track their habits. We will not share, sell, or transfer this data to any third party.',
      name: 'privacyPolicy_section2_content',
      desc: '',
      args: [],
    );
  }

  /// `3. Data Export and Import`
  String get privacyPolicy_section3_title {
    return Intl.message(
      '3. Data Export and Import',
      name: 'privacyPolicy_section3_title',
      desc: '',
      args: [],
    );
  }

  /// `Users can choose to export or import their habit data. It should be noted that the exported or imported data only contains the user's habits and does not contain any identifiable information.`
  String get privacyPolicy_section3_content {
    return Intl.message(
      'Users can choose to export or import their habit data. It should be noted that the exported or imported data only contains the user\'s habits and does not contain any identifiable information.',
      name: 'privacyPolicy_section3_content',
      desc: '',
      args: [],
    );
  }

  /// `4. Sharing Function`
  String get privacyPolicy_section4_title {
    return Intl.message(
      '4. Sharing Function',
      name: 'privacyPolicy_section4_title',
      desc: '',
      args: [],
    );
  }

  /// `Our App provides a sharing function, allowing users to share their habit data. This shared data is anonymous and does not contain any personal identifiable information.`
  String get privacyPolicy_section4_content {
    return Intl.message(
      'Our App provides a sharing function, allowing users to share their habit data. This shared data is anonymous and does not contain any personal identifiable information.',
      name: 'privacyPolicy_section4_content',
      desc: '',
      args: [],
    );
  }

  /// `5. Data Protection`
  String get privacyPolicy_section5_title {
    return Intl.message(
      '5. Data Protection',
      name: 'privacyPolicy_section5_title',
      desc: '',
      args: [],
    );
  }

  /// `We value your data protection. Although the data is stored locally, we have taken appropriate measures to ensure the security of the data.`
  String get privacyPolicy_section5_content {
    return Intl.message(
      'We value your data protection. Although the data is stored locally, we have taken appropriate measures to ensure the security of the data.',
      name: 'privacyPolicy_section5_content',
      desc: '',
      args: [],
    );
  }

  /// `6. Third-party Advertising Service`
  String get privacyPolicy_section6_title {
    return Intl.message(
      '6. Third-party Advertising Service',
      name: 'privacyPolicy_section6_title',
      desc: '',
      args: [],
    );
  }

  /// `Our App uses Google's advertising service. Please note that Google may use cookies or other technologies to provide advertisements. These technologies are unrelated to the habit data in our App and will not be used to identify users.`
  String get privacyPolicy_section6_content {
    return Intl.message(
      'Our App uses Google\'s advertising service. Please note that Google may use cookies or other technologies to provide advertisements. These technologies are unrelated to the habit data in our App and will not be used to identify users.',
      name: 'privacyPolicy_section6_content',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
