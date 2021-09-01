import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConfirmarInscricao {
  String _dataForDB() {
    DateTime dataInscription = DateTime.now();

    return dataInscription.year.toString() +
        "-" +
        dataInscription.month.toString() +
        "-" +
        dataInscription.day.toString();
  }

  Future confirmEventInscriptionDB(
      String finalURL, BuildContext context, Map<String, String> body) async {
    Color textColor = Colors.white;
    Color buttonColor = Colors.deepOrange[800]!;

    final Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8'
    };

    body["data"] = _dataForDB();
    body.remove("url");

    var getURL = Uri.parse(finalURL + "inscreverUsuario.php");

    http.Response response = await http.post(
      getURL,
      headers: header,
      body: json.encode(body),
    );

    if (response.body.toString().contains("<br />")) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            content: Text(
              "Não foi possível se inscrever evento",
              style: TextStyle(color: textColor),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancelar",
                  style: TextStyle(color: textColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  confirmEventInscriptionDB(finalURL, context, body);
                },
                child: Text(
                  "Tentar Novamente",
                  style: TextStyle(color: textColor),
                ),
              ),
            ],
          );
        },
      );
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Inscrição efetuada com sucesso",
            style: TextStyle(
              color: textColor,
            ),
          ),
          duration: const Duration(milliseconds: 1500),
          width: 280.0,
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
          ),
          backgroundColor: buttonColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }
}
