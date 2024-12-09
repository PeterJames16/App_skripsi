import 'dart:async';
import 'package:dltest/function.dart';
import 'package:dltest/models/user_model.dart';
import 'package:dltest/repository/user_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:dltest/models/user_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Pengujian extends StatefulWidget {
  const Pengujian({Key? key}) : super(key: key);

  @override
  State<Pengujian> createState() => _PengujianState();
}

class _PengujianState extends State<Pengujian> {
  String? _filePath;
  String? predicted;
  String prediction = '';
  List<List<dynamic>> _data = [];
  String? filePath;
  // Future<void> uploadAudio(File audioFile) async {
  //   final url =
  //       "http://10.0.2.2:5000//predict"; // Change this to your Flask back-end URL
  //   var request = await http.MultipartRequest('POST', Uri.parse(url));
  //   request.files
  //       .add(await http.MultipartFile.fromPath('audio', audioFile.path));
  //   var response = await request.send();
  //   var responseData = await response.stream.bytesToString();
  //   setState(() {
  //     prediction = responseData;
  //   });
  //   print(responseData);
  // }
  String url = '';
  var data;
  String output = 'initial output';
//pickwavfile not used
  Future<void> pickWavFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['wav'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        _filePath = file.path;
      });
    }
  }

  TextEditingController namaController = TextEditingController();
  TextEditingController usiaController = TextEditingController();
  TextEditingController gajiController = TextEditingController();
  TextEditingController anakController = TextEditingController();
  TextEditingController motorController = TextEditingController();
  TextEditingController mobilController = TextEditingController();
  TextEditingController rumahController = TextEditingController();
  TextEditingController hrumahController = TextEditingController();
  TextEditingController hsewaController = TextEditingController();
  TextEditingController tanggunganController = TextEditingController();
//Audio player 1
  final audioPlayer1 = AudioPlayer();
//Audio player 2
  final audioPlayer2 = AudioPlayer();
  bool isPlaying1 = false;
  bool isPlaying2 = false;


  @override
  void initState() {
    super.initState();

    //setAudio();
    //loadAudio();
  }

  Future setAudio() async {
    audioPlayer1.setReleaseMode(ReleaseMode.stop);

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['wav'],
    );
    if (result != null) {
      final file = File(result.files.single.path!);
      audioPlayer1.setSourceUrl(file.path);
      setState(() {
        _filePath = file.path;
      });
    }
  }

  Future loadAudio() async {
    audioPlayer2.setReleaseMode(ReleaseMode.stop);

    //Load audio from assets
    final player = AudioCache(prefix: 'assets/');
    final url = await player.load(prediction + '.wav');
    audioPlayer2.setSourceUrl(url.path);

  }

  @override
  void dispose() {
  namaController.dispose();
  usiaController.dispose();
  gajiController.dispose();
  anakController.dispose();
  motorController.dispose();
  mobilController.dispose();
  rumahController.dispose();
  tanggunganController.dispose();
  hrumahController.dispose();
  hsewaController.dispose();
  super.dispose();
  }
  final userRepo = Get.put(UserRepository());
  Future <void> createUser(UserModel user) async{
    await userRepo.createUser(user);
  }
  List<PlatformFile>? _paths;
  void _pickFile() async{
  try {
          _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['csv'],
      ))
          ?.files;
    } on PlatformException catch (e) {
      print('Unsupported operation' + e.toString());
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      if (_paths != null) {
        if (_paths != null) {
          //passing file bytes and file name for API call
          var decoded=Utf8Decoder().convert(_paths!.first.bytes!);
          final numLines = '\n'.allMatches(decoded).length + 1;
          LineSplitter ls = new LineSplitter();
          List<String> _masForUsing = ls.convert(decoded);
          for (var i = 1; i < _masForUsing.length; i++) {
            final splitted = _masForUsing[i].split(',');
            // print(splitted);
            final user = UserModel(
                nama: splitted[0],
                usia: int.parse(splitted[1]),
                penghasilan: int.parse(splitted[2]),
                jumlah_anak: int.parse(splitted[3]),
                tanggungan_lain: int.parse(splitted[4]),
                asset_motor: int.parse(splitted[5]),
                asset_mobil: int.parse(splitted[6]),
                asset_rumah: int.parse(splitted[7]),
                harga_rumah: int.parse(splitted[8]),
                harga_sewa: int.parse(splitted[9]),
                hasil: "Kosong");
                createUser(user);
          }
          ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data Tersimpan dan Terprediksi, Cek Hasil di History')),
                );
          
          // ApiClient.uploadFile(_paths!.first.bytes!, _paths!.first.name);
        }
      }
    });
    // final result = await FilePicker.platform.pickFiles(
    //   type: FileType.any,
    //   allowMultiple: false,
    //   // allowedExtensions: ['csv'],
    //   );

    // // if no file is picked
    // if (result != null && result.files.isNotEmpty) {
    //   final fileBytes = result.files.first.bytes;
    //   final fileName = result.files.first.name;
    //   print(fileName);
    //   // upload file
    //   // await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes!);
    // }

    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    // print(result.files.first.name);
    // filePath = result.files.first.path!;


  }
  // Future createUser(UserModel user) async{
  //   final docUser = FirebaseFirestore.instance.collection("predictions");
  //   user.id=docUser.id;

  //   final json=user.toJson();
  //   await docUser.set(json);
  // }
// widgets starting
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isValid = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediksi'),
        centerTitle: true,
        actions: <Widget>[
        ],
        backgroundColor: Color.fromARGB(255, 58, 12, 119),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        )),
      ),
      body: Center(
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
          TextFormField(
  controller: namaController,
  decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'Nama',
  ),
    validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Tolong masukkan nama';
    }
    return null;
  },
),
          TextFormField(
  controller: usiaController,
  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))],
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'Usia',
  ),
    validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Tolong masukkan usia';
    }
    return null;
  },
),
          TextFormField(
  controller: gajiController,
    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))],
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'Rentang Gaji',
  ),
      validator: (value) {
    if (value == null || value.isEmpty) {
      gajiController.text = '0';
    }
    return null;
  },
),
          TextFormField(
  controller: anakController,
    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))],
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'Jumlah Anak',
  ),
        validator: (value) {
    if (value == null || value.isEmpty) {
      anakController.text = '0';
    }
    return null;
  },
),
          TextFormField(
  controller: tanggunganController ,
    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))],
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'Tanggungan',
  ),
        validator: (value) {
    if (value == null || value.isEmpty) {
      tanggunganController.text = '0';
    }
    return null;
  },
),
SizedBox(height:20),
            Text(
              "Asset",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 9, 117, 78),
                fontSize: 30,
              ),
            ),
          TextFormField(
  controller: motorController ,
    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))],
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'Motor',
  ),
        validator: (value) {
    if (value == null || value.isEmpty) {
      motorController.text = '0';
    }
    return null;
  },
),
          TextFormField(
  controller: mobilController,
    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))],
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'Mobil',
  ),
        validator: (value) {
    if (value == null || value.isEmpty) {
      mobilController.text = '0';
    }
    return null;
  },
),
          TextFormField(
  controller: rumahController ,
    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))],
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'Rumah',
  ),
          validator: (value) {
    if (value == null || value.isEmpty) {
      rumahController.text = '0';
    }
    return null;
  },
),
          TextFormField(
  controller: hrumahController ,
    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))],
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'Harga Rumah',
  ),
            validator: (value) {
    if (value == null || value.isEmpty) {
      hrumahController.text = '0';
    }
    return null;
  },
),
          TextFormField(
  controller: hsewaController ,
    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^[1-9][0-9]*'))],
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(
    border: UnderlineInputBorder(),
    labelText: 'Harga Sewa (Per Bulan)',
  ),
  validator: (value) {
    if (value == null || value.isEmpty) {
      hsewaController.text = '0';
    }
    return null;
  },
),
        
        SizedBox(
          height:50,
        ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final user = UserModel(
                nama: namaController.text.trim(),
                usia: int.parse(usiaController.text),
                penghasilan: int.parse(gajiController.text),
                asset_motor: int.parse(motorController.text),
                asset_mobil: int.parse(mobilController.text),
                asset_rumah: int.parse(rumahController.text),
                harga_rumah: int.parse(hrumahController.text),
                harga_sewa: int.parse(hsewaController.text),
                jumlah_anak: int.parse(anakController.text),
                tanggungan_lain: int.parse(tanggunganController.text),
                hasil: "Kosong");
                createUser(user);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data Tersimpan dan Terprediksi, Cek Hasil di History')),
                );
                namaController.text="";
                usiaController.text="";
                gajiController.text="";
                motorController.text="";
                mobilController.text="";
                rumahController.text="";
                hrumahController.text="";
                hsewaController.text="";
                anakController.text="";
                tanggunganController.text="";
                }
              },
              
              child: Text('Predict',
              style: TextStyle(
fontSize:15
),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 58, 12, 119),
              elevation: 3,
              minimumSize: const Size(100, 50), //////// HERE
                  
                  ),
            ),
            SizedBox(
              height: 50, //<-- SEE HERE
            ),
        ElevatedButton(
                onPressed: () {
                  _pickFile();
      },
                child: Text('Upload CSV & Predict',style: TextStyle(
      fontSize:20
      ),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 58, 12, 119)
                ,elevation: 3,
                minimumSize: const Size(150, 60), //////// HERE
                    ),
                    
                  
              ),
            // prediction != ''
            //     ? Text(
            //         'Status Anda Adalah : $prediction',
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           color: Color.fromARGB(255, 201, 4, 4),
            //         ),
            //       )
            //     : Text(''),
            // Text(
            //   "Prediction Audio",
            //   style: TextStyle(
            //     fontWeight: FontWeight.w500,
            //     color: Color.fromARGB(255, 9, 117, 78),
            //     fontSize: 30,
            //   ),
            // ),
          ],
        ),
        )
      )
      )
    );
  }
}
