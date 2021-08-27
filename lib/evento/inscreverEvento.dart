import 'package:flutter/material.dart';
import 'package:plataforma_eventos/evento/listarEventos.dart';

import 'buscarEvento.dart';

class InscreverEvento extends StatefulWidget {
  final String _url;
  final String _idUsuario;
  const InscreverEvento(String idUsuario, String url)
      : _idUsuario = idUsuario,
        _url = url;

  @override
  _InscreverEventoState createState() => _InscreverEventoState();
}

class _InscreverEventoState extends State<InscreverEvento> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> body;
    return Scaffold(
      backgroundColor: Colors.grey[800],
      //TODO
      /* body: ListarEventos()
          .getEventosGrid(widget._url + "getEventosAbertos.php", body), */
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
