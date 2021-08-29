import 'package:plataforma_eventos/evento/evento.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetEventData {
  Future<List<Evento>> getEventData(
      String requestURL, Map<String, String> body) async {
    var getURL = Uri.parse(requestURL);
    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };

    http.Response response = await http.post(
      getURL,
      headers: headers,
      body: jsonEncode(body),
    );
    var items = json.decode(response.body);

    var inscricoes = items
        .map<Evento>((json) => Evento(
            json["id_evento"],
            json["nome"],
            json["descricao"],
            json["data_inicio"],
            json["horario_inicio"],
            json["data_fim"],
            json["horario_fim"],
            json["carga_horaria"],
            json["numero_maximo_participantes"],
            json["data_criacao"],
            json["data_autorizacao"],
            json["id_organizador"],
            json["id_unidade"]))
        .toList();

    return inscricoes;
  }
}
