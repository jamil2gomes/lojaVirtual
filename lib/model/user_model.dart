import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{

  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();


  bool isLoading = false;

  @override
  void addListener(listener) {
    super.addListener(listener);
    _loadCurrentUser();

  }


  void signUp({@required Map<String, dynamic> userData, @required String pass, @required VoidCallback onSuccess, @required VoidCallback onFail}) {

    _loading(true);


    _auth.createUserWithEmailAndPassword(email: userData["email"], password: pass).then((user)async{
        firebaseUser = user;

        await _saveUserData(userData);
        onSuccess();
        _loading(false);

    }).catchError((e){
      print(e);
      onFail();
      _loading(false);

    });
  }

  void signIn({@required String email, @required String pass, @required VoidCallback onSuccess, @required VoidCallback onFail}) async{

      _loading(true);

    _auth.signInWithEmailAndPassword(email: email, password: pass).then((user) async{

      firebaseUser = user;
      onSuccess();
      await _loadCurrentUser();
      _loading(false);

      notifyListeners();
    }).catchError((e){
      onFail();
      _loading(false);
    });

  }

  void _loading(bool value){
    isLoading = value;
    notifyListeners();
  }

  void signOut()async{
    await _auth.signOut();
    userData = Map();
    firebaseUser = null;
    notifyListeners();
  }

  bool isLoggedIn(){
    return firebaseUser != null;
  }

  void recoverPass(){

  }

  Future<Null>_saveUserData(Map<String, dynamic> userData) async{
    this.userData = userData;
    await Firestore.instance.collection("users").document(firebaseUser.uid).setData(userData); //salva no firebase
  }

  Future<Null> _loadCurrentUser()async{
    if(firebaseUser == null)
      firebaseUser = await _auth.currentUser();

    if(firebaseUser != null){
      if(userData["name"] == null){
        DocumentSnapshot docuser = await Firestore.instance.collection("users").document(firebaseUser.uid).get();
        userData = docuser.data;
      }
    }
    notifyListeners();
  }

}