// class Chantier {
//   final int id;
//   final List<Materiel> materiel;
//   final int? demandeDeChantierId;
//   final List<int>? joursDeChantierId;
//
//   Chantier({
//     required this.id,
//     required this.materiel,
//     this.demandeDeChantierId,
//     this.joursDeChantierId,
//   });
//
//   factory Chantier.fromJson(Map<String, dynamic> json) {
//     List<Materiel> materielList = [];
//     if (json['materiel'] != null) {
//       json['materiel'].forEach((materiel) {
//         materielList.add(Materiel.fromJson(materiel));
//       });
//     }
//
//     List<int>? joursDeChantierId;
//     if (json['joursDeChantierId'] != null) {
//       joursDeChantierId = List<int>.from(json['joursDeChantierId']);
//     }
//
//     return Chantier(
//       id: json['id'],
//       materiel: materielList,
//       demandeDeChantierId: json['demandeDeChantierId'],
//       joursDeChantierId: joursDeChantierId,
//     );
//   }
// }
//
// class Materiel {
//   final String nom;
//   final int quantite;
//
//   Materiel({
//     required this.nom,
//     required this.quantite,
//   });
//
//   factory Materiel.fromJson(Map<String, dynamic> json) {
//     return Materiel(
//       nom: json['nom'],
//       quantite: json['quantite'],
//     );
//   }
// }

class Chantier {
  final int id;
  final List<Materiel> materiel;
  final int? demandeDeChantierId;
  final List<int>? joursDeChantierId;

  Chantier({
    required this.id,
    required this.materiel,
    this.demandeDeChantierId,
    this.joursDeChantierId,
  });

  factory Chantier.fromJson(Map<String, dynamic> json) {
    List<Materiel> materielList = [];
    if (json['materiel'] != null) {
      json['materiel'].forEach((materiel) {
        materielList.add(Materiel.fromJson(materiel));
      });
    }

    List<int>? joursDeChantierId;
    if (json['joursDeChantierId'] != null) {
      // Ensure that joursDeChantierId is parsed as List<int>
      joursDeChantierId = List<int>.from(json['joursDeChantierId']);
    }

    return Chantier(
      id: json['id'],
      materiel: materielList,
      demandeDeChantierId: json['demandeDeChantierId'],
      joursDeChantierId: joursDeChantierId,
    );
  }
}

class Materiel {
  final String nom;
  final int quantite;

  Materiel({
    required this.nom,
    required this.quantite,
  });

  factory Materiel.fromJson(Map<String, dynamic> json) {
    return Materiel(
      nom: json['nom'],
      quantite: json['quantite'],
    );
  }
}
