import 'package:flutter/material.dart';

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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.search_off_rounded,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepOrange[800],
      ),
    );
  }
}
