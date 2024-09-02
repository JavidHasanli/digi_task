class AnbarItemModel {
  int? id;
  int? warehouse;
  String? equipmentName;
  String? brand;
  String? model;
  String? mac;
  int? portNumber;
  String? serialNumber;
  int? number;
  String? sizeLength;
  bool? deleted;

  AnbarItemModel({
    this.id,
    this.warehouse,
    this.equipmentName,
    this.brand,
    this.model,
    this.mac,
    this.portNumber,
    this.serialNumber,
    this.number,
    this.sizeLength,
    this.deleted = false,
  });

  AnbarItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        warehouse = json['warehouse']['id'],
        equipmentName = json['equipment_name'],
        brand = json['brand'],
        model = json['model'],
        mac = json['mac'],
        portNumber = json['port_number'],
        serialNumber = json['serial_number'],
        number = json['number'],
        sizeLength = json['size_length'],
        deleted = json['deleted'] ?? false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['warehouse'] = warehouse;
    data['equipment_name'] = equipmentName;
    data['brand'] = brand;
    data['model'] = model;
    data['mac'] = mac;
    data['port_number'] = portNumber;
    data['serial_number'] = serialNumber;
    data['number'] = number;
    data['size_length'] = sizeLength;
    data['deleted'] = deleted;
    return data;
  }
}
