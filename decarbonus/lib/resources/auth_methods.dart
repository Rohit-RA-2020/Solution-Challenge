import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:decarbonus/models/user.dart' as model;
import 'package:decarbonus/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

  // Signing Up User

  Future<String> signUpUserWithImage({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        model.User _user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: photoUrl,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          responses: {},
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());
            _firestore.collection("users").doc(cred.user!.uid).update({"result": {}});

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseException catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        model.User _user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl:
              'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png',
          email: email,
          bio: bio,
          followers: [],
          following: [],
          responses: {},
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());
            _firestore.collection("users").doc(cred.user!.uid).update({"result": {}});

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseException catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> googleSign({
    required String email,
    required String username,
    required String bio,
    required String photoUrl,
  }) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String res = "Some error Occurred";
    try {
      model.User _user = model.User(
        username: username,
        uid: uid,
        photoUrl: photoUrl,
        email: email,
        bio: bio,
        followers: [],
        following: [],
        responses: {},
      );

      var userSnap = await _firestore.collection("users").doc(uid).get();
      try {
        userSnap.get('username');
      } catch (e) {
        _firestore.collection("users").doc(uid).set(_user.toJson());
        _firestore.collection("users").doc(uid).update({"result": {}});
      }

      res = "success";
    } on FirebaseException catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
