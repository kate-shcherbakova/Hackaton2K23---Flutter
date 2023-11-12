import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:intl/intl.dart';

class SignatureScreen extends StatefulWidget {
  final int chantierId;

  SignatureScreen(this.chantierId);

  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black, // Change color to black
    exportBackgroundColor: Colors.white, // Change background color to white
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signature'),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: ${DateFormat('d MMMM y', 'en_US').format(DateTime.now())}',
              style: TextStyle(fontSize: 16),
            ),
            // SizedBox(height: 8),
            Text(
              "Project: ${widget.chantierId}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.lightGreen, width: 2),
              ),
              child: Signature(
                controller: _controller,
                height: 200,
                backgroundColor:
                    Colors.white, // Change background color to white
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _controller.clear(); // Add action for "Clear" button
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                    onPrimary: Colors.white,
                    minimumSize: Size(100, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Clear", style: TextStyle(fontSize: 20)),
                ),
                ElevatedButton(
                  onPressed: () {
                    showSaveConfirmationDialog(); // Add action for "Save" button
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightBlue,
                    onPrimary: Colors.white,
                    minimumSize: Size(100, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Save", style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showSaveConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Save"),
          content: Text("Are you sure you want to save the signature?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Add action on save confirmation
                final signatureBytes =
                    _controller.toPngBytes(); // Get the signature image
                // You can save the image or perform other actions here
                Navigator.of(context).pop();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
