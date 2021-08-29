import 'package:flutter/material.dart';
import 'package:plataforma_eventos/evento/listarEventos.dart';
import 'package:plataforma_eventos/usuario/organizador/organizador.dart';

class CriarEvento extends StatefulWidget {
  final Organizador _usuario;
  final String _url;
  const CriarEvento(Organizador usuario, String url)
      : _usuario = usuario,
        _url = url;

  @override
  _CriarEventoState createState() => _CriarEventoState();
}

class _CriarEventoState extends State<CriarEvento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Novo Evento"),
      ),
      body: ListarEventos().getEventosGrid(
          widget._url + "getEventosOrganizador.php",
          {"id": widget._usuario.id},
          "criar",
          context),
    );
  }
}
