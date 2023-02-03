import 'package:crud_firebase/navigation/navigator.dart';
import 'package:crud_firebase/widgets/image_upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final User? user = FirebaseAuth.instance.currentUser;

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _photoUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (user != null) {
      // final uid = user!.uid;
      debugPrint('User is signed in with uid: $user');
    }
  }

  Widget _buildTextField({
    required String label,
    required String placeholder,
    TextInputType textInputType = TextInputType.name,
    required TextEditingController controller,
    FocusNode? focusNode,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        focusNode: focusNode,
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          labelText: label,
          hintText: placeholder,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NavigateToPage()));
              },
              child: const Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                  radius: 50,
                  backgroundImage: user!.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : const NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                  child: IconButton(
                    color: Colors.black54,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ImageUpload()));
                    },
                    icon: const Icon(Icons.camera_alt),
                  )),
              Center(
                child: Text(
                  user!.email!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Display Name',
                placeholder: 'Enter display name',
                controller: _displayNameController,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Phone',
                placeholder: 'Enter phone',
                controller: _phoneController,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                label: 'Photo URL',
                placeholder: 'Enter photo URL',
                controller: _photoUrlController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreenAccent,
                    shadowColor: Colors.white,
                    foregroundColor: Colors.black),
                onPressed: () {
                  debugPrint('Update Profile');
                },
                child: const Text('Update Profile'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shadowColor: Colors.white,
                    foregroundColor: Colors.black),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ));
  }
}
