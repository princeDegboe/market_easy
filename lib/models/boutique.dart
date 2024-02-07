import 'package:uuid/uuid.dart';

const uuid = Uuid();

class BoutiqueModel {
  BoutiqueModel({
    required this.legualForm,
    required this.sellerId,
    required this.country,
    required this.region,
    required this.name,
    required this.description,
    String? id,
  }) : id = uuid.v4();
  String legualForm;
  String id;
  String sellerId;
  String country;
  String region;
  String name;
  String description;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'legualForm': legualForm,
      'id': id,
      'sellerId': sellerId,
      'country': country,
      'region': region,
      'name': name,
      'description': description,
    };
  }

  factory BoutiqueModel.fromMap(Map<String, dynamic> map) {
    return BoutiqueModel(
      legualForm: map['legualForm'] as String,
      id: map['id'] as String,
      sellerId: map['sellerId'] as String,
      country: map['country'] as String,
      region: map['region'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
    );
  }
}
