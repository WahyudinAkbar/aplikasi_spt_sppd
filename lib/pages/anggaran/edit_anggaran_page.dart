import 'package:aplikasi_kepegawaian/pages/anggaran/anggaran_page.dart';
import 'package:aplikasi_kepegawaian/pages/nota_dinas/nota_dinas_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class EditAnggaranPage extends StatefulWidget {
  final String idAnggaran;
  final String noSppd;
  final int uangHarian;
  final int uangTransportasi;
  final int uangPenginapan;
  final int total;

  const EditAnggaranPage(
      {super.key,
      required this.idAnggaran,
      required this.noSppd,
      required this.uangHarian,
      required this.uangTransportasi,
      required this.uangPenginapan,
      required this.total});

  @override
  State<EditAnggaranPage> createState() => _EditAnggaranPageState();
}

class _EditAnggaranPageState extends State<EditAnggaranPage> {
  TextEditingController uangHarianController = TextEditingController();
  TextEditingController biayaTransportasiController = TextEditingController();
  TextEditingController biayaPenginapanController = TextEditingController();
  TextEditingController totalController = TextEditingController();

  List<String> listSppd = [];
  String? selectedValueSppd;
  List i = [for (var j = 0; j < 3; j++) 0];

  @override
  void initState() {
    super.initState();
    getSppd();
    selectedValueSppd = widget.noSppd;
    uangHarianController.text = widget.uangHarian.toString();
    biayaTransportasiController.text = widget.uangTransportasi.toString();
    biayaPenginapanController.text = widget.uangPenginapan.toString();
    totalController.text = widget.total.toString();
    i[0] = widget.uangHarian;
    i[1] = widget.uangTransportasi;
    i[2] = widget.uangPenginapan;
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
                        "Update Anggaran Perjalanan Dinas",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "No Sppd",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                      DropdownButtonFormField2(
                        value: selectedValueSppd,
                        buttonDecoration: BoxDecoration(
                          color: const Color(0xffEBECF0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        decoration: const InputDecoration(
                            border: InputBorder.none, isDense: true),
                        hint: Text(
                          'Pilih Sppd',
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
                        items: listSppd
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
                            return 'Pilih Sppd';
                          }
                          return value.toString();
                        },
                        onChanged: (value) {
                          selectedValueSppd = value.toString();
                        },
                        onSaved: (value) {
                          selectedValueSppd = value.toString();
                        },
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Uang Harian",
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
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                i[0] = 0;
                              } else {
                                i[0] = int.parse(value);
                              }
                              countTotal();
                            });
                          },
                          controller: uangHarianController,
                          cursorColor: Colors.black,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.poppins(fontSize: 15),
                          decoration: InputDecoration(
                              hintText: "Uang Harian",
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Biaya Transportasi",
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
                          onChanged: (value) {
                            if (value.isEmpty) {
                              i[1] = 0;
                            } else {
                              i[1] = int.parse(value);
                            }
                            countTotal();
                          },
                          controller: biayaTransportasiController,
                          cursorColor: Colors.black,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.poppins(fontSize: 15),
                          decoration: InputDecoration(
                              hintText: "Biaya Transportasi",
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Biaya Penginapan",
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
                          onChanged: (value) {
                            if (value.isEmpty) {
                              i[2] = 0;
                            } else {
                              i[2] = int.parse(value);
                            }
                            countTotal();
                          },
                          controller: biayaPenginapanController,
                          cursorColor: Colors.black,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.poppins(fontSize: 15),
                          decoration: InputDecoration(
                              hintText: "Biaya Penginapan",
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Total",
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
                          readOnly: true,
                          controller: totalController,
                          cursorColor: Colors.black,
                          style: GoogleFonts.poppins(fontSize: 15),
                          decoration: InputDecoration(
                              hintText: "0",
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
                        updateAnggaran();
                      }),
                ),
              ),
            ],
          ),
        ));
  }

  void countTotal() {
    setState(() {
      int total = i[0] + i[1] + i[2];

      totalController.text = total.toString();
    });
  }

  void getSppd() async {
    await FirebaseFirestore.instance
        .collection('sppd')
        .orderBy('no_sppd', descending: false)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var document in querySnapshot.docs) {
        setState(() {
          listSppd.add(document['no_sppd']);
        });
      }
    });
    checkSppd();
  }

  void checkSppd() async {
    await FirebaseFirestore.instance
        .collection('anggaran')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var document in querySnapshot.docs) {
        setState(() {
          for (var i = 0; i < listSppd.length; i++) {
            if (document['no_sppd'] == listSppd[i] &&
                document['no_sppd'] != widget.noSppd) {
              listSppd.remove(document['no_sppd']);
            }
          }
        });
      }
    });
  }

  void updateAnggaran() async {
    if (selectedValueSppd != "" &&
        uangHarianController.text.isNotEmpty &&
        biayaPenginapanController.text.isNotEmpty &&
        biayaTransportasiController.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('anggaran')
            .doc(widget.idAnggaran)
            .update({
          'no_sppd': selectedValueSppd,
          'uang_harian': int.parse(uangHarianController.text),
          'biaya_transportasi': int.parse(biayaTransportasiController.text),
          'biaya_penginapan': int.parse(biayaPenginapanController.text),
          'total': int.parse(totalController.text),
        });

        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const AnggaranPage(),
            ),
            (Route<dynamic> route) => false);

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
    } else {
      Fluttertoast.showToast(
          msg: "Ada field yang belum diisi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
