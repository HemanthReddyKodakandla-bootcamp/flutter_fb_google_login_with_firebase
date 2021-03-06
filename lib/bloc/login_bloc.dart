
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttergooglesigninapp/bloc/base_bloc.dart';
import 'package:fluttergooglesigninapp/repository/login_repo.dart';
import 'package:fluttergooglesigninapp/repository/login_repo_impl.dart';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;

class LoginBloc implements BaseBloc{

  LoginRepository _baseRepository;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool isTapped = false;
  StreamController<FirebaseUser> firebaseUser;
  Stream<FirebaseUser> get loggedUser => firebaseUser.stream;

  @override
  void init() {
    // TODO: implement init
    firebaseUser = StreamController<FirebaseUser>();
    _baseRepository = LoginRepositoryImpl();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    firebaseUser.close();
  }
  final simpleAuth.InstagramApi instagramApi = new simpleAuth.InstagramApi(
      "instagram", "3551676811515505", "4b1acdfae3ce8ebed9e1593de49edda3", "https://login-4583c.firebaseapp.com/__/auth/handle",
  scopes: []
  );
  signInWithEmail(String email,String password,BuildContext context){
    _baseRepository.signInWithEmail(email,password,context);
  }

  signUpWithEmail(String email,String password,BuildContext context){
    _baseRepository.signUpWithEmail(email, password,context);
  }

  sendEmailLink(String email){
    _baseRepository.sendSignInWithEmailLink(email);
  }

  handleSignIn(BuildContext context) async{
    FirebaseUser user = await _baseRepository.handleSignIn(context);
    firebaseUser.sink.add(user);
  }
  login(simpleAuth.AuthenticatedApi api){
    _baseRepository.login(api);
  }

}