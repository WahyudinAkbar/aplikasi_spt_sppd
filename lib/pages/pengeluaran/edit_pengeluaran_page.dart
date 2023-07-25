import 'package:aplikasi_kepegawaian/pages/pengeluaran/pengeluaran_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPengeluaranPage extends StatefulWidget {
  final String idPengeluaran;
  final String noSppd;
  final List keterangan;
  final List jumlah;

  const EditPengeluaranPage({
    super.key,
    required this.noSppd,
    required this.keterangan,
    required this.jumlah,
    required this.idPengeluaran,
  });

  @override
  State<EditPengeluaranPage> createState() => _EditPengeluaranPageState();
}

class _EditPengeluaranPageState extends State<EditPengeluaranPage> {
  String? selectedValueSppd;

  List<String> listSppd = [];

  List<TextEditingController> keteranganController = [];

  List<TextEditingController> jumlahController = [];

  List keterangan = [];
  List jumlah = [];
  int total = 0;

  void addController() {
    for (var i = 0; i < widget.keterangan.length; i++) {
      keteranganController.add(TextEditingController());
      jumlahController.add(TextEditingController());
    }

    for (var i = 0; i < keterangan.length; i++) {
      keteranganController[i].text = keterangan[i];
      jumlahController[i].text = jumlah[i].toString();
      print(keteranganController[i]);
    }
  }

  @override
  void initState() {
    super.initState();
    getSppd();
    selectedValueSppd = widget.noSppd;
    keterangan = widget.keterangan;
    jumlah = widget.jumlah;
    addController();

    // for (var i = 0; i < keterangan.length; i++) {
    //   keteranganController[i] = keterangan[i];
    //   jumlahController[i] = jumlah[i];
    // }
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
                        "Edit Pengeluaran",
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
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children:
                            List.generate(keteranganController.length, (i) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Keterangan',
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                              )),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            padding: const EdgeInsets.only(
                                                left: 15, top: 3),
                                            decoration: BoxDecoration(
                                                color: const Color(0xffEBECF0),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: TextFormField(
                                              onTap: () {},
                                              controller:
                                                  keteranganController[i],
                                              cursorColor: Colors.black,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15),
                                              decoration: InputDecoration(
                                                  hintText: "Keterangan",
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      color: Colors
                                                          .grey.shade700)),
                                            ),
                                          ),
                                        ]),
                                  ),
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Jumlah',
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                              )),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            padding: const EdgeInsets.only(
                                                left: 15, top: 3),
                                            decoration: BoxDecoration(
                                                color: const Color(0xffEBECF0),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: TextFormField(
                                              onTap: () {},
                                              controller: jumlahController[i],
                                              cursorColor: Colors.black,
                                              inputFormatters: [
                                                FilteringTextInputFormatter
                                                    .digitsOnly
                                              ],
                                              keyboardType:
                                                  TextInputType.number,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15),
                                              decoration: InputDecoration(
                                                  hintText: "Jumlah",
                                                  border: InputBorder.none,
                                                  hintStyle: TextStyle(
                                                      color: Colors
                                                          .grey.shade700)),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              )
                            ],
                          );
                        }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                keteranganController
                                    .add(TextEditingController());
                                jumlahController.add(TextEditingController());
                              });
                              ;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.grey.shade400),
                              child: const Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                keteranganController.removeLast();
                                jumlahController.removeLast();
                              });
                              ;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.grey.shade400),
                              child: const Icon(
                                Icons.remove,
                                size: 30,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      )
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
                        checkDataPengeluaran();
                      }),
                ),
              ),
            ],
          ),
        ));
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
        .collection('pengeluaran')
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

  checkDataPengeluaran() {
    keterangan.clear();
    jumlah.clear();
    for (var i = 0; i < keteranganController.length; i++) {
      if (keteranganController[i].text.isEmpty ||
          jumlahController[i].text.isEmpty) {
        Fluttertoast.showToast(
            msg: "Masih ada field yang belum diisi",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        keterangan.clear();
        jumlah.clear();
        total = 0;
        break;
      } else {
        keterangan.add(keteranganController[i].text);
        jumlah.add(int.parse(jumlahController[i].text));
        total = total + int.parse(jumlahController[i].text);
        print(total);
      }
    }
    if (keterangan.isNotEmpty && jumlah.isNotEmpty) {
      updatePengeluaran();
    }
  }

  void updatePengeluaran() async {
    try {
      await FirebaseFirestore.instance
          .collection('pengeluaran')
          .doc(widget.idPengeluaran)
          .update({
        'no_sppd': selectedValueSppd,
        'keterangan': keterangan,
        'jumlah': jumlah,
        'total': total,
      });

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const PengeluaranPage(),
          ),
          (Route<dynamic> route) => false);

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
}
