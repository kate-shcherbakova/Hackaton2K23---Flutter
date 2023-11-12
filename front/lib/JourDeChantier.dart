class JourDeChantier {
  final int id;
  final DateTime heureDebut;
  final DateTime heureFin;
  final DateTime jour;
  final bool validee;
  final List<int> interventionsId;
  final List<String> problemes;
  final List<dynamic>? depenses;
  final int chantierId;

  JourDeChantier({
    required this.id,
    required this.heureDebut,
    required this.heureFin,
    required this.jour,
    required this.validee,
    required this.interventionsId,
    required this.problemes,
    required this.depenses,
    required this.chantierId,
  });

  // factory JourDeChantier.fromJson(Map<String, dynamic> json) {
  //   return JourDeChantier(
  //     id: json['id'],
  //     heureDebut: DateTime.parse(json['heureDebut']['hour']),
  //     heureFin: DateTime.parse(json['heureFin']['hour']),
  //     jour: DateTime(json['jour']['year'], json['jour']['month'], json['jour']['day']),
  //     validee: json['validee'],
  //     interventionsId: List<int>.from(json['interventionsId']),
  //     problemes: json['problemes'] != null ? List<String>.from(json['problemes']) : [],
  //     depenses: json['depenses'], // Use the appropriate data type for depenses
  //     chantierId: json['chantierId'],
  //   );
  // }

  factory JourDeChantier.fromJson(Map<String, dynamic> json) {
    return JourDeChantier(
      id: json['id'],
      heureDebut: DateTime(
        json['jour']['year'],
        json['jour']['month'],
        json['jour']['day'],
        json['heureDebut']['hour'],
        json['heureDebut']['minute'],
        json['heureDebut']['second'],
      ),
      heureFin: DateTime(
        json['jour']['year'],
        json['jour']['month'],
        json['jour']['day'],
        json['heureFin']['hour'],
        json['heureFin']['minute'],
        json['heureFin']['second'],
      ),
      jour: DateTime(
        json['jour']['year'],
        json['jour']['month'],
        json['jour']['day'],
      ),
      validee: json['validee'],
      interventionsId: List<int>.from(json['interventionsId']),
      problemes: json['problemes'] != null ? List<String>.from(json['problemes']) : [],
      depenses: json['depenses'], // Use the appropriate data type for depenses
      chantierId: json['chantierId'],
    );
  }

}

