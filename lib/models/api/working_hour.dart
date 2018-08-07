class WorkingHour {

  String day;
  String open;
  String close;

  WorkingHour({this.day, this.open, this.close});

  factory WorkingHour.fromJson(Map<String, dynamic> json) {
    return WorkingHour(
      day: json['day'],
      open: json['open'],
      close: json['close'],
    );
  }
}