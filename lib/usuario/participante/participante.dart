import '../usuario.dart';

class Participante extends Usuario {
  String _curso;

  Participante(String id, String nome, String email, String telefone,
      String senha, String curso)
      : _curso = curso,
        super(id, nome, email, telefone, senha);

  Participante.fromUsuario(Usuario teste)
      : _curso = "",
        super(teste.id, teste.nome, teste.email, teste.telefone, teste.senha);

  get curso => this._curso;
}
