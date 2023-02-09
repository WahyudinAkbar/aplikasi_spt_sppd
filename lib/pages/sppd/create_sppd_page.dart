import 'package:aplikasi_kepegawaian/pages/sppd/sppd_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CreateSppdPage extends StatefulWidget {
  const CreateSppdPage({super.key});

  @override
  State<CreateSppdPage> createState() => _CreateSppdPageState();
}

class _CreateSppdPageState extends State<CreateSppdPage> {
  TextEditingController noSuratController = TextEditingController();
  TextEditingController tempatTujuanController = TextEditingController();
  TextEditingController maksudTujuanController = TextEditingController();
  TextEditingController tanggalBerangkatController = TextEditingController();
  TextEditingController tanggalKembaliController = TextEditingController();
  TextEditingController transportasiController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();

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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Tambah Surat Perintah Perjalanan Dinas",
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
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)),
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
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)),
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
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)),
                        ),
                      ),
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
                          controller: tanggalBerangkatController,
                          onTap: () {
                            selectDate(tanggalBerangkatController, true);
                          },
                          readOnly: true,
                          cursorColor: Colors.black,
                          style: GoogleFonts.poppins(fontSize: 15),
                          decoration: InputDecoration(
                              hintText: "Tanggal berangkat",
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Tanggal Kembali",
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
                          controller: tanggalKembaliController,
                          onTap: () {
                            setState(() {
                              selectDate(tanggalKembaliController, false);
                            });
                          },
                          readOnly: true,
                          cursorColor: Colors.black,
                          style: GoogleFonts.poppins(fontSize: 15),
                          decoration: InputDecoration(
                              hintText: "Tanggal Kembali",
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Alat Transportasi",
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
                          controller: transportasiController,
                          cursorColor: Colors.black,
                          style: GoogleFonts.poppins(fontSize: 15),
                          decoration: InputDecoration(
                              hintText: "Alat Transportasi",
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Keterangan Lain-lain",
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
                          controller: keteranganController,
                          cursorColor: Colors.black,
                          style: GoogleFonts.poppins(fontSize: 15),
                          decoration: InputDecoration(
                              hintText: "Keterangan Lain lain",
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: const Border(top: BorderSide(color: Colors.grey)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(0, -1),
                          blurRadius: 3,
                          spreadRadius: 1)
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                      child: const Text("Tambah Data"),
                      onPressed: () {
                        tambahSppd();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SppdPage(),
                            ),
                            (Route<dynamic> route) => false);
                      }),
                ),
              ),
            ],
          ),
        ));
  }

  Future getPegawai() async {
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

  Future getNoSurat() async {
    var snap = await FirebaseFirestore.instance
        .collection('sppd')
        .orderBy('send_time', descending: true)
        .limit(1)
        .get();

    String data = snap.docs[0]["no_sppd"];
    data = data.substring(4, 7);
    int noSurat = int.parse(data);
    noSurat += 1;
    data = noSurat.toString().padLeft(3, '0');
    noSuratController.text = "090/$data-LD/DisKominfo";
  }

  void tambahSppd() async {
    try {
      await FirebaseFirestore.instance.collection('sppd').add({
        'no_sppd': noSuratController.text,
        'nama': selectedValuePegawai,
        'maksud_tujuan': maksudTujuanController.text,
        'tempat_tujuan': tempatTujuanController.text,
        'tanggal_berangkat': selectedDate1,
        'tanggal_kembali': selectedDate2,
        'alat_transportasi': transportasiController.text,
        'keterangan_lain':
            keteranganController.text.isEmpty ? "" : keteranganController.text,
        'send_time': DateTime.now(),
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

  Future<void> selectDate(
      TextEditingController controller, bool isBerangkat) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale(
          'id',
        ),
        initialDate: isBerangkat ? selectedDate1 : selectedDate2,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    void formatDate(selectedDate) {
      formattedDate = DateFormat(
        'EEEE, d MMM yyyy',
        'id',
      ).format(selectedDate);
    }

    if (picked != null) {
      setState(() {
        if (isBerangkat) {
          selectedDate1 = picked;
          formatDate(selectedDate1);
        } else {
          selectedDate2 = picked;
          formatDate(selectedDate2);
        }

        controller.text = formattedDate.toString();
      });
    }
  }
}
