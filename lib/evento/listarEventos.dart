import 'package:flutter/material.dart';

import 'package:plataforma_eventos/evento/detalhesEvento.dart';
import 'package:plataforma_eventos/evento/getEventData.dart';
import 'package:plataforma_eventos/usuario/organizador/preencherEvento.dart';
import 'evento.dart';

const String _initialURL = "http://192.168.0.2:80/projeto/";

class ListarEventos extends StatefulWidget {
  final String _requestURL;
  final String _acaoEvento;
  final Map<String, String> _body;
  const ListarEventos(
      String requestURL, Map<String, String> body, String acaoEvento)
      : _requestURL = requestURL,
        _acaoEvento = acaoEvento,
        _body = body;

  @override
  _ListarEventosState createState() => _ListarEventosState();
}

class _ListarEventosState extends State<ListarEventos> {
  final Color _backgroundColorBotao = Colors.deepOrange[800]!;
  final Color _textsDarkBackground = Colors.white;
  final Color _backgroundColor = Colors.grey[800]!;

  var eventsData;

  @override
  void initState() {
    eventsData = GetEventData().getEventData(widget._requestURL, widget._body);
    super.initState();
  }

  Future<void> _getData() async {
    var newData = GetEventData().getEventData(widget._requestURL, widget._body);
    setState(() {
      eventsData = newData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _getData,
      child: Container(
        color: _backgroundColor,
        child: FutureBuilder<List<Evento>>(
          future: eventsData,
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
                                if (widget._acaoEvento.contains("editar")) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetalhesEvento(
                                        data,
                                        widget._acaoEvento,
                                        PreencherEvento(widget._body["id"]!,
                                            _initialURL, data),
                                      ),
                                    ),
                                  );
                                } else if (widget._acaoEvento
                                    .contains("inscrever")) {
                                  Map<String, String> inscriptionBody = {
                                    "participante": widget._body["id"]!,
                                    "evento": data.id,
                                    "presente": "ausente",
                                    "url": _initialURL,
                                  };
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetalhesEvento(
                                        data,
                                        widget._acaoEvento,
                                        inscriptionBody,
                                      ),
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetalhesEvento(
                                          data, widget._acaoEvento, null),
                                    ),
                                  );
                                }
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
                  "Não foi possível carregar os eventos",
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
      ),
    );
  }
}
