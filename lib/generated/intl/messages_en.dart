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

  static String m0(time) => "${time} AM";

  static String m1(time) =>
      "Tomorrow\'s sunrise in your location will starts at ${time} AM";

  static String m2(location, time) =>
      "Tomorrow\'s sunrise in ${location} is at ${time} AM";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "am": m0,
        "app_name": MessageLookupByLibrary.simpleMessage("Sunrise Alarm"),
        "at_sunrise": MessageLookupByLibrary.simpleMessage("At Sunrise"),
        "dark_mode": MessageLookupByLibrary.simpleMessage("Dark mode"),
        "debug_alarm_set":
            MessageLookupByLibrary.simpleMessage("Set fake alarm!"),
        "debug_wake_up_page":
            MessageLookupByLibrary.simpleMessage("Wake me up!"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "friday": MessageLookupByLibrary.simpleMessage("FRI"),
        "half_hour_after":
            MessageLookupByLibrary.simpleMessage("30 Minutes After"),
        "half_hour_before":
            MessageLookupByLibrary.simpleMessage("30 Minutes Before"),
        "monday": MessageLookupByLibrary.simpleMessage("MON"),
        "only_once": MessageLookupByLibrary.simpleMessage("Only once"),
        "repeat_daily": MessageLookupByLibrary.simpleMessage("Repeat daily"),
        "saturday": MessageLookupByLibrary.simpleMessage("SAT"),
        "sunday": MessageLookupByLibrary.simpleMessage("SUN"),
        "thursday": MessageLookupByLibrary.simpleMessage("THU"),
        "tomorrows_sunrise_at_your_location_description": m1,
        "tomorrows_sunrise_description": m2,
        "tuesday": MessageLookupByLibrary.simpleMessage("TUE"),
        "wake_me_up_title": MessageLookupByLibrary.simpleMessage("Wake me at:"),
        "wake_up_description":
            MessageLookupByLibrary.simpleMessage("Rise and shine!"),
        "wake_up_title": MessageLookupByLibrary.simpleMessage("Good morning!"),
        "wednesday": MessageLookupByLibrary.simpleMessage("WED")
      };
}
