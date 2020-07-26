import 'package:credicxo_intern/UI/home_page.dart';
import 'package:credicxo_intern/data/apiCalling/track_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:credicxo_intern/bloc/track_bloc/track_bloc.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        builder:(context)=> TrackBloc(repository: TrackRepositoryImp()),
        child: HomePage(),
      ),
    );
  }
}

