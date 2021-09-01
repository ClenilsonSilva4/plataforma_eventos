import 'package:flutter/material.dart';

import 'package:plataforma_eventos/evento/listarEventos.dart';
import '../../evento/buscarEvento.dart';

class InscreverNoEvento extends StatefulWidget {
  final String _url;
  final Map<String, String> _body;

  const InscreverNoEvento(String url, Map<String, String> body)
      : _url = url,
        _body = body;

  @override
  _InscreverNoEventoState createState() => _InscreverNoEventoState();
}

class _InscreverNoEventoState extends State<InscreverNoEvento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: ListarEventos(
        widget._url + "getEventosAbertos.php",
        widget._body,
        "se inscrever",
      ),
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
