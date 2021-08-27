import 'package:flutter/material.dart';

import 'package:plataforma_eventos/evento/listarEventos.dart';

class Inscricoes extends StatefulWidget {
  final String _idUsuario;
  final String _url;
  Inscricoes(String idUsuario, String url)
      : _idUsuario = idUsuario,
        _url = url;

  @override
  _InscricoesState createState() => _InscricoesState();
}

class _InscricoesState extends State<Inscricoes> {
  @override
  Widget build(BuildContext context) {
    ListarEventos getEventos = new ListarEventos();
    return getEventos.getEventosGrid(
        widget._url + "getEventosUsuario.php", {"id": widget._idUsuario});
  }
}
