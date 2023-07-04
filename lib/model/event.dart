class Event {
  final String? id;
  final String date;
  final String sport;
  final String time;
  final String enemy;
  final String place;
  List<String> registeredUser;

  Event(
      {this.id,
      required this.date,
      required this.sport,
      required this.time,
      required this.enemy,
      required this.place,
      required this.registeredUser});

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'sport': sport,
      'time': time,
      'enemy': enemy,
      'place': place,
      'registeredUser': registeredUser
    };
  }

  factory Event.fromJson(String id, Map<dynamic, dynamic> json) {
    final registeredUser = json['registeredUser'];

    return Event(
      id: id,
      date: json['date'],
      sport: json['sport'],
      time: json['time'],
      enemy: json['enemy'],
      place: json['place'],
      registeredUser:
          registeredUser != null ? List<String>.from(registeredUser) : [],
    );
  }
}
