import '../../helpers/view/localization.dart';

class Formatter {

  static String shortDuration(Duration dur){
    if (dur.inMinutes > Duration.minutesPerHour){
      return '${dur.inMinutes ~/ Duration.minutesPerHour} ${Localization.textH} ${dur.inMinutes % Duration.minutesPerHour} ${Localization.textMin}';
    }else{
      return '${dur.inMinutes} ${Localization.textMin}';
    }
  }

  static String longDuration(Duration dur){
    if (dur.inHours > Duration.hoursPerDay){
      return '${dur.inHours ~/ Duration.hoursPerDay} ${Localization.textD} ${(dur.inHours ~/ Duration.hoursPerDay) % Duration.minutesPerHour} ${Localization.textH} ${dur.inMinutes % Duration.minutesPerHour} ${Localization.textMin}';
    }else if (dur.inMinutes > Duration.minutesPerHour){
      return '${dur.inMinutes ~/ Duration.minutesPerHour} ${Localization.textH} ${dur.inMinutes % Duration.minutesPerHour} ${Localization.textMin}';
    }else{
      return '${dur.inMinutes} ${Localization.textMin}';
    }
  }

  static String distance(int dist){
    if (dist < 1000.0){
      return '${dist} ${Localization.textM}';
    }else{
      return '${dist ~/ 1000} ${Localization.textKm}';
    }
  }
}