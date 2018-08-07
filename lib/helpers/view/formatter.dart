class Formatter {

  static String duration(Duration dur){
    if (dur.inMinutes > Duration.minutesPerHour){
      return '${dur.inMinutes ~/ Duration.minutesPerHour} h ${dur.inMinutes % Duration.minutesPerHour} min';
    }else{
      return '${dur.inMinutes} min';
    }
  }
}