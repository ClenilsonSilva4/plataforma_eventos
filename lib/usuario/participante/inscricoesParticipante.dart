import 'package:flutter/material.dart';

import 'package:plataforma_eventos/evento/listarEventos.dart';

class InscricoesParticipante extends StatefulWidget {
  final String _idUsuario;
  final String _url;
  InscricoesParticipante(String idUsuario, String url)
      : _idUsuario = idUsuario,
        _url = url;

  @override
  _InscricoesParticipanteState createState() => _InscricoesParticipanteState();
}

class _InscricoesParticipanteState extends State<InscricoesParticipante> {
  @override
  Widget build(BuildContext context) {
    return ListarEventos(
      widget._url + "getEventosUsuario.php",
      {"id": widget._idUsuario},
      "",
    );
  }
}
