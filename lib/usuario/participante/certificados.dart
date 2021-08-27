import 'package:flutter/material.dart';
import 'package:plataforma_eventos/evento/listarEventos.dart';

class Certificados extends StatelessWidget {
  final String _url;
  final String _idUsuario;
  const Certificados(String idUsuario, String url)
      : _url = url,
        _idUsuario = idUsuario;

  @override
  Widget build(BuildContext context) {
    return ListarEventos().getEventosList(
        _url + "getCertificadosUsuario.php", {"id": _idUsuario});
  }
}
