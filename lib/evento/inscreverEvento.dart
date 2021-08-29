import 'package:flutter/material.dart';

import 'package:plataforma_eventos/evento/listarEventos.dart';
import 'buscarEvento.dart';

class InscreverEvento extends StatefulWidget {
  final String _url;
  final Map<String, String> _body;

  const InscreverEvento(String url, Map<String, String> body)
      : _url = url,
        _body = body;

  @override
  _InscreverEventoState createState() => _InscreverEventoState();
}

class _InscreverEventoState extends State<InscreverEvento> {
  //TODO: Criar a opção de se inscrever no evento.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: ListarEventos().getEventosGrid(
          widget._url + "getEventosAbertos.php",
          widget._body,
          "inscrição",
          context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BuscarEvento(widget._url),
            ),
          );
        },
        child: Icon(
          Icons.search_rounded,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepOrange[800],
      ),
    );
  }
}
