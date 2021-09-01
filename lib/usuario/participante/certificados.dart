import 'package:flutter/material.dart';
import 'package:plataforma_eventos/evento/evento.dart';
import 'package:plataforma_eventos/evento/getEventData.dart';

class Certificados extends StatelessWidget {
  final String _url;
  final String _idUsuario;
  const Certificados(String idUsuario, String url)
      : _url = url,
        _idUsuario = idUsuario;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColorBotao = Colors.deepOrange[800]!;
    Color _textsDarkBackground = Colors.white;
    Color _backgroundColor = Colors.grey[800]!;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: FutureBuilder<List<Evento>>(
        future: GetEventData().getEventData(
            _url + "getCertificadosUsuario.php", {"id": _idUsuario}),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasError &&
              snapshot.data != null &&
              snapshot.data.isNotEmpty) {
            return ListView.separated(
              padding: EdgeInsets.fromLTRB(8, 40, 8, 5),
              itemCount: snapshot.data.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 3,
                thickness: 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                        child: Text(
                          data.nome,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                        child: Text(
                          data.dataInicio + " - " + data.dataFim,
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          data.descricao,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(10)),
                                  backgroundColor: MaterialStateProperty.all(
                                      _backgroundColorBotao),
                                ),
                                onPressed: () {},
                                child: const Text("VISUALIZAR"),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.all(10)),
                                  backgroundColor: MaterialStateProperty.all(
                                      _backgroundColorBotao),
                                ),
                                onPressed: () {},
                                child: const Text("BAIXAR"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Text(
                "Não foram encontrados certificados para o usuário",
                style: TextStyle(
                  color: _textsDarkBackground,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
