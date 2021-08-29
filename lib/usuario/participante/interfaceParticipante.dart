import 'package:flutter/material.dart';

import 'package:plataforma_eventos/evento/inscreverEvento.dart';
import 'package:plataforma_eventos/usuario/participante/participante.dart';
import 'package:plataforma_eventos/usuario/opcoes/opcoes.dart';

import 'inscricoesParticipante.dart';
import 'certificados.dart';

class InterfaceParticipante extends StatefulWidget {
  final Participante _usuario;
  final String _url;

  InterfaceParticipante(Participante usuario, String url)
      : this._usuario = usuario,
        _url = url;

  @override
  _InterfaceParticipanteState createState() => _InterfaceParticipanteState();
}

class _InterfaceParticipanteState extends State<InterfaceParticipante> {
  int _selectedIndex = 0;
  PageController _myPage = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _myPage.jumpToPage(index);
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String getTodayDateString() {
    var dateNow = DateTime.now();
    return dateNow.year.toString() +
        "-" +
        dateNow.month.toString() +
        "-" +
        dateNow.day.toString();
  }

  @override
  Widget build(BuildContext context) {
    final Color? backgroundAppBarColor = Colors.teal[800];
    return Scaffold(
      body: PageView(
        controller: _myPage,
        children: <Widget>[
          InscricoesParticipante(widget._usuario.id, widget._url),
          InscreverEvento(widget._url,
              {"id": widget._usuario.id, "dataFim": getTodayDateString()}),
          Certificados(widget._usuario.id, widget._url),
          Opcoes(widget._usuario, widget._url),
        ],
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.shifting,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline, color: Color(0xDE000000)),
            activeIcon: Icon(Icons.favorite, color: Color(0xFFFFFFFF)),
            label: 'Inscrições',
            tooltip: 'Eventos que o usuário está inscrito',
            backgroundColor: backgroundAppBarColor,
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.event_available_outlined, color: Color(0xDE000000)),
            activeIcon:
                Icon(Icons.event_available_rounded, color: Color(0xFFFFFFFF)),
            label: 'Eventos',
            tooltip: 'Eventos que o usuário pode se inscrever',
            backgroundColor: backgroundAppBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy_outlined, color: Color(0xDE000000)),
            activeIcon: Icon(Icons.file_copy, color: Color(0xFFFFFFFF)),
            label: 'Certificados',
            tooltip: 'Certificados dos eventos que o usuário participou',
            backgroundColor: backgroundAppBarColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined, color: Color(0xDE000000)),
            activeIcon: Icon(Icons.settings, color: Color(0xFFFFFFFF)),
            label: 'Opções',
            tooltip: 'Opções da conta do usuário',
            backgroundColor: backgroundAppBarColor,
          ),
        ],
      ),
    );
  }
}
