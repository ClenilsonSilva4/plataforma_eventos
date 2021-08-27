import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'evento.dart';

class ListarEventos {
  final Color? backgroundColorBotao = Colors.teal[600];
  final Color textsDarkBackground = Colors.white;
  final Color? appBarBackground = Colors.teal[800];
  final Color? backgroundColor = Colors.grey[800];
  final Color textsLightBackground = Colors.black;

  Future<List<Evento>> _getData(
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

  Widget getEventosGrid(String requestURL, Map<String, String> body) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: FutureBuilder<List<Evento>>(
        future: _getData(requestURL, body),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasError &&
              snapshot.connectionState == ConnectionState.done) {
            return GridView.builder(
              padding: EdgeInsets.fromLTRB(5, 50, 5, 5),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Text(
                          data.nome,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                        child: Text(
                          data.dataInicio + " - " + data.dataFim,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          data.descricao,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 6,
                          style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.fromLTRB(5, 0, 5, 0)),
                              backgroundColor: MaterialStateProperty.all(
                                  backgroundColorBotao),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => detalhesEvento(data),
                                ),
                              );
                            },
                            child: const Text("DETALHES"),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget getEventosList(String requestURL, Map<String, String> body) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: FutureBuilder<List<Evento>>(
        future: _getData(requestURL, body),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasError &&
              snapshot.connectionState == ConnectionState.done) {
            return ListView.separated(
              padding: EdgeInsets.fromLTRB(8, 50, 8, 5),
              itemCount: snapshot.data.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 3,
                thickness: 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Text(
                          data.nome,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                        child: Text(
                          data.dataInicio + " - " + data.dataFim,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          data.descricao,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(10)),
                                  backgroundColor: MaterialStateProperty.all(
                                      backgroundColorBotao),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          detalhesEvento(data),
                                    ),
                                  );
                                },
                                child: const Text("VISUALIZAR"),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(10)),
                                  backgroundColor: MaterialStateProperty.all(
                                      backgroundColorBotao),
                                ),
                                onPressed: () {},
                                child: const Text("BAIXAR"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget detalhesEvento(Evento detalhes) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                detalhes.nome,
                style: TextStyle(color: textsDarkBackground, fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Carga Horária: " + detalhes.cargaHoraria + "h",
                style: TextStyle(
                    color: textsDarkBackground,
                    fontSize: 10,
                    fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        backgroundColor: appBarBackground,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Descrição",
              style: TextStyle(
                color: textsDarkBackground,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: Text(
                detalhes.descricao,
                style: TextStyle(
                  fontSize: 18,
                  color: textsLightBackground,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Inicio do Evento",
                style: TextStyle(
                  color: textsDarkBackground,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: Text(
                "Data de Início: " +
                    detalhes.dataInicio +
                    "\nHorário de Início: " +
                    detalhes.horarioInicio,
                style: TextStyle(
                  fontSize: 18,
                  color: textsLightBackground,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Encerramento do Evento",
                style: TextStyle(
                  color: textsDarkBackground,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: Text(
                "Data de Encerramento: " +
                    detalhes.dataFim +
                    "\nHorário de Encerramento: " +
                    detalhes.horarioFim,
                style: TextStyle(
                  fontSize: 18,
                  color: textsLightBackground,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Quantidade Participantes",
                style: TextStyle(
                  color: textsDarkBackground,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.white,
              ),
              child: Text(
                detalhes.numeroMaximoParticipantes + " participantes",
                style: TextStyle(
                  fontSize: 18,
                  color: textsLightBackground,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPressed() {}
}
