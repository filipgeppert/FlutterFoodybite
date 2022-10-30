import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

import '../models/interests.dart';
import '../models/city.dart';
import '../models/user.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  SingleValueDropDownController cityController = SingleValueDropDownController();
  MultiValueDropDownController interestsController = MultiValueDropDownController();
  TextEditingController professionController = TextEditingController();

  bool isLoading = false;
  User user;
  bool _nameValid = true;
  bool _bioValid = true;
  bool _professionValid = true;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser () async {
    setState(() {
      isLoading = true;
    });

    user = await Future.delayed(
        const Duration(milliseconds: 500),
        () => initializeFakeUser()
    );

    nameController.text = user.name;
    bioController.text = user.bio;
    professionController.text = user.profession;
    cityController.dropDownValue = DropDownValueModel(
        name: user.city, value: user.city
    );
    interestsController.dropDownValueList = user.interests.map(
        (interest) => DropDownValueModel(name: interest, value: interest)
    ).toList();

    setState(() {
      isLoading = false;
    });
  }

  Column buildDisplayNameField () {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            "Name",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            hintText: "Update Your Name",
            errorText: _nameValid ? null : "Name too short"
          ),
        )
      ],
    );
  }

  Column buildBioField () {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            "Bio",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: bioController,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
              hintText: "Update Your Bio",
              errorText: _bioValid ? null : "Bio too short"
          ),
        )
      ],
    );
  }

  Column buildCityField () {
    final cities = CITIES.map(
            (i) => DropDownValueModel(name: i, value: i)
    ).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            "City",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        DropDownTextField(
          controller: cityController,
          clearOption: true,
          enableSearch: true,
          clearIconProperty: IconProperty(color: Colors.green),
          searchDecoration: const InputDecoration(
              hintText: "enter your custom hint text here"
          ),
          validator: (value) {
            if (value == null) {
              return "Required field";
            } else {
              return null;
            }
          },
          dropDownItemCount: 6,

          dropDownList: cities,
          onChanged: (val) {

          },
        ),
      ],
    );
  }

  Column buildInterestsField () {
    final interestsOptions = INTERESTS.map(
        (i) => DropDownValueModel(name: i, value: i)
    ).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            "Interests",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        DropDownTextField.multiSelection(
          controller: interestsController,
          dropDownList: interestsOptions,
          onChanged: (val) {
            setState(() {});
          },
          submitButtonColor: Colors.blue,
        ),
      ],
    );
  }

  Column buildBestDescribedAsField () {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12),
          child: Text(
            "Best described as:",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: professionController,
          decoration: InputDecoration(
              hintText: "Ex. Creative Designer",
              errorText: _professionValid ? null : "Text too short"
          ),
        )
      ],
    );
  }

  updateProfileData () {
    setState(() {
      (nameController.text.trim().length < 3 || nameController.text.isEmpty) ? _nameValid = false : _nameValid = true;
      (bioController.text.trim().length < 100 || bioController.text.isEmpty) ? _bioValid = false : _bioValid = true;
      (professionController.text.trim().length < 5 || professionController.text.isEmpty) ? _professionValid = false : _professionValid = true;

      if (_nameValid && _bioValid && _professionValid) {

        user.setName(nameController.text);
        user.setBio(bioController.text);
        user.setCity(cityController.toString());
        user.setProfession(professionController.text);
        user.setInterests(
            interestsController.dropDownValueList.map((item) => item.name).toList()
        );

        SnackBar snackBar = SnackBar(content: Text('Profile updated!'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black45,
          )
        ),
        actions: [
          // IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.done, size: 30, color: Colors.blueGrey,)
          // )
        ],
      ),
      // TODO: Add circular progress indicator
      body: isLoading ? Text('Loading...') : ListView(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 16, bottom: 8),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.imageUrl),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        buildDisplayNameField(),
                        buildBioField(),
                        buildBestDescribedAsField(),
                        buildCityField(),
                        buildInterestsField()
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: TextButton(
                        onPressed: updateProfileData,
                        child: Text(
                            "Update profile",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.grey)
                        ),
                    ),
                  )
                  ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
