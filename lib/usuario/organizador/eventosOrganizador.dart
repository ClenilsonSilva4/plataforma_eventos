import 'package:flutter/material.dart';
import 'package:plataforma_eventos/evento/listarEventos.dart';

import 'preencherEvento.dart';

class EventosOrganizador extends StatefulWidget {
  final String _url;
  final String _idUsuario;
  const EventosOrganizador(String requestURL, String idUsuario)
      : _url = requestURL,
        _idUsuario = idUsuario;

  @override
  _EventosOrganizadorState createState() => _EventosOrganizadorState();
}

class _EventosOrganizadorState extends State<EventosOrganizador> {
  final Color _backgroundColorBotao = Colors.deepOrange[800]!;
  final Color _textsDarkBackground = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListarEventos(
        widget._url + "getEventosOrganizador.php",
        {"id": widget._idUsuario},
        "editar o evento",
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.grey[700],
                content: Text(
                  "Deseja criar um novo evento?",
                  style: TextStyle(
                    color: _textsDarkBackground,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PreencherEvento.criarEvento(
                              widget._idUsuario,
                              "http://192.168.0.2:80/projeto/"),
                        ),
                      );
                      Navigator.pop(context);
                      setState(() {});
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
        child: Icon(
          Icons.add_circle_outline,
          color: _textsDarkBackground,
          size: 30,
        ),
        tooltip: "Criar um novo evento",
        backgroundColor: _backgroundColorBotao,
      ),
    );
  }
}
