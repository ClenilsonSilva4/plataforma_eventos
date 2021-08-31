import 'package:flutter/material.dart';
import 'package:plataforma_eventos/usuario/organizador/eventosOrganizador.dart';

import 'package:plataforma_eventos/usuario/organizador/organizador.dart';
import 'package:plataforma_eventos/usuario/participante/participante.dart';
import 'package:plataforma_eventos/usuario/opcoes/opcoes.dart';

class InterfaceOrganizador extends StatefulWidget {
  final Organizador _usuario;
  final String _url;

  InterfaceOrganizador(Organizador usuario, String url)
      : this._usuario = usuario,
        _url = url;

  @override
  _InterfaceOrganizadorState createState() => _InterfaceOrganizadorState();
}

class _InterfaceOrganizadorState extends State<InterfaceOrganizador> {
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
          EventosOrganizador(widget._url, widget._usuario.id),
          Opcoes(Participante.fromUsuario(widget._usuario), widget._url),
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
            icon: Icon(Icons.create_outlined, color: Color(0xDE000000)),
            activeIcon: Icon(Icons.create_rounded, color: Color(0xFFFFFFFF)),
            label: "Eventos",
            tooltip: "Espaço para criação e visualização dos eventos",
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
