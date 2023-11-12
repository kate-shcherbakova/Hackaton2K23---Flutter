import 'package:flutter/material.dart';
import 'package:front/sendPUTStartStop.dart';
import 'package:intl/intl.dart';

import 'Chantier.dart';
import 'JourDeChantier.dart';
import 'liste_des_chantiers.dart';
import 'signature_screen.dart';
import 'problem_screen.dart';
import 'ReceiptScreen.dart';

class ChantierDetailsScreen extends StatefulWidget {
  final Chantier chantier;
  final JourDeChantier jourDeChantier;
  final int chefId;

  ChantierDetailsScreen(this.chefId, this.chantier, this.jourDeChantier);

  @override
  _ChantierDetailsScreenState createState() => _ChantierDetailsScreenState();
}

class _ChantierDetailsScreenState extends State<ChantierDetailsScreen> {
  bool isStarted = false;
  final TextEditingController _startTimeController = TextEditingController();

  DateTime? startTime; // Добавляем переменную для времени старта

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // widget.chantier.id
        title: Text("Day " + widget.jourDeChantier.id.toString()),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Details:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Text('Start Time: ${widget.jourDeChantier.heureDebut.toString()}'),
            // Text('End Time: ${widget.jourDeChantier.heureFin.toString()}'),
            Text(
                'Date: ${DateFormat('d MMMM y', 'en_US').format(widget.jourDeChantier.jour)}'),
            Text('Validated: ${widget.jourDeChantier.validee ? 'Yes' : 'No'}'),

            SizedBox(height: 16),
            ElevatedButton(

              // onPressed: () {
              //   if (isStarted) {
              //     // Если уже начато, то останавливаем
              //     showStopConfirmationDialog();
              //   } else {
              //     // Если не начато, то запускаем
              //     final now = DateTime.now();
              //     final formattedTime = DateFormat('HH:mm:ss').format(now);
              //     _startTimeController.text = formattedTime;
              //     startTime = now; // Сохраняем время старта
              //     setState(() {
              //       isStarted = true;
              //     });
              //   }
              // },
              onPressed: () async {
                final now = DateTime.now();
                ServerResponse? newRespons;
                if (isStarted == true) {
                  showStopConfirmationDialog(newRespons);
                } else {
                  final formattedTime = DateFormat('HH:mm:ss').format(now);
                  newRespons = await sendPUTStartStopRequest(true, now.hour, now.minute, now.second, widget.jourDeChantier.id);
                  if (newRespons != null) {
                    print(newRespons.heureDebut.toString());
                  } else {
                  }
                  _startTimeController.text = formattedTime;
                  startTime = now; // Сохраняем время старта
                  setState(() {
                    isStarted = true;
                  });
                }
              },


              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen,
                onPrimary: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
              child: Text(isStarted ? "STOP" : "START",
                  style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 4),
            TextFormField(
              controller: _startTimeController,
              decoration: InputDecoration(
                labelText: 'Start Time',
                labelStyle: TextStyle(
                  color: Colors.grey, // caption
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen),
                ),
              ),
              enabled: false,
            ),
            SizedBox(height: 50),
            // ElevatedButton(
            //   onPressed: () async {
            //     final result =
            //         await Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => SignatureScreen("CLIENT NAME!"),
            //     ));
            //
            //     if (result != null) {
            //       // Обработайте результат, если есть необходимость
            //     }
            //   },
            //   style: ElevatedButton.styleFrom(
            //     primary: Colors.lightBlue,
            //     onPrimary: Colors.white,
            //     minimumSize: Size(double.infinity, 50),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     elevation: 3,
            //   ),
            //   child: Text("Add Signature", style: TextStyle(fontSize: 20)),
            // ),
            // SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProblemScreen(),
                ));
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
              child: Text("Add Problems", style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ReceiptScreen(),
                ));
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
              child: Text("Add Facture", style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

  // void showStopConfirmationDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Confirm Action"),
  //         content: Text("Are you sure you want to stop this action?"),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("Cancel"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               // Здесь добавляем время стопа и сохраняем его
  //               final now = DateTime.now();
  //               final formattedTime = DateFormat('HH:mm:ss').format(now);
  //               final elapsedTime = now.difference(startTime!).inMinutes;
  //               _startTimeController.text = _startTimeController.text +
  //                   " - $formattedTime ($elapsedTime min)";
  //               setState(() {
  //                 isStarted = false;
  //               });
  //               Navigator.of(context).pop();
  //             },
  //             child: Text("Stop"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void showStopConfirmationDialog(ServerResponse? newRespons) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Action"),
          content: Text("Are you sure you want to stop this action?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // Здесь добавляем время стопа и сохраняем его
                final now = DateTime.now();
                final formattedTime = DateFormat('HH:mm:ss').format(now);
                newRespons = await sendPUTStartStopRequest(
                    false, now.hour, now.minute, now.second, widget.jourDeChantier.id);
                if (newRespons != null) {
                } else {}
                final elapsedTime = now.difference(startTime!).inMinutes;
                _startTimeController.text = _startTimeController.text +
                    " - $formattedTime ($elapsedTime min)";
                setState(() {
                  isStarted = false;
                });
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ListeDesChantiersScreen(
                    chefId: widget.chefId,
                  ),
                ));
              },
              child: Text("Stop"),
            ),
          ],
        );
      },
    );
  }
}
