class ProfileClass {
  String firstName;
  String lastName;
  int age;
  bool gender;
  double height;
  String secret;
  List<String> hobbies;
  String favoriteLanguage;

  ProfileClass({
    this.firstName = "",
    this.lastName = "",
    this.age = 0,
    this.gender = false,
    this.height = 0.0,
    this.secret = "",
    this.hobbies = const [],
    this.favoriteLanguage = "Reactjs",
  });

  String setName() => "$firstName $lastName";
  String setAge() {
    String ageString = "$age an";
    if (age > 1) {
      ageString += "s";
    }
    return ageString;
  }

  String genderString() => (gender) ? "Féminin" : "Masculin";

  String setHeight() => "$height centimètre";

  String setHobbies() {
    String toHobbiesString = "";
    if (hobbies.isEmpty) {
      return toHobbiesString;
    } else {
      toHobbiesString = "Mes hobbies sont:";
      for (var element in hobbies) {
        toHobbiesString += " $element,";
      }

      return toHobbiesString;
    }
  }
}
