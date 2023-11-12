class ChefDeChantier {
  String role;
  int id;

  ChefDeChantier({required this.role, required this.id});

  // Фабричный метод для создания объекта ChefDeChantier из JSON
  factory ChefDeChantier.fromJson(Map<String, dynamic> json) {
    return ChefDeChantier(
      role: json['role'] ?? '',
      id: json['id'] ?? 0,
    );
  }
}
