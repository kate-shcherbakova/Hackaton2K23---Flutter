import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class Receipt {
  String name;
  String description;
  double prix;
  List<String> photos = [];
  String documentType;

  Receipt(this.name, this.description, this.prix, this.documentType);
}

class ReceiptScreen extends StatefulWidget {
  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  final List<Receipt> _receipts = [];
  List<XFile> _selectedImages = [];
  String? _selectedDocumentType =
      'Receipt'; // Инициализация _selectedDocumentType

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(pickedFile);
      });
    }
  }

  void _addReceipt() {
    final name = _nameController.text;
    final prixText = _prixController.text;
    final documentType = _selectedDocumentType;

    if (name.isNotEmpty && prixText.isNotEmpty && documentType != null) {
      final prix = double.tryParse(prixText);

      if (prix != null) {
        final now = DateTime.now();
        final formattedTime = DateFormat('HH:mm:ss, dd/MM/yyyy').format(now);
        final description =
            'Time: $formattedTime\n${_descriptionController.text}';

        final receipt = Receipt(name, description, prix, documentType);
        receipt.photos.addAll(_selectedImages.map((image) => image.path));
        _receipts.add(receipt);
        _nameController.clear();
        _descriptionController.clear();
        _prixController.clear();
        _selectedImages.clear();
        setState(() {});
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Add Receipt'),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           TextFormField(
  //             controller: _nameController,
  //             decoration: InputDecoration(labelText: 'Name'),
  //           ),
  //           TextFormField(
  //             controller: _descriptionController,
  //             decoration: InputDecoration(labelText: 'Description'),
  //           ),
  //           TextFormField(
  //             controller: _prixController,
  //             decoration: InputDecoration(labelText: 'Prix'),
  //             keyboardType: TextInputType.number,
  //           ),
  //           DropdownButtonFormField<String>(
  //             value: _selectedDocumentType,
  //             items: ['Receipt', 'Invoice'].map((type) {
  //               return DropdownMenuItem<String>(
  //                 value: type,
  //                 child: Text(type),
  //               );
  //             }).toList(),
  //             onChanged: (value) {
  //               setState(() {
  //                 _selectedDocumentType = value;
  //               });
  //             },
  //             decoration: InputDecoration(labelText: 'Document Type'),
  //           ),
  //           ElevatedButton(
  //             onPressed: _pickImage,
  //             child: Text('Add Image'),
  //           ),
  //           SizedBox(height: 16),
  //           Container(
  //             height: 100,
  //             child: ListView.builder(
  //               scrollDirection: Axis.horizontal,
  //               itemCount: _selectedImages.length,
  //               itemBuilder: (context, index) {
  //                 return Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Stack(
  //                       children: [
  //                         Image.file(
  //                           File(_selectedImages[index].path),
  //                           width: 100,
  //                         ),
  //                         Positioned(
  //                           top: 0,
  //                           right: 0,
  //                           child: IconButton(
  //                             icon: Icon(Icons.delete),
  //                             onPressed: () => _removeImage(index),
  //                           ),
  //                         ),
  //                       ],
  //                     )
  //                 );
  //               },
  //             ),
  //           ),
  //           ElevatedButton(
  //             onPressed: _addReceipt,
  //             child: Text('Add Receipt'),
  //           ),
  //           SizedBox(height: 16),
  //           Text('Receipts List:'),
  //           Expanded(
  //             child: ListView.builder(
  //               itemCount: _receipts.length,
  //               itemBuilder: (context, index) {
  //                 final receipt = _receipts[index];
  //                 return ListTile(
  //                   title: Text(receipt.name),
  //                   subtitle: Text(receipt.description),
  //                   trailing: Text('Prix: ${receipt.prix.toStringAsFixed(2)}'),
  //                   leading: Column(
  //                     children: [
  //                       Text('Document Type: ${receipt.documentType}'),
  //                       Container(
  //                         width: 100,
  //                         height: 100,
  //                         child: ListView.builder(
  //                           scrollDirection: Axis.horizontal,
  //                           itemCount: receipt.photos.length,
  //                           itemBuilder: (context, index) {
  //                             return Image.file(
  //                               File(receipt.photos[index]),
  //                               width: 100,
  //                             );
  //                           },
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Receipt'),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(fontStyle: FontStyle.italic),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              maxLines: null,
              minLines: 2,
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(fontStyle: FontStyle.italic),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _prixController,
              decoration: InputDecoration(
                labelText: 'Price',
                labelStyle: TextStyle(fontStyle: FontStyle.italic),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedDocumentType,
              items: ['Receipt', 'Invoice'].map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedDocumentType = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Document type',
                labelStyle: TextStyle(fontStyle: FontStyle.italic),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightGreen),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen,
                onPrimary: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
              child: Text('Add photo', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 16),
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedImages.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Image.file(
                          File(_selectedImages[index].path),
                          width: 100,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _removeImage(index),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addReceipt,
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                onPrimary: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
              child: Text('Add receipt', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 16),
            Text(
              'Receipts list:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _receipts.length,
                itemBuilder: (context, index) {
                  final receipt = _receipts[index];
                  return ListTile(
                    title: Text(
                      receipt.name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      receipt.description,
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Text('Price: ${receipt.prix.toStringAsFixed(2)}'),
                    leading: Column(
                      children: [
                        Text('Document Type: ${receipt.documentType}'),
                        Container(
                          width: 100,
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: receipt.photos.length,
                            itemBuilder: (context, index) {
                              return Image.file(
                                File(receipt.photos[index]),
                                width: 100,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
