import 'package:flutter/material.dart';
import 'package:plataforma_eventos/usuario/participante/participante.dart';
import 'package:plataforma_eventos/evento/buscarEvento.dart';
import 'package:plataforma_eventos/usuario/opcoes/opcoes.dart';

import 'inscricoes.dart';
import 'certificados.dart';

class Interface extends StatefulWidget {
  final Participante _usuario;
  final String _url;

  Interface(Participante usuario, String url)
      : this._usuario = usuario,
        _url = url;

  @override
  _InterfaceState createState() => _InterfaceState();
}

class _InterfaceState extends State<Interface> {
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

  @override
  Widget build(BuildContext context) {
    final Color? backgroundAppBarColor = Colors.teal[800];
    return Scaffold(
      body: PageView(
        controller: _myPage,
        children: <Widget>[
          Inscricoes(widget._usuario.id, widget._url),
          BuscarEvento(),
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
            icon: Icon(Icons.search_outlined, color: Color(0xDE000000)),
            activeIcon: Icon(Icons.search, color: Color(0xFFFFFFFF)),
            label: 'Buscar',
            tooltip: 'Buscar novos eventos',
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
