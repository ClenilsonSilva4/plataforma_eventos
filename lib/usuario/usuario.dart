class Usuario {
  String _id;
  String _nome;
  String _email;
  String _senha;

  Usuario(String id, String nome, String email, String senha)
      : _id = id,
        _nome = nome,
        _email = email,
        _senha = senha;

  get id => this._id;

  get nome => this._nome;

  set nome(value) => this._nome = value;

  get email => this._email;

  set email(value) => this._email = value;

  get senha => this._senha;

  set senha(value) => this._senha = value;
}
