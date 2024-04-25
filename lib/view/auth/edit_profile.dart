import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({super.key});

  @override
  _ProfileEditViewState createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String _gender = 'Male'; // Default gender value
  int _age = 18; // Default age value
  File? _imageFile; // Variable to store the selected image file

  // Function to handle selecting image from gallery or camera
  Future<void> _selectImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "edit_profile".tr,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () {
                // Open bottom sheet to choose image source
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.photo_library),
                          title: const Text("Galeriden Seç"),
                          onTap: () {
                            Navigator.pop(context);
                            _selectImage(ImageSource.gallery);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.photo_camera),
                          title: const Text("Kamerayı Kullan"),
                          onTap: () {
                            Navigator.pop(context);
                            _selectImage(ImageSource.camera);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile != null ? FileImage(_imageFile!) : const AssetImage("lib/assets/images/user.png") as ImageProvider,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "name".tr,
                    ),
                    controller: _nameController,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "email".tr,
                    ),
                    controller: _emailController,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text("${"gender".tr}:"),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: _gender,
                  onChanged: (String? newValue) {
                    setState(() {
                      _gender = newValue!;
                    });
                  },
                  items: <String>["Male", "Female", "Other"].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value.toString().tr),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text("${"age".tr}:"),
                const SizedBox(width: 8),
                DropdownButton<int>(
                  value: _age,
                  onChanged: (int? newValue) {
                    setState(() {
                      _age = newValue!;
                    });
                  },
                  items: List.generate(100, (index) => index + 1).map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "save".tr,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
