import 'package:aplikasi_kepegawaian/pages/spt/spt_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditPegawaiPage extends StatefulWidget {
  final String username;
  final String nama;
  final String nip;
  final String pangkat;
  final String jabatan;
  final String bidang;
  final String title;

  const EditPegawaiPage({
    super.key,
    required this.username,
    required this.nama,
    required this.nip,
    required this.pangkat,
    required this.jabatan,
    required this.bidang,
    required this.title,
  });

  @override
  State<EditPegawaiPage> createState() => _EditPegawaiPageState();
}

class _EditPegawaiPageState extends State<EditPegawaiPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController nipController = TextEditingController();
  TextEditingController jabatanController = TextEditingController();
  String? selectedValuePangkat;
  String? selectedValueBidang;

  List golongan = [];
  List bidang = [];

  void getGolongan() async {
    await FirebaseFirestore.instance
        .collection('golongan')
        .orderBy('nama_golongan', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var document in querySnapshot.docs) {
        setState(() {
          golongan.add(document['nama_golongan']);
        });
      }
    });
  }

  void getBidang() async {
    await FirebaseFirestore.instance
        .collection('bidang')
        .orderBy('nama_bidang', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var document in querySnapshot.docs) {
        setState(() {
          bidang.add(document['nama_bidang']);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getGolongan();
    getBidang();
    usernameController.text = widget.username;
    namaController.text = widget.nama;
    nipController.text = widget.nip;
    jabatanController.text = widget.jabatan;
    selectedValuePangkat = widget.pangkat;
    selectedValueBidang = widget.bidang;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Username",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 3),
                  decoration: BoxDecoration(
                      color: const Color(0xffEBECF0),
                      borderRadius: BorderRadius.circular(8)),
                  child: TextFormField(
                    onTap: () {},
                    controller: usernameController,
                    cursorColor: Colors.black,
                    style: const TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                        hintText: "Username",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey.shade700)),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Nama",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 3),
                  decoration: BoxDecoration(
                      color: const Color(0xffEBECF0),
                      borderRadius: BorderRadius.circular(8)),
                  child: TextFormField(
                    onTap: () {},
                    controller: namaController,
                    cursorColor: Colors.black,
                    style: const TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                        hintText: "Nama",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey.shade700)),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "NIP",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 3),
                  decoration: BoxDecoration(
                      color: const Color(0xffEBECF0),
                      borderRadius: BorderRadius.circular(8)),
                  child: TextFormField(
                    onTap: () {},
                    controller: nipController,
                    cursorColor: Colors.black,
                    style: const TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                        hintText: "NIP",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey.shade700)),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Pangkat / Golongan",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                DropdownButtonFormField2(
                  value: selectedValuePangkat,
                  buttonDecoration: BoxDecoration(
                    color: const Color(0xffEBECF0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  decoration: const InputDecoration(
                      border: InputBorder.none, isDense: true),
                  hint: Text(
                    'Pilih Pangkat',
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 50,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: golongan
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                              ),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Pilih Pangkat';
                    }
                  },
                  onChanged: (value) {
                    selectedValuePangkat = value.toString();
                  },
                  onSaved: (value) {
                    selectedValuePangkat = value.toString();
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  "Bidang",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                DropdownButtonFormField2(
                  value: selectedValueBidang,
                  buttonDecoration: BoxDecoration(
                    color: const Color(0xffEBECF0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  decoration: const InputDecoration(
                      border: InputBorder.none, isDense: true),
                  hint: Text(
                    'Pilih Bidang',
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 50,
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  items: bidang
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                              ),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Pilih Bidang';
                    }
                  },
                  onChanged: (value) {
                    selectedValueBidang = value.toString();
                  },
                  onSaved: (value) {
                    selectedValueBidang = value.toString();
                  },
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Jabatan",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, top: 3),
                  decoration: BoxDecoration(
                      color: const Color(0xffEBECF0),
                      borderRadius: BorderRadius.circular(8)),
                  child: TextFormField(
                    onTap: () {},
                    controller: jabatanController,
                    cursorColor: Colors.black,
                    style: const TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                        hintText: "Jabatan",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey.shade700)),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: size.width,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SptPage(),
                          ),
                          (Route<dynamic> route) => false);
                    },
                    child: Text(
                      'Edit Profile',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  // void updateSuratTugas() async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('spt')
  //         .doc(widget.idSuratTugas)
  //         .update({
  //       'no_spt': noSuratController.text,
  //       'nama': selectedValuePegawai,
  //       'maksud_tujuan': maksudTujuanController.text,
  //       'tempat_tujuan': tempatTujuanController.text,
  //       'tanggal': selectedDate,
  //     });

  //     Fluttertoast.showToast(
  //         msg: "Data Berhasil Diubah",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 3,
  //         backgroundColor: Colors.blue,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}
