import 'dart:async';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:dltest/repository/user_repository.dart';
import 'package:dltest/models/user_model.dart';
import 'package:dltest/controllers/profile_controllers.dart';

enum SampleItem { itemOne, itemTwo, itemThree, itemFour, itemFive, itemSix, itemSeven, itemEight, itemNine, itemTen, itemEleven}

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String? _filePath;
  String? predicted;
  String prediction = '';

  final userRepo = Get.put(UserRepository());

  Future <void> deleteUser(String docRef) async{
    await userRepo.deleteUser(docRef);
  }
  // Future<void> main() async{
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.intializeApp(

  //   )
  // }


  final TextEditingController namaController = TextEditingController();
  final TextEditingController usiaController = TextEditingController();
  final TextEditingController gajiController = TextEditingController();
  final TextEditingController anakController = TextEditingController();
  final TextEditingController motorController = TextEditingController();
  final TextEditingController mobilController = TextEditingController();
  final TextEditingController rumahController = TextEditingController();
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
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
    SampleItem? selectedItem;
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
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
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: controller.getAllUser(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData){
                // UserModel userData = snapshot.data as UserModel;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (c,index){
                      return Column(
          children: [
            ListTile(
              iconColor: Colors.blue,
              tileColor: Colors.blue.withOpacity(0.3),
              // title: Text("Nama:  ${snapshot.data![index].nama}"),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Text("Nama:  ${snapshot.data![index].nama}",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),),
                  Text("Usia:  ${snapshot.data![index].usia.toString()}"),
                  Text("Kelayakan:  ${snapshot.data![index].hasil}"),],),
                  Column(
                  children: [
                  isLoading ? CircularProgressIndicator(
                          color: Colors.deepPurpleAccent,
                          backgroundColor: Colors.blueGrey,
                        ):  IconButton(
                    icon: const Icon(Icons.delete),
                    tooltip: 'Delete Data',
                    onPressed: () async{
                      print(snapshot.data![index].id);
                      setState(() {
                        isLoading=true;
                      });
                      await deleteUser(snapshot.data![index].id.toString());
                
                      setState(() {
                        isLoading=false;
                      });
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data Berhasil Terhapus')),
                  );
                    },),
                    PopupMenuButton<SampleItem>(
          // initialValue: selectedItem,
          // onSelected: (SampleItem item) {
          //   setState(() {
          //     selectedItem = item;
          //   });
          // },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
            PopupMenuItem<SampleItem>(
              value: SampleItem.itemOne,
              child: Text("Nama:  ${snapshot.data![index].nama}")
            ),
            PopupMenuItem<SampleItem>(

              value: SampleItem.itemTwo,
              child: Text("Usia:  ${snapshot.data![index].usia.toString()}"),
            ),
            PopupMenuItem<SampleItem>(
              value: SampleItem.itemThree,
              child: Text("Penghasilan:  ${snapshot.data![index].penghasilan.toString()}"),
            ),
            PopupMenuItem<SampleItem>(
              value: SampleItem.itemFour,
              child: Text("Jumlah Motor:  ${snapshot.data![index].asset_motor.toString()}"),
            ),
            PopupMenuItem<SampleItem>(
              value: SampleItem.itemFive,
              child: Text("Jumlah Mobil:  ${snapshot.data![index].asset_mobil.toString()}"),
            ),
                        PopupMenuItem<SampleItem>(
              value: SampleItem.itemSix,
              child: Text("Jumlah Rumah:  ${snapshot.data![index].asset_rumah.toString()}"),
            ),
                        PopupMenuItem<SampleItem>(
              value: SampleItem.itemSeven,
              child: Text("Harga Rumah:  ${snapshot.data![index].harga_rumah.toString()}"),
            ),
                        PopupMenuItem<SampleItem>(
              value: SampleItem.itemEight,
              child: Text("Harga Sewa (Per Bulan):  ${snapshot.data![index].harga_sewa.toString()}"),
            ),
                        PopupMenuItem<SampleItem>(
              value: SampleItem.itemNine,
              child: Text("Jumlah Anak:  ${snapshot.data![index].jumlah_anak.toString()}"),
            ),
                        PopupMenuItem<SampleItem>(
              value: SampleItem.itemTen,
              child: Text("Jumlah Tanggungan:  ${snapshot.data![index].tanggungan_lain.toString()}"),
            ),
                        PopupMenuItem<SampleItem>(
              value: SampleItem.itemEleven,
              child: Text("Hasil:  ${snapshot.data![index].hasil}"),
            ),
                      
          ],
        ),
                  ],)
                ]),
            ),
            SizedBox(height: 10,)
          ],
          );
                    },
                  );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }  else {
                return const Center(child: Text("Something went wrong"));
              }
            } else {
              return const Center(child:CircularProgressIndicator());
            }
          },          
        ),
      ),
    );
  }
}
