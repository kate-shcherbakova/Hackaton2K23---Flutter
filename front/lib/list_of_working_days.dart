// import 'package:flutter/material.dart';
// import 'Chantier.dart';
// import 'liste_des_chantiers.dart';
// import 'ChantierDetailsScreen.dart';

// class DayWorkListScreen extends StatelessWidget {
//   final Chantier chantier;
//
//   DayWorkListScreen(this.chantier);
//
//   @override
//   Widget build(BuildContext context) {
//     // Получите текущую дату и время
//     DateTime currentDate = DateTime.now();
//     String formattedDate = "${currentDate.day}/${currentDate.month}/${currentDate.year}";
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Day Work List for chantier №' + chantier.id.toString()),
//       ),
//       body: ListView.builder(
//         itemCount: 1,
//         itemBuilder: (context, index) {
//           return Card(
//             child: ListTile(
//               title: Text("Chantier №" + chantier.id.toString()),
//               subtitle: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Description: CHANTIER DESC'),
//                   Text('Date: $formattedDate'), // Добавляем текущую дату
//                 ],
//               ),
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => ChantierDetailsScreen(chantier),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front/signature_screen.dart';
import 'Chantier.dart';
import 'ChantierDetailsScreen.dart';
import 'JourDeChantier.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// class DayWorkListScreen extends StatelessWidget {
//   final Chantier chantier;
//   final int chefId;
//   List<JourDeChantier>? joursDeChantier;
//
//   DayWorkListScreen({required this.chefId, required this.chantier});
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text('Days for project ' + chantier.id.toString()),
//   //     ),
//   //     body: joursDeChantier == null || joursDeChantier!.isEmpty
//   //         ? Center(
//   //             child: Text('There are no work days for this project!'),
//   //           )
//   //         : ListView.builder(
//   //             itemCount: joursDeChantier!.length,
//   //             itemBuilder: (context, index) {
//   //               final jourDeChantier = joursDeChantier![index];
//   //               return Card(
//   //                 child: ListTile(
//   //                   title:
//   //                       Text("Day " + jourDeChantier.id.toString()),
//   //                   subtitle: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: [
//   //                       Text('${DateFormat('d MMMM y', 'en_US').format(jourDeChantier.jour)}'),
//   //                     ],
//   //                   ),
//   //                   onTap: () {
//   //                     Navigator.of(context).push(
//   //                       MaterialPageRoute(
//   //                         builder: (context) => ChantierDetailsScreen(chefId, chantier, jourDeChantier),
//   //                       ),
//   //                     );
//   //                   },
//   //                 ),
//   //               );
//   //             },
//   //           ),
//   //   );
//   // }
//
// // with validate check
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text('Days for project ' + chantier.id.toString()),
//   //     ),
//   //     body: joursDeChantier == null || joursDeChantier!.isEmpty
//   //         ? Center(
//   //             child: Text('There are no work days for this project!'),
//   //           )
//   //         : ListView.builder(
//   //             itemCount: joursDeChantier!.length,
//   //             itemBuilder: (context, index) {
//   //               final jourDeChantier = joursDeChantier![index];
//   //               final isDayValidated = jourDeChantier.validee;
//   //               return Card(
//   //                 child: ListTile(
//   //                   title: Text("Day " + jourDeChantier.id.toString()),
//   //                   subtitle: Column(
//   //                     crossAxisAlignment: CrossAxisAlignment.start,
//   //                     children: [
//   //                       Text(
//   //                         '${DateFormat('d MMMM y', 'en_US').format(jourDeChantier.jour)}',
//   //                         style: TextStyle(
//   //                           fontWeight: isDayValidated
//   //                               ? FontWeight.bold
//   //                               : FontWeight.normal,
//   //                           color: isDayValidated ? Colors.grey : Colors.black,
//   //                         ),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                   onTap: isDayValidated
//   //                       ? null // Disable tapping if the day is validated
//   //                       : () {
//   //                           Navigator.of(context).push(
//   //                             MaterialPageRoute(
//   //                               builder: (context) => ChantierDetailsScreen(
//   //                                   chefId, chantier, jourDeChantier),
//   //                             ),
//   //                           );
//   //                         },
//   //                 ),
//   //               );
//   //             },
//   //           ),
//   //   );
//   // }
//
//   // style but without valid check
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text('Days for project ' + chantier.id.toString()),
//   //       backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
//   //     ),
//   //     body: joursDeChantier == null || joursDeChantier!.isEmpty
//   //         ? Center(
//   //       child: Text('There are no work days for this project!'),
//   //     )
//   //         : Padding(
//   //       padding: const EdgeInsets.all(16.0),
//   //       child: ListView.builder(
//   //         itemCount: joursDeChantier!.length,
//   //         itemBuilder: (context, index) {
//   //           final jourDeChantier = joursDeChantier![index];
//   //           return Card(
//   //             elevation: 2,
//   //             margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0), // Adjust only vertical margins
//   //             child: ListTile(
//   //               contentPadding: EdgeInsets.all(16),
//   //               shape: RoundedRectangleBorder(
//   //                 borderRadius: BorderRadius.circular(10),
//   //               ),
//   //               title: Text(
//   //                 "Day " + jourDeChantier.id.toString(),
//   //                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//   //               ),
//   //               subtitle: Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: [
//   //                   SizedBox(height: 8),
//   //                   Text(
//   //                     'Date: ${DateFormat('d MMMM y', 'en_US').format(jourDeChantier.jour)}',
//   //                     style: TextStyle(fontSize: 16),
//   //                   ),
//   //                 ],
//   //               ),
//   //               onTap: () {
//   //                 Navigator.of(context).push(
//   //                   MaterialPageRoute(
//   //                     builder: (context) => ChantierDetailsScreen(chefId, chantier, jourDeChantier),
//   //                   ),
//   //                 );
//   //               },
//   //             ),
//   //           );
//   //         },
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   Future<void> _fetchJoursDeChantier() async {
//     List<int>? joursDeChantierIds = this.chantier.joursDeChantierId;
//     List<JourDeChantier> joursDeChantier = [];
//
//     if(joursDeChantierIds != null) {
//       for (int id in joursDeChantierIds) {
//         // UNCOMMENT
//         var url = Uri.parse('http://192.168.137.247:8080/jour');
//         var response = await http.get(
//           url,
//           headers: {
//             'id': id.toString(),
//           },
//         );
//
//         // String jsonString = '''
//         //   {
//         //     "id": 1,
//         //     "heureDebut": {
//         //       "hour": 8,
//         //       "minute": 0,
//         //       "second": 0
//         //     },
//         //     "heureFin": {
//         //       "hour": 16,
//         //       "minute": 0,
//         //       "second": 0
//         //     },
//         //     "jour": {
//         //       "year": 2023,
//         //       "month": 2,
//         //       "day": 3
//         //     },
//         //     "validee": false,
//         //     "interventionsId": [6, 1],
//         //     "problemes": ["Un probleme est survenu avec simon"],
//         //     "depenses": null,
//         //     "chantierId": 1
//         //   }
//         //   ''';
//
//         try {
//           // UNCOMMENT
//           // if (true) {
//           if (response.statusCode == 200) {
//             // Handle the successful response from the server
//             print(
//               // 'JOUR DE CHANTIER Successful response from server: ${jsonString}');
//               // UNCOMMENT
//                 'JOUR DE CHANTIER Successful response from server: ${response.body}');
//
//             // Map<String, dynamic> jsonMap = json.decode(jsonString);
//             // UNCOMMENT
//             Map<String, dynamic> jsonMap = json.decode(response.body);
//             JourDeChantier jourDeChantier = JourDeChantier.fromJson(jsonMap);
//             joursDeChantier.add(jourDeChantier);
//             // Now you have the jourDeChantier object, you can use it as needed
//             print('Jour ID: ${jourDeChantier.id}');
//             print('Heure Début: ${jourDeChantier.heureDebut}');
//             print('Heure Fin: ${jourDeChantier.heureFin}');
//             // ... Handle other properties of jourDeChantier
//           } else {
//             // Handle errors
//             // UNCOMMENT
//             print('Error: ${response.statusCode}');
//           }
//         } catch (e) {
//           // Handle exceptions during JSON parsing
//           print('Error parsing JSON: $e');
//         }
//       }
//       this.joursDeChantier = joursDeChantier;
//     } else {
//       throw Exception('There are NO days');
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _fetchJoursDeChantier();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Days for project ' + chantier.id.toString()),
//         backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
//       ),
//       body: joursDeChantier == null || joursDeChantier!.isEmpty
//           ? Center(
//         child: Text('There are no work days for this project!'),
//       )
//           : Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.builder(
//           itemCount: joursDeChantier!.length,
//           itemBuilder: (context, index) {
//             final jourDeChantier = joursDeChantier![index];
//             bool isDayValidated = jourDeChantier.validee;
//
//             return Card(
//               elevation: 2,
//               margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0), // Adjust only vertical margins
//               child: ListTile(
//                 contentPadding: EdgeInsets.all(16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 title: Text(
//                   "Day " + jourDeChantier.id.toString(),
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     color: isDayValidated ? Colors.grey : Colors.black, // Change text color if validated
//                   ),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 8),
//                     Text(
//                       'Date: ${DateFormat('d MMMM y', 'en_US').format(jourDeChantier.jour)}',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ],
//                 ),
//                 onTap: isDayValidated
//                     ? null // Disable onTap if day is validated
//                     : () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => ChantierDetailsScreen(chefId, chantier, jourDeChantier),
//                     ),
//                   );
//                 },
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//
// }

class DayWorkListScreen extends StatefulWidget {
  final Chantier chantier;
  final int chefId;

  DayWorkListScreen({required this.chefId, required this.chantier});

  @override
  _DayWorkListScreenState createState() => _DayWorkListScreenState();
}

class _DayWorkListScreenState extends State<DayWorkListScreen> {
  late Future<List<JourDeChantier>> _joursDeChantierFuture;

  @override
  void initState() {
    super.initState();
    _joursDeChantierFuture = _fetchJoursDeChantier();
  }

  Future<List<JourDeChantier>> _fetchJoursDeChantier() async {
    List<int>? joursDeChantierIds = widget.chantier.joursDeChantierId;
    List<JourDeChantier> joursDeChantier = [];

    if (joursDeChantierIds != null) {
      for (int id in joursDeChantierIds) {
        var url = Uri.parse('http://192.168.137.247:8080/jour');
        var response = await http.get(
          url,
          headers: {
            'id': id.toString(),
          },
        );

        try {
          if (response.statusCode == 200) {
            Map<String, dynamic> jsonMap = json.decode(response.body);
            JourDeChantier jourDeChantier = JourDeChantier.fromJson(jsonMap);
            joursDeChantier.add(jourDeChantier);
          } else {
            print('Error: ${response.statusCode}');
          }
        } catch (e) {
          print('Error parsing JSON: $e');
        }
      }
      return joursDeChantier;
    } else {
      print('There are NO days');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Days for project ' + widget.chantier.id.toString()),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: FutureBuilder<List<JourDeChantier>>(
        future: _joursDeChantierFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('There are no work days for this project!',
                    style: TextStyle(
                      fontSize: 20,
                    )));
          } else {
            List<JourDeChantier> joursDeChantier = snapshot.data!;

            // return Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: ListView.builder(
            //     itemCount: joursDeChantier.length,
            //     itemBuilder: (context, index) {
            //       final jourDeChantier = joursDeChantier[index];
            //       bool isDayValidated = jourDeChantier.validee;
            //
            //       return Card(
            //         elevation: 2,
            //         margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            //         child: ListTile(
            //           contentPadding: EdgeInsets.all(16),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           title: Text(
            //             "Day " + jourDeChantier.id.toString(),
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 18,
            //               color: isDayValidated ? Colors.grey : Colors.black,
            //             ),
            //           ),
            //           subtitle: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               SizedBox(height: 8),
            //               Text(
            //                 'Date: ${DateFormat('d MMMM y', 'en_US').format(jourDeChantier.jour)}',
            //                 style: TextStyle(fontSize: 16),
            //               ),
            //             ],
            //           ),
            //           onTap: isDayValidated
            //               ? null
            //               : () {
            //             Navigator.of(context).push(
            //               MaterialPageRoute(
            //                 builder: (context) => ChantierDetailsScreen(widget.chefId, widget.chantier, jourDeChantier),
            //               ),
            //             );
            //           },
            //         ),
            //       );
            //     },
            //   ),
            //
            //
            // );

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: joursDeChantier.length,
                      itemBuilder: (context, index) {
                        final jourDeChantier = joursDeChantier[index];
                        bool isDayValidated = jourDeChantier.validee;

                        return Card(
                          elevation: 2,
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text(
                              "Day " + jourDeChantier.id.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: isDayValidated ? Colors.grey : Colors.black,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text(
                                  'Date: ${DateFormat('d MMMM y', 'en_US').format(jourDeChantier.jour)}',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            onTap: isDayValidated
                                ? null
                                : () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ChantierDetailsScreen(widget.chefId, widget.chantier, jourDeChantier),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignatureScreen(widget.chantier.id),
                        ),
                      );

                      if (result != null) {
                        // Handle the result if needed
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightBlue,
                      onPrimary: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                    child: Text("Add Signature", style: TextStyle(fontSize: 20)),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );


          }
        },
      ),
    );
  }
}
