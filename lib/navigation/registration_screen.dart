import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase/model/auth_user.dart';
import 'package:crud_firebase/navigation/login_screen.dart';
import 'package:crud_firebase/views/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  // Firebase Auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  // Form key
  final _formKey = GlobalKey<FormState>();

  // Editing controllers for text fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    //  All fields
    final nameField = TextFormField(
      controller: nameController,
      autofocus: false,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        hintText: 'Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
      ),
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return 'Field cannot be empty';
        }
        // reg validation for password
        if (!regex.hasMatch(value)) {
          return 'Valid name have at least 3 characters';
        }
        return null;
      },
      onSaved: (value) {
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
    );
    final lastNameField = TextFormField(
      controller: lastNameController,
      autofocus: false,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        hintText: 'Last Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your last name';
        }
        return null;
      },
      onSaved: (value) {
        lastNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
    );
    final emailField = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email),
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your email';
        }
        // reg validation for email address
        if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
    );
    final passwordField = TextFormField(
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock),
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
      ),
      validator: (value) {
        RegExp regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
        if (value!.isEmpty) {
          return 'Please enter your password';
        }
        // reg validation for password
        if (!regex.hasMatch(value)) {
          return 'Password must be at least 8 characters long and contain at least one letter and one number';
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.next,
    );
    final confirmPasswordField = TextFormField(
      controller: confirmPasswordController,
      autofocus: false,
      obscureText: true,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.lock),
        hintText: 'Confirm Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordController.text = value!;
      },
      textInputAction: TextInputAction.done,
    );
    final registerButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(12),
        ),
        onPressed: () {
          signUp();
        },
        child: const Text('Register', style: TextStyle(color: Colors.white)),
      ),
    );
    final loginLabel = TextButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Login()));
      },
      child: Text(
        'Have an account? Login',
        style: TextStyle(color: Colors.redAccent.shade700),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.blueAccent,
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Image.asset(
                  'assets/app_icon.png',
                  height: 150,
                ),
                const SizedBox(height: 48.0),
                nameField,
                const SizedBox(height: 8.0),
                lastNameField,
                const SizedBox(height: 8.0),
                emailField,
                const SizedBox(height: 8.0),
                passwordField,
                const SizedBox(height: 8.0),
                confirmPasswordField,
                const SizedBox(height: 24.0),
                registerButton,
                loginLabel
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .then((value) => postUserToFireStore())
            .then((value) => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SplashScreen())));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Fluttertoast.showToast(
              msg: 'The password provided is too weak.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else if (e.code == 'email-already-in-use') {
          Fluttertoast.showToast(
              msg: 'The account already exists for that email.',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } catch (e) {
        Fluttertoast.showToast(
            msg: 'Error creating user ${e.toString()}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  //? Post user to firestore
  postUserToFireStore() async {
    UserAuthentication userAuthentication = UserAuthentication();
    userAuthentication.firstName = nameController.text;
    userAuthentication.lastName = lastNameController.text;
    userAuthentication.uid = _auth.currentUser!.uid;
    userAuthentication.email = _auth.currentUser!.email;

    await _fireStore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .set(userAuthentication.toMap());
    Fluttertoast.showToast(
        msg: 'User created successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
