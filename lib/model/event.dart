class Event {
  final String? id;
  final String date;
  final String sport;
  final String time;
  final String enemy;
  final String place;

  Event({this.id, required this.date,
    required this.sport,
    required this.time,
    required this.enemy,
    required this.place});


  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'sport': sport,
      'time': time,
      'enemy': enemy,
      'place': place,
    };
  }

  factory Event.fromJson(String id, Map<String, dynamic> json) {
    return Event(
      id: id,
      date: json['date'],
      sport: json['sport'],
      time: json['time'],
      enemy: json['enemy'],
      place: json['place'],
    );
  }
}