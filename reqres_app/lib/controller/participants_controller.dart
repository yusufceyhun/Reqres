import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/participant_model.dart';

class ParticipantController {
  Future<List<Participant>> fetchParticipants(int page) async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> participantList = jsonData['data'];

      List<Participant> participants =
          participantList.map((json) => Participant.fromJson(json)).toList();

      return participants;
    } else {
      throw Exception('Failed to load participants');
    }
  }
}
