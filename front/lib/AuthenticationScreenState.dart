import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Chantier.dart';
import 'ChefDeChantier.dart';
import 'JourDeChantier.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'liste_des_chantiers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  ChefDeChantier? _chefDeChantier;
  List<Chantier> _chantiers = [];
  List<JourDeChantier> _joursDeChantier = [];
  String? _errorMessage;

  // Future<void> initializeFirebase() async {
  //   try {
  //     await Firebase.initializeApp(
  //       options: DefaultFirebaseOptions.currentPlatform,
  //     );
  //   } catch (e) {
  //     print("Firebase initialisation error: $e");
  //   }
  // }

  @override
  void initState() {
    // initializeFirebase();
    super.initState();
  }

  Future<void> _authenticateUser() async {
    // UNCOMMENT
    String username = _usernameController.text;
    String password = _passwordController.text;
    // String username = 'emailchefDeChantier';
    // String password = '1234';

    var url = Uri.parse('http://192.168.137.247:8080/connection');
    var response = await http.get(
      url,
      headers: {
        'email': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Обработка успешного ответа от сервера
      print('Успешный ответ /connection: ${response.body}');
      String jsonResponse = response.body; // Ваш JSON-ответ от сервера
      Map<String, dynamic> jsonMap =
          json.decode(jsonResponse); // Преобразование JSON-строки в Map
      ChefDeChantier chef = ChefDeChantier.fromJson(
          jsonMap); // Преобразование Map в объект ChefDeChantier
      _chefDeChantier = chef;
      print('Роль: ${chef.role}');
      print('ID: ${chef.id}');

      if (_chefDeChantier?.id == null) {
        throw Exception("Chef ID is null");
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ListeDesChantiersScreen(
            // UNCOMMENT
            chefId: _chefDeChantier!.id,
            // chefId: 4,
            // chantiers: _chantiers, ??
            // joursDeChantier: _joursDeChantier, ??
          ),
        ));
      }

    } else {
      // Обработка ошибки
      setState(() {
        _errorMessage = 'Authentication failed. Please check your credentials.';
      });
      print('Ошибка аутентификации: ${response.statusCode}');
    }
  }

  // IN list de chantiers
  // Future<void> _fetchChantiers() async {
  //   // БЕРЕТ ДАННЫЕ ПРЕДЫДУЩЕГО ШЕФА, НАДО ПРОВЕРЯТЬ
  //   // UNCOMMENT
  //   var url = Uri.parse('http://192.168.137.247:8080/chantiers');
  //   var response = await http.get(
  //     url,
  //     headers: {
  //       'id': _chefDeChantier!.id.toString(),
  //     },
  //   );
  //
  //   try {
  //     if (response.statusCode == 200) {
  //     // if (true) {
  //       // Обработка успешного ответа от сервера
  //       // UNCOMMENT
  //       print('Успешный ответ от сервера: ${response.body}');
  //
  //       //COMMENT
  //       // String jsonString =
  //       //     '{"chantiers":[{"id":2,"materiel":[{"nom":"Perceuse","quantite":1},{"nom":"Sac de ciment","quantite":3}],"chefDeChantierIdl":4,"demandeDeChantierId":null,"joursDeChantierId":null},{"id":1,"materiel":[{"nom":"Perceuse","quantite":1},{"nom":"Sac de ciment","quantite":3}],"chefDeChantierIdl":4,"demandeDeChantierId":2,"joursDeChantierId":[2,1,3]}]}';
  //
  //       // Map<String, dynamic> jsonMap = json.decode(jsonString);
  //       // UNCOMMENT
  //       Map<String, dynamic> jsonMap = json.decode(response.body);
  //
  //       List<Chantier> chantiers = [];
  //
  //       if (jsonMap.containsKey('chantiers')) {
  //         var chantierList = jsonMap['chantiers'];
  //         for (var chantierJson in chantierList) {
  //           Chantier chantier = Chantier.fromJson(chantierJson);
  //           chantiers.add(chantier);
  //           print(chantier.joursDeChantierId.toString());
  //
  //           List<int>? joursDeChantierIds;
  //           if (chantierJson['joursDeChantierId'] != null) {
  //             joursDeChantierIds =
  //                 List<int>.from(chantierJson['joursDeChantierId']);
  //             await _fetchJoursDeChantier(joursDeChantierIds);
  //           } else {
  //             joursDeChantierIds = null;
  //             print("DO SMTH NULL JOURS");
  //           }
  //         }
  //         _chantiers = chantiers;
  //       }
  //     } else {
  //       // UNCOMMENT
  //       print('Ошибка: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Обработка исключения при парсинге JSON
  //     print('Ошибка при парсинге JSON: $e');
  //   }
  // }


  // IN list de jours
  // Future<void> _fetchJoursDeChantier(List<int> joursDeChantierIds) async {
  //   List<JourDeChantier> joursDeChantier = [];
  //   for (int id in joursDeChantierIds) {
  //     // UNCOMMENT
  //     var url = Uri.parse('http://192.168.137.247:8080/jour');
  //     var response = await http.get(
  //       url,
  //       headers: {
  //         'id': id.toString(),
  //       },
  //     );
  //
  //     // String jsonString = '''
  //     //   {
  //     //     "id": 1,
  //     //     "heureDebut": {
  //     //       "hour": 8,
  //     //       "minute": 0,
  //     //       "second": 0
  //     //     },
  //     //     "heureFin": {
  //     //       "hour": 16,
  //     //       "minute": 0,
  //     //       "second": 0
  //     //     },
  //     //     "jour": {
  //     //       "year": 2023,
  //     //       "month": 2,
  //     //       "day": 3
  //     //     },
  //     //     "validee": false,
  //     //     "interventionsId": [6, 1],
  //     //     "problemes": ["Un probleme est survenu avec simon"],
  //     //     "depenses": null,
  //     //     "chantierId": 1
  //     //   }
  //     //   ''';
  //
  //     try {
  //       // UNCOMMENT
  //       // if (true) {
  //         if (response.statusCode == 200) {
  //         // Handle the successful response from the server
  //         print(
  //             // 'JOUR DE CHANTIER Successful response from server: ${jsonString}');
  //         // UNCOMMENT
  //         'JOUR DE CHANTIER Successful response from server: ${response.body}');
  //
  //         // Map<String, dynamic> jsonMap = json.decode(jsonString);
  //         // UNCOMMENT
  //         Map<String, dynamic> jsonMap = json.decode(response.body);
  //         JourDeChantier jourDeChantier = JourDeChantier.fromJson(jsonMap);
  //         joursDeChantier.add(jourDeChantier);
  //         // Now you have the jourDeChantier object, you can use it as needed
  //         print('Jour ID: ${jourDeChantier.id}');
  //         print('Heure Début: ${jourDeChantier.heureDebut}');
  //         print('Heure Fin: ${jourDeChantier.heureFin}');
  //         // ... Handle other properties of jourDeChantier
  //       } else {
  //         // Handle errors
  //         // UNCOMMENT
  //         print('Error: ${response.statusCode}');
  //       }
  //     } catch (e) {
  //       // Handle exceptions during JSON parsing
  //       print('Error parsing JSON: $e');
  //     }
  //   }
  //   _joursDeChantier = joursDeChantier;
  // }

  // ---------------
  // void _navigateToListeDesChantiers() {
  //   // if (false) {
  //     // UNCOMMENT
  //   if (_chefDeChantier?.id == null) {
  //     throw Exception("Chef ID is null");
  //   } else {
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (context) => ListeDesChantiersScreen(
  //         // UNCOMMENT
  //         chefId: _chefDeChantier!.id,
  //         // chefId: 4,
  //         chantiers: _chantiers,
  //         joursDeChantier: _joursDeChantier,
  //       ),
  //     ));
  //   }
  // }
  // ---------------

  // Future<void> signInWithFirebase(String email, String password) async {
  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: "user1@example.com", password: "user1@example.com",
  //       //email: email,
  //       //password: password,
  //     );
  //
  //     final user = userCredential.user;
  //
  //     if (user != null) {
  //       //send in DB this user.uid; fjr db check it in firebase fron firebase admin
  //
  //       //if (user.email == 'user1@example.com') {
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(
  //         builder: (context) => ListeDesChantiersScreen([
  //           Chantier('Name 1', 'desc 1'),
  //           Chantier('Name 2', 'desc 2'),
  //           // Добавьте другие объекты в список по мере необходимости
  //         ]),
  //       ));
  //       //}
  //     }
  //   } catch (e) {
  //     setState(() {
  //       _errorMessage = 'Non-existent user name or password ';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentication"),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Image.asset(
                'assets/images/logo.png',
                width: 100,
              ),
            ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),

            SizedBox(height: 20), // space between elements

            TextField(
              controller: _usernameController,
              cursorColor: Colors.lightGreen,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: Colors.grey, // caption
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.lightGreen,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: _passwordController,
              cursorColor: Colors.lightGreen,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.grey, // caption
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.lightGreen,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // UNCOMMENT
                // final username = _usernameController.text;
                // final password = _passwordController.text;
                // signInWithFirebase(username, password);
                final username = 'emailchefDeChantier';
                final password = '1234';
                _authenticateUser();
                // _fetchChantiers();
                // _navigateToListeDesChantiers();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                // Цвет кнопки
                onPrimary: Colors.white,
                // Цвет текста кнопки
                minimumSize: Size(double.infinity, 50),
                // Ширина кнопки на весь экран
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3, // shadow
              ),
              child: Text('Sign in', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
