import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserModel {
  String? uuid;
  Membership? membership;
  Mode? mode;
  int? todoblock_duration;
  bool? direct_reschedule;
  bool? offline_mode;
  TimeOfDay? wakeup_time;
  TimeOfDay? sleep_time;
  bool? specific_icon;
  Color? primaryColor;
  String? background_design_raw;

  UserModel({
    this.uuid,
    this.membership,
    this.mode,
    this.todoblock_duration,
    this.direct_reschedule,
    this.offline_mode,
    this.wakeup_time,
    this.sleep_time,
    this.specific_icon,
    this.primaryColor = const Color(0xFFFFFFFF),
    this.background_design_raw,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    DateTime now = new DateTime.now();

    uuid = json['uuid'];
    membership = parseMembership(json['membership']);
    mode = parseMode(json['mode']);
    todoblock_duration = json['todoblock_duration'];
    direct_reschedule = json['direct_reschedule'];
    offline_mode = json['offline_mode'];
    wakeup_time = json['wakeup_time'] != null ? TimeOfDay(hour:int.parse(json['wakeup_time'].split(":")[0]),minute: int.parse(json['wakeup_time'].split(":")[1])) : null;
    sleep_time = json['sleep_time'] != null ? TimeOfDay(hour:int.parse(json['sleep_time'].split(":")[0]),minute: int.parse(json['sleep_time'].split(":")[1])) : null;
    specific_icon = json['specific_icon'];
    primaryColor = json['primaryColor'] != null ? Color(json['primaryColor']) : const Color(0xFFFFFFFF);
    background_design_raw = json['background_design_raw'];
  }

  Membership parseMembership(String membership){
    switch(membership){
      case "FREE":
        return Membership.FREE;
      case "PRO":
        return Membership.PRO;
      case "PREMIUM":
        return Membership.PREMIUM;
      default:
        return Membership.FREE;
    }
  }

  Mode parseMode(String modus){
    switch(modus){
      case "BUSINESS":
        return Mode.BUSINESS;
      case "PERSONAL":
        return Mode.PERSONAL;
      default:
        return Mode.PERSONAL;
    }
  }

  get background_design {
    if(true){ //background design a cached asset reference
      return AssetImage("assets/TDB_SplashScreen.png");
    }

    if(background_design_raw != null && isValidUrl(background_design_raw!)){ //background design a link
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

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'membership': membership?.toString(), // Assuming Membership has a toJson method
      'mode': mode?.toString(), // Assuming Mode has a toJson method
      'todoblock_duration': todoblock_duration,
      'direct_reschedule': direct_reschedule,
      'offline_mode': offline_mode,
      'wakeup_time': wakeup_time?.toString(),
      'sleep_time': sleep_time?.toString(),
      'specific_icon': specific_icon,
      'primaryColor': primaryColor?.value,
      'background_design_raw': background_design_raw,
    };
  }

}

enum Membership {
  FREE, PRO, PREMIUM
}

enum Mode {
  BUSINESS, PERSONAL
}

extension ModeFromString on String{
  Mode parseMode(){
    switch(this){
      case "BUSINESS":
        return Mode.BUSINESS;
      case "PERSONAL":
        return Mode.PERSONAL;
      default:
        return Mode.PERSONAL;
    }
  }
}