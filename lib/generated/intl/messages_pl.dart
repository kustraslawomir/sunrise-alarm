// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pl locale. All the
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
  String get localeName => 'pl';

  static String m0(time) => "${time}";

  static String m1(time) =>
      "Jutrzejszy wschód słońca w twojej lokalizacji zacznie się o ${time}";

  static String m2(location, time) =>
      "Jutrzejszy wschód słońca w ${location} zacznie się o ${time}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "am": m0,
        "app_name": MessageLookupByLibrary.simpleMessage("Sunrise Alarm"),
        "at_sunrise":
            MessageLookupByLibrary.simpleMessage("O wschodzie słońca"),
        "dark_mode": MessageLookupByLibrary.simpleMessage("Ciemny motyw"),
        "done": MessageLookupByLibrary.simpleMessage("Gotowe"),
        "friday": MessageLookupByLibrary.simpleMessage("PT"),
        "half_hour_after": MessageLookupByLibrary.simpleMessage("30 minut po"),
        "half_hour_before":
            MessageLookupByLibrary.simpleMessage("30 minut przed"),
        "monday": MessageLookupByLibrary.simpleMessage("PON"),
        "only_once": MessageLookupByLibrary.simpleMessage("Tylko raz"),
        "repeat_daily":
            MessageLookupByLibrary.simpleMessage("Powtarzaj codziennie"),
        "saturday": MessageLookupByLibrary.simpleMessage("SO"),
        "sunday": MessageLookupByLibrary.simpleMessage("ND"),
        "thursday": MessageLookupByLibrary.simpleMessage("CZW"),
        "tomorrows_sunrise_at_your_location_description": m1,
        "tomorrows_sunrise_description": m2,
        "tuesday": MessageLookupByLibrary.simpleMessage("WT"),
        "wake_me_up_title": MessageLookupByLibrary.simpleMessage("Obudź mnie:"),
        "wake_up_description":
            MessageLookupByLibrary.simpleMessage("Miłego dnia"),
        "wake_up_title": MessageLookupByLibrary.simpleMessage("Dzień dobry!"),
        "wednesday": MessageLookupByLibrary.simpleMessage("ŚR")
      };
}
