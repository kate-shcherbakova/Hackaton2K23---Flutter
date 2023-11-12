// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Suivi de Chantier App',
//       home: ChantierPage(),
//     );
//   }
// }
//
// class ChantierPage extends StatefulWidget {
//   @override
//   _ChantierPageState createState() => _ChantierPageState();
// }
//
// class _ChantierPageState extends State<ChantierPage> {
//   // Define variables to store information.
//   String chantierDate = "";
//   String chantierLocation = "";
//   String clientName = "";
//   String startTime = "";
//   String endTime = "";
//   List<String> problems = [];
//   List<String> receipts = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Suivi de Chantier'),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text('Informations du chantier:'),
//             Text('Date: $chantierDate'),
//             Text('Lieu: $chantierLocation'),
//             Text('Client: $clientName'),
//             Text('Heure de début: $startTime'),
//             Text('Heure de fin: $endTime'),
//             Text('Problèmes rencontrés:'),
//             for (String problem in problems) Text(problem),
//             Text('Reçus/Factures:'),
//             for (String receipt in receipts) Text(receipt),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement logic to start the chantier and record the start time.
//               },
//               child: Text('Démarrer le chantier'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement logic to end the chantier and record the end time.
//               },
//               child: Text('Terminer le chantier'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement logic to take a client's signature.
//               },
//               child: Text('Obtenir la signature du client'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement logic to report problems encountered during the chantier.
//               },
//               child: Text('Remonter les problèmes'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement logic to upload photos of receipts or invoices.
//               },
//               child: Text('Télécharger des photos de reçus/factures'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
