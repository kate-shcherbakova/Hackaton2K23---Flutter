import 'dart:convert';
import 'package:http/http.dart' as http;

// Определение класса ServerResponse
class ServerResponse {
  final int id;
  final Map<String, int> heureDebut;
  final Map<String, int> heureFin;
  final Map<String, dynamic> jour;
  final bool validee;
  final List<int> interventionsId;
  final List<String>? problemes;
  final dynamic depenses;
  final int chantierId;

  ServerResponse({
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

  factory ServerResponse.fromJson(Map<String, dynamic> json) {
    return ServerResponse(
      id: json['id'],
      heureDebut: convertMap(json['heureDebut']),
      heureFin: convertMap(json['heureFin']),
      jour: json['jour'],
      validee: json['validee'],
      interventionsId: List<int>.from(json['interventionsId']),
      // problemes: List<String>.from(json['problemes']),
      problemes: json['problemes'] != null
          ? List<String>.from(json['problemes'])
          : null, // Handle null 'problemes' field
      depenses: json['depenses'],
      chantierId: json['chantierId'],
    );
  }

  @override
  String toString() {
    return 'ServerResponse{id: $id, heureDebut: $heureDebut, heureFin: $heureFin, jour: $jour, validee: $validee, interventionsId: $interventionsId, problemes: $problemes, depenses: $depenses, chantierId: $chantierId}';
  }
}

Map<String, int> convertMap(Map<String, dynamic> inputMap) {
  final Map<String, int> result = {};
  inputMap.forEach((key, value) {
    if (value is int) {
      result[key] = value;
    }
  });
  return result;
}

Future<ServerResponse?> sendPUTStartStopRequest(bool isStopped, int hour, int minute, int second, int id) async {
  final ipAddress = '192.168.137.247';
  final port = '8080';
  final url = 'http://$ipAddress:$port${isStopped ? "/jour/start" : "/jour/stop"}';

  final headers = <String, String>{
    'Content-Type': 'application/json',
    'id': id.toString(),
  };

  final body = <String, dynamic>{
    'hour': hour,
    'minute': minute,
    'second': second,
  };

  print('Sending POST request to: $url');
  print('Headers: $headers');
  print('Request Body: $body');

  final response = await http.put(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    print('POST request was successful');

    // Преобразование JSON-ответа в объект ServerResponse
    final responseJson = jsonDecode(response.body);
    final serverResponse = ServerResponse.fromJson(responseJson);

    // Вывод информации из объекта ServerResponse
    print('Received Server Response:');
    print('ID: ${serverResponse.id}');
    print('Start Time: ${serverResponse.heureDebut}');
    print('End Time: ${serverResponse.heureFin}');
    print('Date: ${serverResponse.jour}');
    print('Is Valid: ${serverResponse.validee}');
    print('Interventions IDs: ${serverResponse.interventionsId}');
    print('Problemes: ${serverResponse.problemes}');
    print('Depenses: ${serverResponse.depenses}');
    print('Chantier ID: ${serverResponse.chantierId}');

    // Вывод в консоль всего объекта ServerResponse для детальной проверки
    print('Server response for start/stop: $serverResponse');

    return serverResponse; // Возвращаем ServerResponse после успешного запроса
  } else {
    print('Failed to send POST request with status code: ${response.statusCode}');
    return null; // Возвращаем null в случае ошибки
  }
}
