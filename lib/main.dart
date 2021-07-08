import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/authentication/authentication_bloc.dart';
import 'package:rejolute/authentication/authentication_event.dart';
import 'package:rejolute/bloc.dart';
import 'package:rejolute/my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Bloc.observer = EchoBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (BuildContext context) {
      return AuthenticationBloc()..add(AppStartedEvent());
    },
    child: MyApp(),
  ));
}
