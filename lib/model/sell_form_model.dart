// class SellFormModel {
//   final String?id;
//   final String name;
//   final String propertyType;
//   final List<String> photoPath; 
//   final String location;
//   final String phoneNumber;
//   final String email;
//   final String about;
//   final String amount;
//   final String furnished;
//   final String powerbackup;
//   final String constructionstatus;
//   final String bedroom;
//   final String bathroom;
//    final List<Map<String, dynamic>> amenities;

//   SellFormModel({
//     this.id,
//     required this.name,
//     required this.propertyType,
//     required this.photoPath,
//     required this.location,
//     required this.phoneNumber,
//     required this.email,
//     required this.about,
//     required this.amount,
//     required this.furnished,
//     required this.powerbackup,
//     required this.amenities,
//     required this.constructionstatus,
//     required this.bathroom,
//     required this.bedroom,
    
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'propertyType': propertyType,
//       'photoPath': photoPath,
//       'location': location,
//       'phoneNumber': phoneNumber,
//       'email': email,
//       'about':about,
//       'amount':amount,
//       'furnished':furnished,
//       'powerbackup':powerbackup,
//       'amenities':amenities,
//       'constructionstatus':constructionstatus,
//     };
//   }

//   factory SellFormModel.fromJson(Map<String, dynamic> json) {
//     return SellFormModel(
//       name: json['name'] ?? '',
//       propertyType: json['propertyType'] ?? '',
//       photoPath: List<String>.from(json['photoPath'] ?? []),
//       location: json['location'] ?? '',
//       phoneNumber: json['phoneNumber'] ?? '',
//       email: json['email'] ?? '',
//       about: json['about']?? '',
//       amount: json['amount']?? '',
//       furnished: json['furnished']?? '',
//       powerbackup: json['powerbackup']?? '',
//       constructionstatus: json['construction status']?? '',
//       amenities: List<Map<String, dynamic>>.from(json['amenities'] ?? []), 
//       bathroom: json['bathroom']??'', 
//       bedroom: json['bedroom']??'',

//     );
//   }
// }
