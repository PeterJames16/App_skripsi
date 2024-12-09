import 'package:dltest/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pengujian.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCK4OuAjJQJs-xywjQXJa1aSbOStZcPPTs",
      appId: "1:286757499785:android:cdf26c69caddc22b9f2758",
      messagingSenderId: "XXX",
      projectId: "bansos-2016",
    ),
  );
  runApp(Picker());
}

class Picker extends StatefulWidget {
  const Picker({super.key});

  @override
  State<Picker> createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  @override
  void initState(){
    super.initState();
    initialization();
  }
  void initialization()async{
    // await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}
