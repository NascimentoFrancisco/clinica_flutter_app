class Medico {
  final int id;
  final String nome;
  final String crm;
  final String email;
  final String telefone;
  final int especialidade_id;

  const Medico({ required this.id, required this.nome, required this.crm, required this.email, required this.telefone,
      required this.especialidade_id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'crm': crm,
      'email': email,
      'telefone': telefone,
      'especialidade_id': especialidade_id
    };
  }

  @override
  String toString() {
    return 'Medico{id: $id, nome: $nome, crm: $crm, email: $email, telefone: $telefone, especialidade_id: $especialidade_id}';
  }
}
