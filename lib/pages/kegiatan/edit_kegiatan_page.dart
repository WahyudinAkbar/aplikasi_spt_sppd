import 'package:aplikasi_kepegawaian/pages/kegiatan/kegiatan_page.dart';
import 'package:aplikasi_kepegawaian/pages/pengeluaran/pengeluaran_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditKegiatanPage extends StatefulWidget {
  final String idKegiatan;
  final String noSppd;
  final List keterangan;
  final List kegiatan;
  final List tanggal;

  const EditKegiatanPage({
    super.key,
    required this.noSppd,
    required this.keterangan,
    required this.kegiatan,
    required this.idKegiatan,
    required this.tanggal,
  });

  @override
  State<EditKegiatanPage> createState() => _EditKegiatanPageState();
}

class _EditKegiatanPageState extends State<EditKegiatanPage> {
  String? selectedValueSppd;

  List<String> listSppd = [];

  List<TextEditingController> keteranganController = [];
  List<TextEditingController> tanggalController = [];
  List<TextEditingController> kegiatanController = [];

  List keterangan = [];
  List kegiatan = [];
  List tanggal = [];
  int total = 0;

  List selectedDate = [];
  String? formatedDate;

  void addController() {
    for (var i = 0; i < widget.keterangan.length; i++) {
      keteranganController.add(TextEditingController());
      tanggalController.add(TextEditingController());
      kegiatanController.add(TextEditingController());
      selectedDate.add(tanggal[i].toDate());
      print(tanggal[i]);
    }

    for (var i = 0; i < keterangan.length; i++) {
      print(selectedDate[i]);
      keteranganController[i].text = keterangan[i];
      tanggalController[i].text = DateFormat(
        'EEEE, d MMMM yyyy',
        'id',
      ).format(selectedDate[i]);
      kegiatanController[i].text = kegiatan[i];
    }
  }

  @override
  void initState() {
    super.initState();
    getSppd();
    selectedValueSppd = widget.noSppd;
    keterangan = widget.keterangan;
    kegiatan = widget.kegiatan;
    tanggal = widget.tanggal;
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
                        "Tambah Kegiatan",
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
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Kegiatan',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                        )),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 3),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffEBECF0),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: TextFormField(
                                        onTap: () {},
                                        controller: kegiatanController[i],
                                        cursorColor: Colors.black,
                                        style:
                                            GoogleFonts.poppins(fontSize: 15),
                                        decoration: InputDecoration(
                                            hintText: "Kegiatan",
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                                color: Colors.grey.shade700)),
                                      ),
                                    ),
                                  ]),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Tanggal',
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
                                              controller: tanggalController[i],
                                              onTap: () {
                                                selectDate(i);
                                              },
                                              readOnly: true,
                                              cursorColor: Colors.black,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15),
                                              decoration: InputDecoration(
                                                  hintText: "Tanggal",
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
                                kegiatanController.add(TextEditingController());
                                tanggalController.add(TextEditingController());
                                selectedDate.add(DateTime.now());
                              });
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
                                kegiatanController.removeLast();
                                tanggalController.removeLast();
                              });
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
                      child: const Text("Tambah Data"),
                      onPressed: () {
                        checkDataKegiatan();
                      }),
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> selectDate(int i) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        locale: const Locale(
          'id',
        ),
        initialDate: selectedDate[i],
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    void formatDate(selectedDate) {
      formatedDate = DateFormat(
        'EEEE, d MMM yyyy',
        'id',
      ).format(selectedDate);
    }

    if (picked != null) {
      setState(() {
        selectedDate[i] = picked;
        formatDate(selectedDate[i]);

        tanggalController[i].text = formatedDate.toString();
      });
    }
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
        .collection('kegiatan')
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

  checkDataKegiatan() {
    keterangan.clear();
    kegiatan.clear();
    tanggal.clear();
    for (var i = 0; i < keteranganController.length; i++) {
      if (keteranganController[i].text.isEmpty ||
          tanggalController[i].text.isEmpty ||
          kegiatanController[i].text.isEmpty) {
        Fluttertoast.showToast(
            msg: "Masih ada field yang belum diisi",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0);
        keterangan.clear();
        kegiatan.clear();
        tanggal.clear();

        break;
      } else {
        keterangan.add(keteranganController[i].text);
        kegiatan.add(kegiatanController[i].text);
        tanggal.add(selectedDate[i]);
      }
    }
    if (keterangan.isNotEmpty && kegiatan.isNotEmpty && tanggal.isNotEmpty) {
      updateKegiatan();
    }
  }

  void updateKegiatan() async {
    try {
      await FirebaseFirestore.instance
          .collection('kegiatan')
          .doc(widget.idKegiatan)
          .update({
        'no_sppd': selectedValueSppd,
        'keterangan': keterangan,
        'kegiatan': kegiatan,
        'tanggal': tanggal,
      });

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const KegiatanPage(),
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
