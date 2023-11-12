import 'package:flutter/material.dart';
import 'package:front/sendPostProb.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class Problem {
  String name;
  String description;
  List<String> photos = [];

  Problem(this.name, this.description);
}

class ProblemScreen extends StatefulWidget {
  @override
  _ProblemScreenState createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<Problem> _problems = [];
  List<XFile> _selectedImages = [];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(pickedFile);
      });
    }
  }

  void _addProblem() {
    final now = DateTime.now();
    final name = _nameController.text;
    final formattedTime = DateFormat('HH:mm:ss, dd/MM/yyyy').format(now);
    final description = 'Time: $formattedTime\n${_descriptionController.text}';

    sendProblem(_descriptionController.text, 1);

    if (name.isNotEmpty && description.isNotEmpty) {
      final problem = Problem(name, description);
      problem.photos.addAll(_selectedImages.map((image) => image.path));
      _problems.add(problem);
      _nameController.clear();
      _descriptionController.clear();
      _selectedImages.clear();
      setState(() {});
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
  //       title: Text('Add Problem'),
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
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Stack(
  //                     children: [
  //                       Image.file(
  //                         File(_selectedImages[index].path),
  //                         width: 100,
  //                       ),
  //                       Positioned(
  //                         top: 0,
  //                         right: 0,
  //                         child: IconButton(
  //                           icon: Icon(Icons.delete),
  //                           onPressed: () => _removeImage(index),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               },
  //             ),
  //           ),
  //           ElevatedButton(
  //             onPressed: _addProblem,
  //             child: Text('Add Problem'),
  //           ),
  //           SizedBox(height: 16),
  //           Text('Problems List:'),
  //           Expanded(
  //             child: ListView.builder(
  //               itemCount: _problems.length,
  //               itemBuilder: (context, index) {
  //                 final problem = _problems[index];
  //                 return ListTile(
  //                   title: Text(problem.name),
  //                   subtitle: Text(problem.description),
  //                   trailing: Container(
  //                     width: 100,
  //                     height: 100,
  //                     child: ListView.builder(
  //                       scrollDirection: Axis.horizontal,
  //                       itemCount: problem.photos.length,
  //                       itemBuilder: (context, index) {
  //                         return Image.file(
  //                           File(problem.photos[index]),
  //                           width: 100,
  //                         );
  //                       },
  //                     ),
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
        title: Text('Add Problem'),
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
              maxLines: null, // Allows the field to expand as needed
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
              onPressed: _addProblem,
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                onPrimary: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3,
              ),
              child: Text('Add problem', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 16),
            Text(
              'Problems list:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _problems.length,
                itemBuilder: (context, index) {
                  final problem = _problems[index];
                  return ListTile(
                    title: Text(
                      problem.name,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      problem.description,
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Container(
                      width: 100,
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: problem.photos.length,
                        itemBuilder: (context, index) {
                          return Image.file(
                            File(problem.photos[index]),
                            width: 100,
                          );
                        },
                      ),
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
