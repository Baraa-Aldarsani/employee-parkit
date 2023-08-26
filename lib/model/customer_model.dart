class CustomerModel {
  final int id;
  final String name;
  final String number;

  CustomerModel({required this.id, required this.name, required this.number});

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      name: json['name'],
      number: json['number'],
    );
  }
}
