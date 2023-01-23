import 'package:aplikasi_kepegawaian/pages/spt/spt_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CreateSptPage extends StatefulWidget {
  const CreateSptPage({super.key});

  @override
  State<CreateSptPage> createState() => _CreateSptPageState();
}

class _CreateSptPageState extends State<CreateSptPage> {
  TextEditingController noSuratController = TextEditingController();
  TextEditingController tempatTujuanController = TextEditingController();
  TextEditingController maksudTujuanController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String? formattedDate;
  String? selectedValuePegawai;

  List<String> listNama = [];

  @override
  void initState() {
    super.initState();

    getPegawai();
    getNoSurat();
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
                  height: 15,
                ),
                Text(
                  "Tambah Surat Perintah Tugas",
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
                  "No Surat",
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
                    controller: noSuratController,
                    cursorColor: Colors.black,
                    style: const TextStyle(fontSize: 17),
                    decoration: InputDecoration(
                        hintText: "No Surat",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey.shade700)),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Pegawai",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                DropdownButtonFormField2(
                  value: selectedValuePegawai,
                  buttonDecoration: BoxDecoration(
                    color: const Color(0xffEBECF0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  decoration: const InputDecoration(
                      border: InputBorder.none, isDense: true),
                  hint: Text(
                    'Pilih Pegawai',
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
                  items: listNama
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
                      return 'Pilih Pegawai';
                    }
                  },
                  onChanged: (value) {
                    selectedValuePegawai = value.toString();
                  },
                  onSaved: (value) {
                    selectedValuePegawai = value.toString();
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Tempat Tujuan",
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
                    controller: tempatTujuanController,
                    cursorColor: Colors.black,
                    style: GoogleFonts.poppins(fontSize: 15),
                    decoration: InputDecoration(
                        hintText: "Tempat Tujuan",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey.shade700)),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Maksud Tujuan",
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
                    maxLines: 5,
                    controller: maksudTujuanController,
                    cursorColor: Colors.black,
                    style: GoogleFonts.poppins(fontSize: 15),
                    decoration: InputDecoration(
                        hintText: "Maksud Tujuan",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey.shade700)),
                  ),
                ),
                const SizedBox(height: 15),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Tanggal Berangkat",
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
                    controller: tanggalController,
                    onTap: () {
                      selectDate();
                    },
                    readOnly: true,
                    cursorColor: Colors.black,
                    style: GoogleFonts.poppins(fontSize: 15),
                    decoration: InputDecoration(
                        hintText: "Tanggal berangkat",
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
                      tambahSuratTugas();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SptPage(),
                          ),
                          (Route<dynamic> route) => false);
                    },
                    child: Text(
                      'Tambah SPT',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void getPegawai() async {
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var document in querySnapshot.docs) {
        setState(() {
          listNama.add(document['nama']);
        });
      }
    });
  }

  void getNoSurat() async {
    var snap = await FirebaseFirestore.instance
        .collection('spt')
        .orderBy('sendTime', descending: true)
        .limit(1)
        .get();

    String data = snap.docs[0]["no_spt"];
    data = data.substring(4, 7);
    int noSurat = int.parse(data);
    noSurat += 1;
    data = noSurat.toString().padLeft(3, '0');
    noSuratController.text = "870/$data-KIP/Diskominfo";
  }

  void tambahSuratTugas() async {
    try {
      await FirebaseFirestore.instance.collection('spt').add({
        'no_spt': noSuratController.text,
        'nama': selectedValuePegawai,
        'maksud_tujuan': maksudTujuanController.text,
        'tempat_tujuan': tempatTujuanController.text,
        'tanggal': selectedDate,
        'sendTime': DateTime.now(),
      });

      Fluttertoast.showToast(
          msg: "Data Berhasil Disimpan",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale(
          'id',
        ),
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        formattedDate = DateFormat(
          'EEEE, d MMM yyyy',
          'id',
        ).format(selectedDate);

        tanggalController.text = formattedDate.toString();
      });
    }
  }
}
