import 'dart:developer';

import 'package:exo2/profile_class.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //appel de la classe
  ProfileClass myProfile = ProfileClass();

  //variables
  String titleBarName = "Profil";
  late TextEditingController lastName;
  late TextEditingController firstName;
  DateTime birthday = DateTime.now();
  double height = 60;
  bool gender = false;
  Map<String, bool> hobbies = {
    "Jeux video": false,
    "Films/série": false,
    "Lecture": false,
    "Alcool": false,
    "Ménage": false,
  };
  List langage = ["Java", "Javascript", "Reactjs", "Angular"];
  dynamic groupValue = 1;
  String favLangage = "";
  List hobbiesDisplay = [];

  @override
  void initState() {
    firstName = TextEditingController();
    lastName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(titleBarName),
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //container de lecture d'infos
          Container(
            color: Colors.deepOrange,
            margin: const EdgeInsets.all(5),
            width: width,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                      "Bonjour ${myProfile.setName()} ${firstName.text} ${lastName.text}"), //nom + prenom
                  Text("Age: ${setAge()} ans"),
                  Text("Taille: ${height.toInt()}"),
                  Text("Mes hobbies: ${hobbiesDisplay.join(", ")}"),

                  Text("Langage favoris: $favLangage"),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.orangeAccent,
            thickness: 5,
          ),
          const Text(
            "Infos",
            textAlign: TextAlign.center,
          ),
          //Remplissage infos
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                controller: firstName,
                decoration: const InputDecoration(hintText: "Prenom"),
                onChanged: ((value) => setState(() {})),
              ),
              TextField(
                controller: lastName,
                decoration: const InputDecoration(hintText: "Nom"),
                onChanged: ((value) => setState(() {})),
              ),
              Row(
                children: [
                  const Text("Date de naissance"),
                  IconButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1800),
                              lastDate: DateTime.now())
                          .then((value) {
                        setState(() {
                          birthday = value ?? DateTime.now();
                        });
                      });
                    },
                    icon: const Icon(Icons.calendar_month),
                  )
                ],
              ),
              Row(
                children: [
                  const Text("Taille"),
                  const Spacer(),
                  Slider(
                      value: height,
                      min: 60,
                      max: 233,
                      onChanged: (e) {
                        setState(() {
                          height = e;
                        });
                      })
                ],
              ),
              Row(
                children: [
                  Text("Genre: ${genderType()} "),
                  const Spacer(),
                  Switch(
                      value: gender,
                      onChanged: (e) {
                        setState(() {
                          gender = e;
                        });
                      })
                ],
              )
            ],
          ),
          const Divider(
            color: Colors.orangeAccent,
            thickness: 5,
          ),
          const Text(
            "Mes hobbies",
            textAlign: TextAlign.center,
          ),
          //hobbies
          checks(),
          //langage
          radios()
        ],
      )),
    );
  }

  int setAge() {
    return (DateTime.now().year - birthday.year);
  }

  String genderType() {
    return gender ? "Femme" : "Homme";
  }

  Column checks() {
    List<Widget> items = [];
    hobbies.forEach((hobbie, valid) {
      Widget choix = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(hobbie),
          Checkbox(
              value: valid,
              onChanged: (e) {
                setState(() {
                  hobbies[hobbie] = e ?? false;
                });
                if (e == true) {
                  hobbiesDisplay.add(hobbie);
                } else {
                  hobbiesDisplay.remove(hobbie);
                }
              })
        ],
      );
      items.add(choix);
    });

    return Column(children: items);
  }

  Row radios() {
    List<Widget> radios = [];
    for (var i = 0; i < langage.length; i++) {
      Radio r = Radio(
        value: langage[i],
        groupValue: groupValue,
        onChanged: ((e) {
          favLangage = e.toString();
          setState(() {
            groupValue = e as dynamic;
          });
        }),
      );
      radios.add(Column(
        children: [Text(r.value.toString()), r],
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: radios,
    );
  }
}
