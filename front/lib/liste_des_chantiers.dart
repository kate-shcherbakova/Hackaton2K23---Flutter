import 'dart:convert';

import 'package:flutter/material.dart';
import 'Chantier.dart';
import 'ChantierDetailsScreen.dart';
import 'JourDeChantier.dart';
import 'list_of_working_days.dart';
import 'package:http/http.dart' as http;

// class ListeDesChantiersScreen extends StatefulWidget {
//   final int chefId;
//   List<Chantier> _chantiers = [];
//   List<int> _joursDeChantierIds = [];
//   // final List<Chantier> chantiers;
//   // final List<JourDeChantier>? joursDeChantier;
//
//   ListeDesChantiersScreen({required this.chefId});
//   // ListeDesChantiersScreen({required this.chefId, required this.chantiers, required this.joursDeChantier});
//
//
//   @override
//   _ListeDesChantiersScreenState createState() => _ListeDesChantiersScreenState();
// }
//
// class _ListeDesChantiersScreenState extends State<ListeDesChantiersScreen> {
//
//   @override
//   void initState() {
//     _fetchChantiers();
//     super.initState();
//   }
//
//   Future<void> _fetchChantiers() async {
//     // БЕРЕТ ДАННЫЕ ПРЕДЫДУЩЕГО ШЕФА, НАДО ПРОВЕРЯТЬ
//     // UNCOMMENT
//     var url = Uri.parse('http://192.168.137.247:8080/chantiers');
//     var response = await http.get(
//       url,
//       headers: {
//         'id': widget.chefId.toString(),
//       },
//     );
//
//     try {
//       if (response.statusCode == 200) {
//         // if (true) {
//         // Обработка успешного ответа от сервера
//         // UNCOMMENT
//         print('Успешный ответ /chantiers: ${response.body}');
//
//         //COMMENT
//         // String jsonString =
//         //     '{"chantiers":[{"id":2,"materiel":[{"nom":"Perceuse","quantite":1},{"nom":"Sac de ciment","quantite":3}],"chefDeChantierIdl":4,"demandeDeChantierId":null,"joursDeChantierId":null},{"id":1,"materiel":[{"nom":"Perceuse","quantite":1},{"nom":"Sac de ciment","quantite":3}],"chefDeChantierIdl":4,"demandeDeChantierId":2,"joursDeChantierId":[2,1,3]}]}';
//
//         // Map<String, dynamic> jsonMap = json.decode(jsonString);
//         // UNCOMMENT
//         Map<String, dynamic> jsonMap = json.decode(response.body);
//
//         List<Chantier> chantiers = [];
//
//         if (jsonMap.containsKey('chantiers')) {
//           var chantierList = jsonMap['chantiers'];
//           for (var chantierJson in chantierList) {
//             Chantier chantier = Chantier.fromJson(chantierJson);
//             chantiers.add(chantier);
//           }
//           widget._chantiers = chantiers;
//         }
//       } else {
//         // UNCOMMENT
//         print('Ошибка list de chantiers: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Обработка исключения при парсинге JSON
//       print('Ошибка при парсинге JSON chantiers: $e');
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     _fetchChantiers();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('List of projects'),
//         backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
//       ),
//       body: ListView.builder(
//         itemCount: widget._chantiers.length,
//         itemBuilder: (context, index) {
//           final chantier = widget._chantiers[index];
//
//           return GestureDetector(
//             onTap: () {
//               // ??????
//               List<int>? test = chantier.joursDeChantierId;
//               print("TEST JOURS ID" + test.toString());
//               // List<int>? joursDeChantierIds;
//               // if (chantierJson['joursDeChantierId'] != null) {
//               //   joursDeChantierIds = List<int>.from(chantierJson['joursDeChantierId']);
//               //   // await _fetchJoursDeChantier(joursDeChantierIds); ????
//               // } else {
//               //   print("DO SMTH NULL JOURS");
//               // }
//               // CHANGE
//               // Navigator.of(context).push(MaterialPageRoute(
//               //   builder: (context) => DayWorkListScreen(widget.chefId, chantier, widget.joursDeChantier),
//               // ));
//             },
//             child: Card(
//               child: ListTile(
//                 title: Text("Chantier " + chantier.id.toString()),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class ListeDesChantiersScreen extends StatefulWidget {
  final int chefId;

  ListeDesChantiersScreen({required this.chefId});

  @override
  _ListeDesChantiersScreenState createState() =>
      _ListeDesChantiersScreenState();
}

class _ListeDesChantiersScreenState extends State<ListeDesChantiersScreen> {
  // Future<List<Chantier>> _fetchChantiers() async {
  //   var url = Uri.parse('http://192.168.137.247:8080/chantiers');
  //   var response = await http.get(
  //     url,
  //     headers: {
  //       'id': widget.chefId.toString(),
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final jsonMap = json.decode(response.body);
  //     if (jsonMap.containsKey('chantiers')) {
  //       var chantierList = jsonMap['chantiers'];
  //       return chantierList
  //           .map((chantierJson) => Chantier.fromJson(chantierJson))
  //           .toList();
  //     }
  //   }
  //
  //   Future<List<Chantier>> _fetchChantiers() async {
  //     var url = Uri.parse('http://192.168.137.247:8080/chantiers');
  //     var response = await http.get(
  //       url,
  //       headers: {
  //         'id': widget.chefId.toString(),
  //       },
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final jsonMap = json.decode(response.body);
  //       if (jsonMap.containsKey('chantiers')) {
  //         var chantierList = jsonMap['chantiers'];
  //         return chantierList
  //             .map<Chantier>((chantierJson) => Chantier.fromJson(chantierJson))
  //             .toList();
  //       }
  //     }
  //
  //     // Handle errors by returning an empty list or throwing an exception.
  //     throw Exception('Failed to load chantiers');
  //   }
  //
  //   return <Chantier>[];
  // }

  Future<List<Chantier>> _fetchChantiers() async {
    var url = Uri.parse('http://192.168.137.247:8080/chantiers');
    var response = await http.get(
      url,
      headers: {
        'id': widget.chefId.toString(),
      },
    );

    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      if (jsonMap.containsKey('chantiers')) {
        var chantierList = jsonMap['chantiers'];
        return chantierList
            .map<Chantier>((chantierJson) => Chantier.fromJson(chantierJson))
            .toList();
      }
    }

    // Handle errors by returning an empty list or throwing an exception.
    throw Exception('Failed to load chantiers');
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('List of projects'),
  //       backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
  //     ),
  //     body: FutureBuilder<List<Chantier>>(
  //       future: _fetchChantiers(),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Center(child: CircularProgressIndicator());
  //         } else if (snapshot.hasError) {
  //           print(snapshot.error);
  //           return Center(child: Text('Error: ${snapshot.error}'));
  //         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
  //           return Center(child: Text('No projects available'));
  //         } else {
  //           final chantiers = snapshot.data!;
  //
  //           return ListView.builder(
  //             itemCount: chantiers.length,
  //             itemBuilder: (context, index) {
  //               final chantier = chantiers[index];
  //
  //               return GestureDetector(
  //                 onTap: () {
  //                   // Navigate to the List of Days
  //                   Navigator.of(context).push(
  //                     MaterialPageRoute(
  //                       builder: (context) => DayWorkListScreen(chefId: widget.chefId, chantier: chantier),
  //                     ),
  //                   );
  //                 },
  //                 child: Card(
  //                   child: ListTile(
  //                     title: Text("Chantier " + chantier.id.toString()),
  //                   ),
  //                 ),
  //               );
  //             },
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of projects'),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: FutureBuilder<List<Chantier>>(
        future: _fetchChantiers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No projects available'));
          } else {
            final chantiers = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: chantiers.length,
                itemBuilder: (context, index) {
                  final chantier = chantiers[index];

                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    child: ListTile(
                      title: Text(
                        "Chantier " + chantier.id.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DayWorkListScreen(
                                chefId: widget.chefId, chantier: chantier),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
