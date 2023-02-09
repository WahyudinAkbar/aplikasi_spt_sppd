import 'package:aplikasi_kepegawaian/pages/sppd/sppd_page.dart';
import 'package:aplikasi_kepegawaian/pages/spt/spt_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditSppdPage extends StatefulWidget {
  final String idSuratTugas;
  final String noSurat;
  final String pegawai;
  final String tempatTujuan;
  final String maksudTujuan;
  final DateTime tanggalBerangkat;
  final DateTime tanggalKembali;
  final String transportasi;
  final String keterangan;

  const EditSppdPage({
    super.key,
    required this.idSuratTugas,
    required this.noSurat,
    required this.pegawai,
    required this.tempatTujuan,
    required this.maksudTujuan,
    required this.tanggalBerangkat,
    required this.tanggalKembali,
    required this.transportasi,
    required this.keterangan,
  });

  @override
  State<EditSppdPage> createState() => _EditSppdPageState();
}

class _EditSppdPageState extends State<EditSppdPage> {
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

  String formatDate(selectedDate) {
    return DateFormat(
      'EEEE, d MMMM yyyy',
      'id',
    ).format(selectedDate);
  }

  @override
  void initState() {
    super.initState();

    noSuratController.text = widget.noSurat;
    selectedValuePegawai = widget.pegawai;
    tempatTujuanController.text = widget.tempatTujuan;
    maksudTujuanController.text = widget.maksudTujuan;
    selectedDate1 = widget.tanggalBerangkat;
    selectedDate2 = widget.tanggalKembali;
    tanggalBerangkatController.text = formatDate(selectedDate1);
    tanggalKembaliController.text = formatDate(selectedDate2);
    transportasiController.text = widget.transportasi;
    keteranganController.text = widget.keterangan;

    getPegawai();
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
                        "Edit Surat Perintah Perjalanan Dinas",
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
                      child: const Text("Simpan"),
                      onPressed: () {
                        updateSuratTugas();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SppdPage(),
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

  Future updateSuratTugas() async {
    try {
      await FirebaseFirestore.instance
          .collection('sppd')
          .doc(widget.idSuratTugas)
          .update({
        'no_sppd': noSuratController.text,
        'nama': selectedValuePegawai,
        'maksud_tujuan': maksudTujuanController.text,
        'tempat_tujuan': tempatTujuanController.text,
        'tanggal_berangkat': selectedDate1,
        'tanggal_kembali': selectedDate2,
        'alat_transportasi': transportasiController.text,
        'keterangan_lain':
            keteranganController.text.isEmpty ? "" : keteranganController.text,
      });

      Fluttertoast.showToast(
          msg: "Data Berhasil Diubah",
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
