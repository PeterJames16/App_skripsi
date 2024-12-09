import 'dart:async';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'pengujian.dart';
import 'syarat.dart';
import 'about.dart';
import 'history.dart';
import 'panduan.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String? _filePath;
  String? predicted;
  String prediction = '';
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

  // Future<void> pickWavFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['wav'],
  //   );

  //   if (result != null) {
  //     PlatformFile file = result.files.first;
  //     setState(() {
  //       _filePath = file.path;
  //     });
  //   }
  // }
  
  //tidak jadi menggunakan pesan
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pesanController = TextEditingController();
@override


    @override
  void dispose() {
  emailController.dispose();
  pesanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bantuan Sosial',style: TextStyle(
fontSize:20
),),
        backgroundColor: Color.fromARGB(255, 58, 12, 119),
      ),
      body: Center(

        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
                Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
       ElevatedButton(
                onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Pengujian()),
        );
      },
                child: Text('Cek Kelayakan',style: TextStyle(
      fontSize:20
      ),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 58, 12, 119)
                ,elevation: 3,
                minimumSize: const Size(150, 60), //////// HERE
                    ),
                    
                  
              ),
                  SizedBox(width: 20),
                    ElevatedButton(
                              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => History()),
                  );
                },
                child: Text('History',style: TextStyle(
      fontSize:20
      ),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 58, 12, 119)
                                  ,elevation: 3,
                minimumSize: const Size(150, 60), //////// HERE
                    ),
              ),
            ],),

              SizedBox(height: 20),
                  ElevatedButton(
                              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Syarat()),
                  );
                },
                child: Text('Syarat Kelayakan',style: TextStyle(
      fontSize:20
      ),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 58, 12, 119)
                                  ,elevation: 3,
                minimumSize: const Size(150, 60), //////// HERE
                    ),
              ),
              SizedBox(height: 20),
              
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
        ElevatedButton(
                              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Panduan()),
                  );
                },
                child: Text('Panduan Aplikasi',style: TextStyle(
      fontSize:20
      ),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 58, 12, 119)
                                  ,elevation: 3,
                                
                minimumSize: const Size(150, 60), //////// HERE
                    ),
              ),
                  SizedBox(width: 20),
                    
                ElevatedButton(
                              onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => About()),
                  );
                },
                child: Text('About',style: TextStyle(
      fontSize:20
      ),),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 58, 12, 119)
                                  ,elevation: 3,
                minimumSize: const Size(150, 60), //////// HERE
                    ),
              ),
            ],),
      SizedBox(height:30),
      const Image(image: AssetImage('assets/KESOSRAK.png'),
      fit: BoxFit.cover,
      height: 200,
      )
      //pesan
      // Container(
      //   margin: const EdgeInsets.all(15.0),
      //   padding: const EdgeInsets.all(3.0),
      //   decoration: BoxDecoration(
      //     border: Border.all(color: const Color.fromARGB(255, 0, 0, 0))
      //   ),
      //   child: Column(children: [
      
      //           Text("Pesan Masukkan",
      //               style: TextStyle(
      //                 fontWeight: FontWeight.w200,
      //                 color: Color.fromARGB(255, 9, 117, 78),
      //                 fontSize: 30,
      //               ),
      //             ),
      
      //           TextFormField(
      //   controller: emailController ,
      //   decoration: const InputDecoration(
      //     border: UnderlineInputBorder(),
      //     labelText: 'Email: ',
      //   ),
      // ),
      
      //           TextFormField(
      //   controller: pesanController,
      //   decoration: const InputDecoration(
      //     border: UnderlineInputBorder(),
      //     labelText: 'Pesan: ',
      //   ),
      // ),
      //         SizedBox(
      //               height: 30, //<-- SEE HERE
      //             ),
      //               ElevatedButton(
                  
      //                             onPressed: () {
      //                 // Navigator.push(
      //                 //   context,
      //                 //   MaterialPageRoute(builder: (context) => About()),
      //                 // );
      //               },
                
      //               child: Text('Kirim',style: TextStyle(
      //               fontSize:15
      //               ),),
      //               style: ElevatedButton.styleFrom(
      //               backgroundColor: Colors.green,
      //               shadowColor: Colors.greenAccent,
      //               elevation: 3,
      //               shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(32.0)),
      //               minimumSize: const Size(200, 40), //////// HERE
                    
      //                   ),
      //             ),          
      //   ],)
      // )
            ],
          ),
        ),
      ),
    );
  }
}
