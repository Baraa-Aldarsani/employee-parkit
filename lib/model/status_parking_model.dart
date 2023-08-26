class StatusParkingModel{

  final int id;
  final String name;


  StatusParkingModel({required this.id,required this.name});

  factory StatusParkingModel.fromJson(Map<String, dynamic> json) {
    return StatusParkingModel(
      id: json['id'],
      name: json['name'],
    );
  }
}