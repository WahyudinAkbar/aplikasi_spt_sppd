import 'package:aplikasi_kepegawaian/pages/anggaran/anggaran_page.dart';
import 'package:aplikasi_kepegawaian/pages/kuitansi/kuitansi_page.dart';
import 'package:aplikasi_kepegawaian/pages/nota_dinas/nota_dinas_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class EditKuitansiPage extends StatefulWidget {
  final String idKuitansi;
  final String noSppd;
  final int jumlahDana;
  final String perihal;

  const EditKuitansiPage({
    super.key,
    required this.idKuitansi,
    required this.noSppd,
    required this.jumlahDana,
    required this.perihal,
  });

  @override
  State<EditKuitansiPage> createState() => _EditKuitansiPageState();
}

class _EditKuitansiPageState extends State<EditKuitansiPage> {
  TextEditingController jumlahDanaController = TextEditingController();
  TextEditingController perihalController = TextEditingController();
  TextEditingController terbilangController = TextEditingController();

  List<String> listSppd = [];
  String? selectedValueSppd;

  @override
  void initState() {
    super.initState();
    getSppd();
    selectedValueSppd = widget.noSppd;
    jumlahDanaController.text = widget.jumlahDana.toString();
    perihalController.text = widget.perihal;
    terbilangController.text = terbilang(widget.jumlahDana);
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
                        "Update Kuitansi Perjalanan Dinas",
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
                        "Jumlah Dana",
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
                            if (value.isNotEmpty) {
                              terbilangController.text =
                                  terbilang(int.parse(value));
                            } else {
                              terbilangController.text = "";
                            }
                          },
                          controller: jumlahDanaController,
                          cursorColor: Colors.black,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          style: GoogleFonts.poppins(fontSize: 15),
                          decoration: InputDecoration(
                              hintText: "Jumlah Dana",
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Perihal Pembayaran",
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
                          controller: perihalController,
                          cursorColor: Colors.black,
                          style: GoogleFonts.poppins(fontSize: 15),
                          decoration: InputDecoration(
                              hintText: "Perihal Pembayaran",
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Terbilang",
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
                          controller: terbilangController,
                          cursorColor: Colors.black,
                          style: GoogleFonts.poppins(fontSize: 15),
                          decoration: InputDecoration(
                              hintText: "",
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
                        updateKuitansi();
                      }),
                ),
              ),
            ],
          ),
        ));
  }

  String penyebut(nominal) {
    var nilai = nominal.abs();
    List huruf = [
      "",
      "satu",
      "dua",
      "tiga",
      "empat",
      "lima",
      "enam",
      "tujuh",
      "delapan",
      "sembilan",
      "sepuluh",
      "sebelas"
    ];
    String temp = "";
    if (nilai < 12) {
      temp = "${huruf[nilai.toInt()]}";
    } else if (nilai < 20) {
      temp = "${penyebut(nilai - 10)} belas";
    } else if (nilai < 100) {
      temp = "${penyebut(nilai / 10)} puluh ${penyebut(nilai % 10)}";
    } else if (nilai < 200) {
      temp = "seratus ${penyebut(nilai - 100)}";
    } else if (nilai < 1000) {
      temp = "${penyebut(nilai / 100)} ratus ${penyebut(nilai % 100)}";
    } else if (nilai < 2000) {
      temp = "seribu ${penyebut(nilai - 1000)}";
    } else if (nilai < 1000000) {
      temp = "${penyebut(nilai / 1000)} ribu ${penyebut(nilai % 1000)}";
    } else if (nilai < 1000000000) {
      temp = "${penyebut(nilai / 1000000)} juta ${penyebut(nilai % 1000000)}";
    } else if (nilai < 1000000000000) {
      temp =
          "${penyebut(nilai / 1000000000)} milyar ${penyebut(nilai % 1000000000)}";
    } else if (nilai < 1000000000000000) {
      temp =
          "${penyebut(nilai / 1000000000000)} trilyun ${penyebut(nilai % 1000000000000)}";
    }
    return temp;
  }

  String terbilang(nilai) {
    String hasil = '';
    if (nilai < 0) {
      hasil = "minus ${penyebut(nilai).trim()}";
    } else {
      hasil = penyebut(nilai).trim();
    }

    return hasil.replaceAll(RegExp('\\s+'), ' ');
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
        .collection('kuitansi')
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

  void updateKuitansi() async {
    if (selectedValueSppd != "" &&
        jumlahDanaController.text.isNotEmpty &&
        perihalController.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('kuitansi')
            .doc(widget.idKuitansi)
            .update({
          'no_sppd': selectedValueSppd,
          'jumlah_dana': int.parse(jumlahDanaController.text),
          'perihal_pembayaran': perihalController.text,
        });

        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const KuitansiPage(),
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
