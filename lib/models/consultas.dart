class Consultas {
  final int id;
  final int cliente_id;
  final int agendaMedico_id;

  const Consultas({required this.id, required this.agendaMedico_id, required this.cliente_id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'agendaMedico_id': agendaMedico_id,
      'cliente_id': cliente_id,
    };
  }

  @override
  String toString() {
    return 'Agenda{ id: $id, agendaMedico_id: $agendaMedico_id, cliente_id: $cliente_id}';
  }
}
