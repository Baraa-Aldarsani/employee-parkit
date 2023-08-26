class GarageServices {
  final int id;
  final String name;
  final String image;
  final String information;
  final double price;

  GarageServices({
    required this.id,
    required this.name,
    required this.image,
    required this.information,
    required this.price,
  });

  factory GarageServices.fromJson(Map<String, dynamic> json) {
    return GarageServices(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        information: json['service_information'],
        price: double.parse(json['price'].toString()));
  }
}
