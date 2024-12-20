import 'dart:async';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';

class Syarat extends StatefulWidget {
  const Syarat({Key? key}) : super(key: key);

  @override
  State<Syarat> createState() => _SyaratState();
}

class _SyaratState extends State<Syarat> {
  String? _filePath;
  String? predicted;
  String prediction = '';
  Future<void> uploadAudio(File audioFile) async {
    final url =
        "http://10.0.2.2:5000//predict"; // Change this to your Flask back-end URL
    var request = await http.MultipartRequest('POST', Uri.parse(url));
    request.files
        .add(await http.MultipartFile.fromPath('audio', audioFile.path));
    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    setState(() {
      prediction = responseData;
    });
    print(responseData);
  }

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

  final TextEditingController namaController = TextEditingController();
  final TextEditingController usiaController = TextEditingController();
  final TextEditingController gajiController = TextEditingController();
  final TextEditingController anakController = TextEditingController();
  final TextEditingController motorController = TextEditingController();
  final TextEditingController mobilController = TextEditingController();
  final TextEditingController rumahController = TextEditingController();
//Audio player 1
  final audioPlayer1 = AudioPlayer();
//Audio player 2
  final audioPlayer2 = AudioPlayer();
  bool isPlaying1 = false;
  bool isPlaying2 = false;
  Duration duration1 = Duration.zero;
  Duration duration2 = Duration.zero;
  Duration position1 = Duration.zero;
  Duration position2 = Duration.zero;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  }

  @override
  void initState() {
    super.initState();

    //setAudio();
    //loadAudio();

    audioPlayer1.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying1 = state == PlayerState.playing;
      });
    });

    audioPlayer2.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying2 = state == PlayerState.playing;
      });
    });

    audioPlayer1.onDurationChanged.listen((newDuration) {
      setState(() {
        duration1 = newDuration;
      });
    });

    audioPlayer2.onDurationChanged.listen((newDuration) {
      setState(() {
        duration2 = newDuration;
      });
    });

    audioPlayer1.onPositionChanged.listen((newPosition) {
      setState(() {
        position1 = newPosition;
      });
    });

    audioPlayer2.onPositionChanged.listen((newPosition) {
      setState(() {
        position2 = newPosition;
      });
    });
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
    super.dispose();
  }



// widgets starting
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syarat Kelayakan'),
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
      body:   SingleChildScrollView(
      child: Stack(
        children: <Widget>[
      Padding(padding: EdgeInsets.all(10.0),
        child:  Column(
          children: <Widget>[
            
            Text(
              "Faktor-Faktor yang Diperhitungkan Dalam Pembagian Bansos",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 9, 117, 78),
                fontSize: 25,
              ),
            ),
SizedBox(height: 5.0),
Text("1. Variabel kas daerah\n2. Data Terpadu Kesejahteraan Sosial (DTKS)\n3. Tidak ada kepemilikkan mobil\n4. Tidak adanya kepemilikkan rumah diatas 1m\n5. Anggapan tingkat kemampuan oleh masyarakat sekitar\n6. Tidak adanya kepemilikkan anggota keluarga yang bekerja sebagai PNS, TNI, polri, BUMN, BUMD, DPR, DPRD\n7. Kemampuan mengkonsumsi air bermerk\n8. KK KTP berdomisili dan beralamat di DKI",
textAlign: TextAlign.justify,
style: TextStyle(
fontSize: 18

))
            ],
        ),
        ),
        ]
      )
     )
    );
  }
}
