class Cliente{
  final int  id;
  final String nome;
  final String cpf;
  final String email;
  final String sexo;
  final String telefone;
  
  const Cliente({required this.id, required this.nome, required this.cpf, required this.email, required this.sexo, required this.telefone});

  Map<String,dynamic> toMap(){
    return {
      'id':id,
      'nome':nome,
      'cpf':cpf,
      'email':email,
      'sexo':sexo,
      'telefone': telefone
    };
  }

  @override
  String toString(){
    return'Cliente{id: $id, nome: $nome, cpf: $cpf, email: $email, sexo: $sexo, telefone: $telefone}';
  }
}