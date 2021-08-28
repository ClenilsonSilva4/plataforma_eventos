import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'evento.dart';

class ListarEventos {
  final Color _backgroundColorBotao = Colors.deepOrange[800]!;
  final Color _textsDarkBackground = Colors.white;
  final Color _appBarBackground = Colors.teal[800]!;
  final Color _backgroundColor = Colors.grey[800]!;
  final Color _containerColor = Colors.grey[700]!;

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
      backgroundColor: _backgroundColor,
      body: FutureBuilder<List<Evento>>(
        future: _getData(requestURL, body),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasError &&
              snapshot.data != null &&
              snapshot.data.isNotEmpty) {
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
                                  _backgroundColorBotao),
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
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (body.containsKey("dataFim")) {
              return Center(
                child: Text(
                  "Não foram encontrados eventos que o usuário possa se inscrever",
                  style: TextStyle(
                    color: _textsDarkBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            }

            return Center(
              child: Text(
                "Não foram encontrados eventos que o usuário esteja inscrito",
                style: TextStyle(
                  color: _textsDarkBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget getEventosList(String requestURL, Map<String, String> body) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: FutureBuilder<List<Evento>>(
        future: _getData(requestURL, body),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasError &&
              snapshot.data != null &&
              snapshot.data.isNotEmpty) {
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
                                      _backgroundColorBotao),
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
                                      _backgroundColorBotao),
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
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Text(
                "Não foram encontrados certificados para o usuário",
                style: TextStyle(
                  color: _textsDarkBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget detalhesEvento(Evento detalhes) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Container(
          alignment: Alignment.topLeft,
          child: Text(
            detalhes.nome,
            style: TextStyle(color: _textsDarkBackground, fontSize: 20),
            maxLines: 2,
          ),
        ),
        backgroundColor: _appBarBackground,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Descrição",
              style: TextStyle(
                color: _textsDarkBackground,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _containerColor,
              ),
              child: Text(
                detalhes.descricao,
                style: TextStyle(
                  fontSize: 18,
                  color: _textsDarkBackground,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Inicio do Evento",
                style: TextStyle(
                  color: _textsDarkBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _containerColor,
              ),
              child: Text(
                "Data de Início: " +
                    detalhes.dataInicio +
                    "\nHorário de Início: " +
                    detalhes.horarioInicio,
                style: TextStyle(
                  fontSize: 18,
                  color: _textsDarkBackground,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Encerramento do Evento",
                style: TextStyle(
                  color: _textsDarkBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _containerColor,
              ),
              child: Text(
                "Data de Encerramento: " +
                    detalhes.dataFim +
                    "\nHorário de Encerramento: " +
                    detalhes.horarioFim,
                style: TextStyle(
                  fontSize: 18,
                  color: _textsDarkBackground,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Quantidade Participantes",
                style: TextStyle(
                  color: _textsDarkBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _containerColor,
              ),
              child: Text(
                detalhes.numeroMaximoParticipantes + " participantes",
                style: TextStyle(
                  fontSize: 18,
                  color: _textsDarkBackground,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Carga horária",
                style: TextStyle(
                  color: _textsDarkBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _containerColor,
              ),
              child: Text(
                detalhes.cargaHoraria + "h",
                style: TextStyle(
                  fontSize: 18,
                  color: _textsDarkBackground,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onPressed() {}
}
