class RSbed {
  final String name;
  final String address;
  final int availableBed;
  final int bedQueue;
  final String hotline;
  final String bedDetailLink;
  final String hospitalCode;
  final int updatedMinutes;
  final String latitude;
  final String longitude;

  RSbed(
      {required this.name,
      required this.address,
      required this.availableBed,
      required this.bedQueue,
      required this.hotline,
      required this.bedDetailLink,
      required this.hospitalCode,
      required this.updatedMinutes,
      required this.latitude,
      required this.longitude});

  //getter
  @override
  List<Object> get props => [
        name,
        address,
        availableBed,
        bedQueue,
        hotline,
        bedDetailLink,
        hospitalCode,
        updatedMinutes,
        latitude,
        longitude
      ];

  @override
  String toString() =>
      'beds{name: $name, address: $address, available_bed: $availableBed, bed_queue: $bedQueue, hotline: $hotline, bed_detail_link: $bedDetailLink, hospital_code: $hospitalCode, update_minutes: $updatedMinutes, latitude: $latitude, longitude: $longitude },';

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'available_bed': availableBed,
        'bed_queue': bedQueue,
        'hotline': hotline,
        'bed_detail_link': bedDetailLink,
        'hospital_code': hospitalCode,
        'update_minutes': updatedMinutes,
        'latitude': latitude,
        'longitude': longitude
      };

  factory RSbed.fromJson(Map<String, dynamic> parsedJson) {
    return new RSbed(
        name: parsedJson['name'] ?? "",
        address: parsedJson['address'] ?? "",
        availableBed: parsedJson['available_bed'] ?? 0,
        bedQueue: parsedJson['bed_queue'] ?? 0,
        hotline: parsedJson['hotline'] ?? "",
        bedDetailLink: parsedJson['bed_detail_link'] ?? "",
        hospitalCode: parsedJson['hospital_code'] ?? "",
        updatedMinutes: parsedJson['updated_at_minutes'] ?? 0,
        latitude: parsedJson['lat'] ?? "",
        longitude: parsedJson['long'] ?? "");
  }
}
