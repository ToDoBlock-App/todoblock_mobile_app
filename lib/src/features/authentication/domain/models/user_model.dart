import 'package:flutter/widgets.dart';

class UserModel {
  late int uuid;
  late Membership membership;
  late Mode mode;
  late int todoblock_duration;
  late bool direct_reschedule;
  late bool offline_mode;
  late DateTime wakeup_time;
  late DateTime sleep_time;
  late bool specific_icon;
  Color primaryColor = Color(0xFFFFFFFF);
  late String background_design_raw;

  UserModel({
    required this.uuid,
    required this.membership,
    required this.mode,
    required this.todoblock_duration,
    required this.direct_reschedule,
    required this.offline_mode,
    required this.wakeup_time,
    required this.sleep_time,
    required this.specific_icon,
    this.primaryColor = const Color(0xFFFFFFFF),
    required this.background_design_raw,
  });

  get background_design {
    if(true){ //background design a cached asset reference
      //return image
    }

    if(isValidUrl(background_design_raw)){ //background design a link
      //return image
    }
  }

  bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      // If Uri.parse() fails, the string is not a valid URL
      return false;
    }
  }

}

enum Membership {
  FREE, PRO, PREMIUM
}

enum Mode {
  BUSINESS, PERSONAL
}