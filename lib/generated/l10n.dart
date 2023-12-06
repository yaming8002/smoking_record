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

  /// `Smoking Record`
  String get appName {
    return Intl.message(
      'Smoking Record',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get page_add {
    return Intl.message(
      'New',
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

  /// `list`
  String get page_list {
    return Intl.message(
      'list',
      name: 'page_list',
      desc: '',
      args: [],
    );
  }

  /// `Previous page`
  String get page_previous {
    return Intl.message(
      'Previous page',
      name: 'page_previous',
      desc: '',
      args: [],
    );
  }

  /// `Next page`
  String get page_next {
    return Intl.message(
      'Next page',
      name: 'page_next',
      desc: '',
      args: [],
    );
  }

  /// `setting`
  String get page_setting {
    return Intl.message(
      'setting',
      name: 'page_setting',
      desc: '',
      args: [],
    );
  }

  /// `report`
  String get page_report {
    return Intl.message(
      'report',
      name: 'page_report',
      desc: '',
      args: [],
    );
  }

  /// `Share pictures`
  String get page_imageDisplayPage {
    return Intl.message(
      'Share pictures',
      name: 'page_imageDisplayPage',
      desc: '',
      args: [],
    );
  }

  /// `title`
  String get page_title {
    return Intl.message(
      'title',
      name: 'page_title',
      desc: '',
      args: [],
    );
  }

  /// `query`
  String get query {
    return Intl.message(
      'query',
      name: 'query',
      desc: '',
      args: [],
    );
  }

  /// `query criteria`
  String get query_criteria {
    return Intl.message(
      'query criteria',
      name: 'query_criteria',
      desc: '',
      args: [],
    );
  }

  /// `item`
  String get item {
    return Intl.message(
      'item',
      name: 'item',
      desc: '',
      args: [],
    );
  }

  /// `single week`
  String get weekly {
    return Intl.message(
      'single week',
      name: 'weekly',
      desc: '',
      args: [],
    );
  }

  /// `single day`
  String get daily {
    return Intl.message(
      'single day',
      name: 'daily',
      desc: '',
      args: [],
    );
  }

  /// `date range`
  String get date_range {
    return Intl.message(
      'date range',
      name: 'date_range',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `submit`
  String get submit {
    return Intl.message(
      'submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `all`
  String get all {
    return Intl.message(
      'all',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Estimate`
  String get add_Estimate {
    return Intl.message(
      'Estimate',
      name: 'add_Estimate',
      desc: '',
      args: [],
    );
  }

  /// `SmokingStatus`
  String get smokingStatus_status {
    return Intl.message(
      'SmokingStatus',
      name: 'smokingStatus_status',
      desc: '',
      args: [],
    );
  }

  /// `Total time`
  String get smokingStatus_total_time {
    return Intl.message(
      'Total time',
      name: 'smokingStatus_total_time',
      desc: '',
      args: [],
    );
  }

  /// `SmokingStatus_evaluate`
  String get smokingStatus_evaluate {
    return Intl.message(
      'SmokingStatus_evaluate',
      name: 'smokingStatus_evaluate',
      desc: '',
      args: [],
    );
  }

  /// `Smoking count`
  String get smokingStatus_smokeCount {
    return Intl.message(
      'Smoking count',
      name: 'smokingStatus_smokeCount',
      desc: '',
      args: [],
    );
  }

  /// `interva time`
  String get smokingStatus_interval {
    return Intl.message(
      'interva time',
      name: 'smokingStatus_interval',
      desc: '',
      args: [],
    );
  }

  /// `Start Recording`
  String get home_start {
    return Intl.message(
      'Start Recording',
      name: 'home_start',
      desc: '',
      args: [],
    );
  }

  /// `Please Wait\n{date}`
  String home_interval(Object date) {
    return Intl.message(
      'Please Wait\n$date',
      name: 'home_interval',
      desc: '',
      args: [date],
    );
  }

  /// `Preferences`
  String get setting_settings {
    return Intl.message(
      'Preferences',
      name: 'setting_settings',
      desc: '',
      args: [],
    );
  }

  /// `Language Settings`
  String get setting_languageSettings {
    return Intl.message(
      'Language Settings',
      name: 'setting_languageSettings',
      desc: '',
      args: [],
    );
  }

  /// `Crossover Time`
  String get setting_crossoverTime {
    return Intl.message(
      'Crossover Time',
      name: 'setting_crossoverTime',
      desc: '',
      args: [],
    );
  }

  /// `Single cigarette time`
  String get setting_singleCigaretteTime {
    return Intl.message(
      'Single cigarette time',
      name: 'setting_singleCigaretteTime',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get setting_notifications {
    return Intl.message(
      'Notifications',
      name: 'setting_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Single data editing`
  String get setting_edit_one {
    return Intl.message(
      'Single data editing',
      name: 'setting_edit_one',
      desc: '',
      args: [],
    );
  }

  /// `edit`
  String get setting_edit {
    return Intl.message(
      'edit',
      name: 'setting_edit',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get setting_save {
    return Intl.message(
      'save',
      name: 'setting_save',
      desc: '',
      args: [],
    );
  }

  /// `Disable ads`
  String get setting_stopAd {
    return Intl.message(
      'Disable ads',
      name: 'setting_stopAd',
      desc: '',
      args: [],
    );
  }

  /// `Save by quantity`
  String get setting_saveByCount {
    return Intl.message(
      'Save by quantity',
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

  /// `export`
  String get setting_export {
    return Intl.message(
      'export',
      name: 'setting_export',
      desc: '',
      args: [],
    );
  }

  /// `import`
  String get setting_import {
    return Intl.message(
      'import',
      name: 'setting_import',
      desc: '',
      args: [],
    );
  }

  /// `Data export`
  String get setting_exportData {
    return Intl.message(
      'Data export',
      name: 'setting_exportData',
      desc: '',
      args: [],
    );
  }

  /// `Data import`
  String get setting_importData {
    return Intl.message(
      'Data import',
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

  /// `Data Recalculation`
  String get setting_data_recalculation {
    return Intl.message(
      'Data Recalculation',
      name: 'setting_data_recalculation',
      desc: '',
      args: [],
    );
  }

  /// `Recalculation`
  String get setting_recalculation {
    return Intl.message(
      'Recalculation',
      name: 'setting_recalculation',
      desc: '',
      args: [],
    );
  }

  /// `Data Processing In Progress...`
  String get setting_data_processing_in_progress {
    return Intl.message(
      'Data Processing In Progress...',
      name: 'setting_data_processing_in_progress',
      desc: '',
      args: [],
    );
  }

  /// `Language setting`
  String get setting_language {
    return Intl.message(
      'Language setting',
      name: 'setting_language',
      desc: '',
      args: [],
    );
  }

  /// `Change day time`
  String get setting_changeDayTime {
    return Intl.message(
      'Change day time',
      name: 'setting_changeDayTime',
      desc: '',
      args: [],
    );
  }

  /// `Start Week on Monday`
  String get setting_isWeekStartMonday {
    return Intl.message(
      'Start Week on Monday',
      name: 'setting_isWeekStartMonday',
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

  /// `Start time`
  String get time_startTime {
    return Intl.message(
      'Start time',
      name: 'time_startTime',
      desc: '',
      args: [],
    );
  }

  /// `End time`
  String get time_endTime {
    return Intl.message(
      'End time',
      name: 'time_endTime',
      desc: '',
      args: [],
    );
  }

  /// `start`
  String get time_start {
    return Intl.message(
      'start',
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

  /// `Today / yesterday`
  String get time_by_day {
    return Intl.message(
      'Today / yesterday',
      name: 'time_by_day',
      desc: '',
      args: [],
    );
  }

  /// `This week / last week`
  String get time_by_week {
    return Intl.message(
      'This week / last week',
      name: 'time_by_week',
      desc: '',
      args: [],
    );
  }

  /// `Interval time`
  String get time_intervalTime {
    return Intl.message(
      'Interval time',
      name: 'time_intervalTime',
      desc: '',
      args: [],
    );
  }

  /// `(minute)`
  String get time_unit {
    return Intl.message(
      '(minute)',
      name: 'time_unit',
      desc: '',
      args: [],
    );
  }

  /// `(s)`
  String get time_seconds {
    return Intl.message(
      '(s)',
      name: 'time_seconds',
      desc: '',
      args: [],
    );
  }

  /// `(Freq.)`
  String get freq_unit {
    return Intl.message(
      '(Freq.)',
      name: 'freq_unit',
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

  /// `With each record, we find our direction, continuously moving towards a better self.`
  String get notification_msg1 {
    return Intl.message(
      'With each record, we find our direction, continuously moving towards a better self.',
      name: 'notification_msg1',
      desc: '',
      args: [],
    );
  }

  /// `Every entry helps you understand yourself better, keep moving forward.`
  String get notification_msg2 {
    return Intl.message(
      'Every entry helps you understand yourself better, keep moving forward.',
      name: 'notification_msg2',
      desc: '',
      args: [],
    );
  }

  /// `Let each record be an opportunity to explore yourself and enhance the quality of life`
  String get notification_msg3 {
    return Intl.message(
      'Let each record be an opportunity to explore yourself and enhance the quality of life',
      name: 'notification_msg3',
      desc: '',
      args: [],
    );
  }

  /// `Let us use these records to feel the life, step by step towards a healthier lifestyle.`
  String get notification_msg4 {
    return Intl.message(
      'Let us use these records to feel the life, step by step towards a healthier lifestyle.',
      name: 'notification_msg4',
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
