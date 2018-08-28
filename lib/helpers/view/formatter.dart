import '../../helpers/view/localization.dart';

class Formatter {

  static String shortDuration(Duration dur){
    if (dur.inMinutes > Duration.minutesPerHour){
      return '${dur.inMinutes ~/ Duration.minutesPerHour} ${Localization.word('h')} ${dur.inMinutes % Duration.minutesPerHour} ${Localization.word('min')}';
    }else{
      return '${dur.inMinutes} ${Localization.word('min')}';
    }
  }

  static String longDuration(Duration dur){
    if (dur.inHours > Duration.hoursPerDay){
      return '${dur.inHours ~/ Duration.hoursPerDay} ${Localization.word('d')} ${(dur.inHours ~/ Duration.hoursPerDay) % Duration.minutesPerHour} ${Localization.word('h')} ${dur.inMinutes % Duration.minutesPerHour} ${Localization.word('min')}';
    }else if (dur.inMinutes > Duration.minutesPerHour){
      return '${dur.inMinutes ~/ Duration.minutesPerHour} ${Localization.word('h')} ${dur.inMinutes % Duration.minutesPerHour} ${Localization.word('min')}';
    }else{
      return '${dur.inMinutes} ${Localization.word('min')}';
    }
  }

  static String distance(int dist){
    if (dist < 1000.0){
      return '${dist} ${Localization.word('m')}';
    }else{
      return '${dist ~/ 1000} ${Localization.word('km')}';
    }
  }
}