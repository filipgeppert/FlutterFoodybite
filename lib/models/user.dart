import 'package:flutter_foodybite/models/city.dart';
import 'package:flutter_foodybite/models/interests.dart';

class User {
  String id;
  String name;
  String city;
  String profession;
  String bio;
  String imageUrl;
  List<String> interests;

  User(
      {this.id,
      this.name,
      this.city,
      this.profession,
      this.bio,
      this.imageUrl,
      this.interests});

  setName (String name) {
    this.name = name;
  }
  setCity (String city) {
    this.city = city;
  }
  setProfession (String profession) {
    this.profession = profession;
  }
  setBio (String bio) {
    this.bio = bio;
  }
  setInterests (List<String> interests) {
    this.interests = interests;
  }

}

User initializeFakeUser() {
  return User(
      id: '1',
      name: 'Marta Smith',
      city: CITIES[0],
      profession: 'Software developer',
      bio: "Rodney Erickson is a content marketing professional at HubSpot,"
          " a CRM platform that helps companies attract visitors, convert leads,"
          " and close customers. Previously, Rodney worked as a marketing"
          " manager for a tech software startup. ",
      imageUrl: "https://www.rd.com/wp-content/uploads/2017/09/01-shutterstock_476340928-Irina-Bg.jpg",
      interests: INTERESTS.sublist(1,3)
  );
}
