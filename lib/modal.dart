  class UserModal{
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final Address address;


  UserModal({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.address,
  });

  factory UserModal.fromJson(Map<String,dynamic> json){

    return UserModal(
        id: json["id"], name: json["name"], username: json["username"],email: json["email"],
        phone: json["phone"],address: Address.fromJson(json["address"]));
  }

}

class Address{
  final String city;
  final String zipcode;
  final Geolocation geolocation;

  Address({required this.city,required this.zipcode,required this.geolocation});

  factory Address.fromJson(Map<String,dynamic> json){
    return Address(city: json["city"], zipcode: json["zipcode"], geolocation: Geolocation.fromJson(json["geo"]) );
  }

}

class Geolocation{
  final String latitude;
  final String longitude;

  Geolocation({required this.latitude,required this.longitude});
  factory Geolocation.fromJson(Map<String,dynamic> json){
    return Geolocation(latitude: json["lat"], longitude: json["lng"]);
  }
}
