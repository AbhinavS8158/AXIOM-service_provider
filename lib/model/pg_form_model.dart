class PgFormModel {
  final String?id;
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
  final String food;
  final String bathroom;
  final String bedroom;


   final List<Map<String, dynamic>> amenities;

  PgFormModel({
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
    required this.amenities,
    required this.food,
    required this.bathroom,
    required this.bedroom
 
    
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'propertyType': propertyType,
      'photoPath': photoPath,
      'location': location,
      'phoneNumber': phoneNumber,
      'email': email,
      'about':about,
      'amount':amount,
      'furnished':furnished,
      'powerbackup':powerbackup,
      'amenities':amenities,
      'food':food,
      'bedroom':bedroom,
      'bathroom':bathroom
      
    };
  }

  factory PgFormModel.fromJson(Map<String, dynamic> json) {
    return PgFormModel(
      name: json['name'] ?? '',
      propertyType: json['propertyType'] ?? '',
      photoPath: List<String>.from(json['photoPath'] ?? []),
      location: json['location'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      about: json['about']?? '',
      amount: json['amount']?? '',
      furnished: json['furnished']?? '',
      powerbackup: json['powerbackup']?? '',
      amenities: List<Map<String, dynamic>>.from(json['amenities'] ?? []),
      food: json['food']??'',
      bathroom: json['bathroom']??'',
      bedroom: json['bedroom']?? '',

    );
  }
}
