import 'dart:convert';
import 'package:http/http.dart' as http;
import 'sendPUTStartStop.dart';
Future<ServerResponse?> sendProblem(String problem, int id) async {
  final ipAddress = '192.168.137.247';
  final port = '8080';
  final url = 'http://$ipAddress:$port${"/jour/probleme"}';

  final headers = <String, String>{
    'Content-Type': 'application/json',
    'id': id.toString(),
  };

  final body = <String, dynamic>{
    'probleme': problem,
  };

  print('Sending POST request to: $url');
  print('Headers: $headers');
  print('Request Body: $body');

  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    print('POST request was successful');

    // Преобразование JSON-ответа в объект ServerResponse
    final responseJson = jsonDecode(response.body);

    // Создание объекта ServerResponse из JSON-ответа
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
    print('Server Response Object: $serverResponse');

  } else {
    print('Failed to send POST request with status code: ${response.statusCode}');
    return null; // Возвращаем null в случае ошибки
  }
}
