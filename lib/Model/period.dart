class Period {
  final int days;
  final DateTime start;
  final DateTime end;

  Period(this.days, this.start, this.end);

  Period.fromJson(Map<String, dynamic> json)
      : days = json['days'],
        start = json['start_date'],
        end = json['end_date'];

  Map<String, dynamic> toJson() => {
        'days': days,
        'start_date': start,
        'end_date': end,
      };

  static Period fromMap(Map<String, dynamic> map) {
    return Period(
      map['days'],
      map['start_date'],
      map['end_date'],
    );
  }
}
