import 'dart:async';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
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


// widgets starting
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
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
      body:
     SingleChildScrollView(
      child: Stack(
        children: <Widget>[
             
      Padding(padding: EdgeInsets.all(10.0),
        child:  Column(
          children: <Widget>[
            Row(children: [
              CircleAvatar(
  backgroundImage: AssetImage('assets/about.JPG'),
  minRadius: 50,
),
SizedBox(width: 10),
Flexible(
child: new Text("Peter James Tedja\nFakultas Teknologi Informasi Universitas Tarumanagara\n535210096",  textAlign: TextAlign.left,
style:TextStyle(
  fontSize: 16
)),
),
            ],),
            SizedBox(height: 30,),
            Text(
              "Sinopsis",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 9, 117, 78),
                fontSize: 20,
              ),
            ),
Text("Pemerintah Republik Indonesia telah melaksanakan sejumlah bentuk kegiatan bantuan sosial (bansos) dalam rangka pemenuhan kebutuhan pokok, meringankan tanggungan serta membenahi mutu hidup warga yang kekurangan. Bentuk kegiatan pembagian bansos dalam bentuk dana maupun benda yang dilakukan oleh para pejabat negara memiliki tujuan untuk membuat suatu bentuk kegiatan yang dapat menyejahterakan rakyat. Pada UU Nomor 14 Tahun 2019 tentang Pekerja Sosial dipaparkan jika UUD Negara Republik Indonesia serta Pancasila mengutus para pemimpin negara Indonesia untuk melaksanakan tanggung jawab mereka yaitu memberikan perlindungan serta bantuan pada rakyat dari kondisi-kondisi merugikan yang bisa saja muncul. Berlandaskan pada Permendagri Nomor 77 Tahun 2020 mengenai pedoman teknis pengelolaan keuangan daerah dimana, bantuan sosial dapat didefinisikan sebagai pembagian bantuan yaitu bantuan dana maupun benda yang berasal dari pemerintah suatu wilayah kepada perseorangan, keluarga, kelompok serta rakyat yang hanya dilakukan pada kondisi dan waktu tertentu serta bersifat memilih dengan alasan guna menjaga pembagian bantuan agar terhindar dari risiko sosial yang bisa saja terjadi. Pada kenyataannya, terdapat beberapa kasus dimana pembagian bantuan sosial yang tidak sesuai dengan target, sehingga warga yang layak tidak mendapatkan bantuan sosial. Dari hasil wawancara yang sudah dilakukan, ditemui beberapa kasus yang sama. Oleh sebab itu tugas akhir ini bertujuan menghasilkan sistem kelayakan bantuan sosial yang lebih objektif serta mudah digunakan oleh pengguna. Dalam pembuatan tugas akhir ini terdapat 2 metode yang digunakan, yaitu K-Means dan K-Nearest Neighbor. K-Means digunakan karena pengelompokannya cukup cepat dan efektif untuk  diimplementasikan terhadap data berjumlah besar. Sehingga data yang didapatkan dari wawancara menghasilkan kelompok data yang sesuai. Setelah itu digunakanlah Silhouette untuk menunjukkan objek apa yang berada dalam cluster mereka, dan mana yang berada di antara cluster. Plot silhouette menunjukkan Silhouette  semua kelompok sehingga kualitas kelompok dapat dibandingkan berdasarkan tingkat kelebaran (gelap) silhouette. Semakin lebar silhouette akan semakin baik kualitas suatu kelompok. K-Nearest Neighbor digunakan untuk menentukan kelas dari data baru. Input dari aplikasi ini berupa informasi yang diberikan pengguna mengenai kelayakan dan output dari aplikasi ini berupa informasi layak atau tidak layak pengguna dalam menerima bantuan sosial.",
textAlign: TextAlign.justify,
style:TextStyle(fontSize: 15)),
// SizedBox(height: 5.0),
//             Text(
//               "Ini Judul 2",
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: Color.fromARGB(255, 9, 117, 78),
//                 fontSize: 20,
//               ),
//             ),
//             Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque ut imperdiet purus. Proin vel ante nisl. Nulla euismod tempus sapien, a molestie turpis rhoncus eget. Praesent et tempus metus. Sed vulputate ornare vulputate. In hac habitasse platea dictumst. Nunc a volutpat metus. Morbi ac sapien in metus rhoncus sodales non vel mi. In augue diam, ornare ut libero at, venenatis molestie odio. Aliquam non massa id felis vehicula accumsan. Quisque elementum libero eu interdum tempus. Donec vestibulum consequat bibendum. Integer at nulla nec arcu dictum aliquet sit amet eu ipsum. Sed a aliquam ligula. Donec metus turpis, molestie quis tellus sed, blandit fermentum elit. Integer diam enim, commodo eu odio eu, volutpat porta sapien. Etiam scelerisque dolor magna, vel ullamcorper magna mattis quis. Ut scelerisque nulla erat, id pulvinar dolor scelerisque non. In et diam vitae diam congue sodales. Mauris vel fermentum leo, at porttitor velit. Nulla tincidunt tellus eros, vitae semper nisi tempor sed. Morbi imperdiet eget justo a aliquet. Donec eu nibh sit amet sem varius porttitor. Curabitur sodales arcu commodo neque auctor accumsan. Integer et tincidunt odio. Integer a lacus sagittis, viverra tortor eu, volutpat justo. Cras in posuere sem. Morbi dapibus rutrum ligula, ut vehicula mauris ullamcorper a. Sed pharetra lacinia consequat. Vivamus iaculis felis eget elit accumsan scelerisque. Ut quis purus sed risus ornare commodo. Nullam facilisis nunc dui, eget euismod nibh cursus eu. Pellentesque suscipit dignissim magna, nec lobortis urna dictum et. Integer sit amet neque eget ligula tristique interdum ac sed justo. Fusce pretium malesuada elit, ac lacinia purus aliquam vel. Donec id auctor nisl, eu hendrerit neque. Vivamus elit erat, hendrerit tristique lobortis nec, scelerisque quis est. Nunc quis nulla et metus tincidunt dignissim in vel lacus. Duis urna velit, porttitor eget mauris et, tincidunt tincidunt turpis. Curabitur imperdiet sagittis turpis, sagittis suscipit ligula auctor quis. Nam commodo nibh vel purus ultricies fringilla. Phasellus volutpat massa eget erat tempor, in rhoncus risus consequat. Nulla gravida metus dolor, ut maximus dolor molestie a. Duis dui leo, viverra eu turpis ac, eleifend euismod ligula. Nam ullamcorper magna non elit ultricies, sit amet molestie ipsum sodales. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam sodales rutrum risus pulvinar rutrum. Phasellus quis erat sapien. Morbi ullamcorper tincidunt augue non sagittis. Suspendisse potenti. Integer congue finibus justo, a rutrum tortor placerat eget. Nam in ligula eu tellus dapibus iaculis eget quis dui. Praesent a dignissim nisi, non suscipit nulla. Ut urna tellus, ornare sed ante nec, bibendum euismod massa. Morbi placerat congue semper. Nulla dapibus, tellus vitae egestas aliquet, nibh urna condimentum est, sed imperdiet est arcu lobortis turpis."),
//           
            ],
        ),
        ),
        ]
      )
     )
    );
  }
}
