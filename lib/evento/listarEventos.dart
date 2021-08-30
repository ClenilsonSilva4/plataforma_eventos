import 'package:flutter/material.dart';
import 'package:plataforma_eventos/evento/detalhesEvento.dart';
import 'package:plataforma_eventos/evento/getEventData.dart';
import 'package:plataforma_eventos/usuario/organizador/criarEvento.dart';
import 'evento.dart';

class ListarEventos {
  final Color _backgroundColorBotao = Colors.deepOrange[800]!;
  final Color _textsDarkBackground = Colors.white;
  final Color _backgroundColor = Colors.grey[800]!;

  Widget getEventosGrid(String requestURL, Map<String, String> body,
      String acaoEvento, BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: FutureBuilder<List<Evento>>(
        future: GetEventData().getEventData(requestURL, body),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasError &&
              snapshot.data != null &&
              snapshot.data.isNotEmpty) {
            return GridView.builder(
              padding: EdgeInsets.fromLTRB(5, 40, 5, 5),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  color: Colors.grey[700],
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Text(
                          data.nome,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: _textsDarkBackground,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                        child: Text(
                          data.dataInicio + " - " + data.dataFim,
                          style: TextStyle(
                            fontSize: 11,
                            color: _textsDarkBackground,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          data.descricao,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 6,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color: _textsDarkBackground,
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
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
                                  builder: (context) => DetalhesEvento(
                                      data,
                                      getActionButton(
                                          "edição", context, requestURL)),
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
            return Center(
              child: Text(
                //TODO: Ajustar para incluir o organizador e unidade também.
                (body.containsKey("dataFim"))
                    ? ("Não foram encontrados eventos que o usuário possa se inscrever")
                    : ("Não foram encontrados eventos que o usuário esteja inscrito"),
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
      floatingActionButton: getActionButton(acaoEvento, context, requestURL),
    );
  }

  FloatingActionButton? getActionButton(
      String buttonMessage, BuildContext context, String requestURL) {
    return FloatingActionButton(
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.grey[700],
              content: Text(
                "Deseja " + buttonMessage + "?",
                style: TextStyle(
                  color: _textsDarkBackground,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CriarEvento("1", "http://192.168.0.2:80/projeto/"),
                      ),
                    );
                  },
                  child: Text(
                    "Sim",
                    style: TextStyle(color: _textsDarkBackground),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Não",
                    style: TextStyle(color: _textsDarkBackground),
                  ),
                ),
              ],
            );
          },
        );
      },
      child: (buttonMessage.contains("editar"))
          ? Icon(
              Icons.add_circle_outline,
              color: _textsDarkBackground,
              size: 30,
            )
          : Icon(
              Icons.add_circle_outline,
              color: _textsDarkBackground,
              size: 30,
            ),
      tooltip: buttonMessage,
      backgroundColor: _backgroundColorBotao,
    );
  }
}
