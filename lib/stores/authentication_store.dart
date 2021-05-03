import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:aad_oauth/aad_oauth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'authentication_store.g.dart';

class AuthenticationStore = AuthenticationStoreBase with _$AuthenticationStore;

abstract class AuthenticationStoreBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final Config config = new Config(
      tenant: '850aa78d-94e1-4bc6-9cf3-8c11b530701c',
      clientId: '81f3e9f0-b0fd-48e0-9d36-e6058e5c6d4f',
      scope: "openid profile offline_access",
      redirectUri: "https://login.live.com/oauth20_desktop.srf");
  final AadOAuth oauth = new AadOAuth(config);

  @observable
  User firebaseUser;

  @observable
  Map<String, String> userData;

  @action
  Future<bool> isAlreadyAuthenticated() async {
    firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      String accessToken = await oauth.getAccessToken();
      var response = await http.get('https://graph.microsoft.com/v1.0/me',
          headers: {HttpHeaders.authorizationHeader: accessToken});
      var data = jsonDecode(response.body);
      userData = {};
      userData.addAll({
        'displayName': data['displayName'],
        'jobTitle': data['jobTitle'],
        'rollNumber': data['surname'],
      });
      return true;
    } else {
      return false;
    }
  }

  @action
  Future<void> signInWithMicrosoft(BuildContext context) async {
    Navigator.of(context).pushNamed('/powerup');
    oauth.setWebViewScreenSize(Rect.fromLTWH(
        0,
        25,
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height - 25));
    await oauth.login();
    String accessToken = await oauth.getAccessToken();
    if (accessToken != null) {
      var response = await http.get('https://graph.microsoft.com/v1.0/me',
          headers: {HttpHeaders.authorizationHeader: accessToken});
      var data = jsonDecode(response.body);
      print(data);

      final _auth = FirebaseAuth.instance;

      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
                email: data['mail'], password: '123456');
        print('Authentication Successful');
        onAuthenticationSuccessful(context, userCredential, data);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          UserCredential userCredential =
              await _auth.signInWithEmailAndPassword(
                  email: data['mail'], password: '123456');
          print('Authentication Successful');
          onAuthenticationSuccessful(context, userCredential, data);
        } else {
          print('Something went wrong!');
        }
      }
    } else {
      print('Something went wrong!');
    }
  }

  Future<void> onAuthenticationSuccessful(
      BuildContext context, UserCredential result, var data) async {
    firebaseUser = result.user;
    userData = {};
    userData.addAll({
      'displayName': data['displayName'],
      'jobTitle': data['jobTitle'],
      'rollNumber': data['surname'],
    });

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/approval', (Route<dynamic> route) => false);
  }

  @action
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut().then((value) async {
      oauth.logout();
      await Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      firebaseUser = null;
      userData = null;
    });
  }
}
