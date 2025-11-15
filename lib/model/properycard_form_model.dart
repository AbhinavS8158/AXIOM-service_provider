class PropertycardFormModel {
  final String? id;
  final String name;
  final String propertyType;
  final List<String> photoPath;
  final String location;
  final String phoneNumber;
  final String email;
  final String about;
  final String amount;
  final String furnished;
  final String powerbackup;
  final String bathroom;
  final String bedroom;
  final List<Map<String, dynamic>> amenities;
  final String? food;
  final String? status;
  final String? collectiontype;
  final String? constructionstatus;


  PropertycardFormModel({
    this.id,
    required this.name,
    required this.propertyType,
    required this.photoPath,
    required this.location,
    required this.phoneNumber,
    required this.email,
    required this.about,
    required this.amount,
    required this.furnished,
    required this.powerbackup,
    required this.bathroom,
    required this.bedroom,
    required this.amenities,
    this.food,
    this.status,
    this.collectiontype,
    this.constructionstatus,
   
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'propertyType': propertyType,
        'photoPath': photoPath,
        'location': location,
        'phoneNumber': phoneNumber,
        'email': email,
        'about': about,
        'amount': amount,
        'furnished': furnished,
        'powerbackup': powerbackup,
        'bathroom': bathroom,
        'bedroom': bedroom,
        'amenities': amenities,
        'food': food,
        'status': status ?? 'available',
        'collectiontype': collectiontype,
        'constructionstatus': constructionstatus,
        
      };

  factory PropertycardFormModel.fromJson(Map<String, dynamic> json) {
    return PropertycardFormModel(
      id: json['id'],
      name: json['name'] ?? '',
      propertyType: json['propertyType'] ?? '',
      photoPath: List<String>.from(json['photoPath'] ?? []),
      location: json['location'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      about: json['about'] ?? '',
      amount: json['amount'] ?? '',
      furnished: json['furnished'] ?? '',
      powerbackup: json['powerbackup'] ?? '',
      bathroom: json['bathroom'] ?? '',
      bedroom: json['bedroom'] ?? '',
      food: json['food']?? '',
      amenities: List<Map<String, dynamic>>.from(json['amenities'] ?? []),
      status: json['status'] ?? 'available',
      collectiontype: json['collectiontype'] ?? '',
      constructionstatus: json['constructionstatus'] ?? '',
     
    );
  }
}
