import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? id;
  final String? nama;
  final int? usia;
  final int? penghasilan;
  final int? asset_motor;
  final int? asset_mobil;
  final int? asset_rumah;
  final int? harga_rumah;
  final int? harga_sewa;
  final int? jumlah_anak;
  final int? tanggungan_lain;
  final String? hasil;
  const UserModel({
    this.id,
    required this.nama,
    required this.usia,
    required this.penghasilan,
    required this.asset_motor,
    required this.asset_mobil,
    required this.asset_rumah,
    required this.harga_rumah,
    required this.harga_sewa,
    required this.jumlah_anak,
    required this.tanggungan_lain,
    required this.hasil,
  });

  toJson(){
    return {
'nama': nama,
'usia': usia,
'penghasilan': penghasilan,
'asset_motor': asset_motor,
'asset_mobil': asset_mobil,
'asset_rumah': asset_rumah,
'harga_rumah': harga_rumah,
'harga_sewa' : harga_sewa,
'jumlah_anak': jumlah_anak,
'tanggungan_lain': tanggungan_lain,
'hasil': hasil,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;

    return UserModel(
      id: document.id,
      nama: data["nama"],
      usia: data["usia"],
      penghasilan: data["penghasilan"],
      asset_motor: data["asset_motor"],
      asset_mobil: data["asset_mobil"],
      asset_rumah: data["asset_rumah"],
      harga_rumah: data["harga_rumah"],
      harga_sewa : data["harga_sewa"],
      jumlah_anak: data["jumlah_anak"],
      tanggungan_lain: data["tanggungan_lain"],
      hasil: data["hasil"],
    );
  }
}