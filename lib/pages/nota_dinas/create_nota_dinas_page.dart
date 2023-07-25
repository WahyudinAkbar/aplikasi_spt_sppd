import 'dart:io';
import 'dart:math';

import 'package:aplikasi_kepegawaian/pages/nota_dinas/nota_dinas_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CreateNotaDinasPage extends StatefulWidget {
  const CreateNotaDinasPage({super.key});

  @override
  State<CreateNotaDinasPage> createState() => _CreateNotaDinasPageState();
}

class _CreateNotaDinasPageState extends State<CreateNotaDinasPage> {
  TextEditingController noSuratController = TextEditingController();
  TextEditingController tempatTujuanController = TextEditingController();
  TextEditingController maksudTujuanController = TextEditingController();
  TextEditingController perihalController = TextEditingController();
  TextEditingController tanggalBerangkatController = TextEditingController();
  TextEditingController tanggalKembaliController = TextEditingController();

  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  String? formattedDate;
  String? selectedValuePegawai;

  List<String> listNama = [];

  String? nameImage;
  File? image;
  final picker = ImagePicker();

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
                        "Tambah Nota Dinas",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
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
                          return value.toString();
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
                        "Perihal",
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
                          maxLines: 3,
                          controller: perihalController,
                          cursorColor: Colors.black,
                          style: GoogleFonts.poppins(fontSize: 15),
                          decoration: InputDecoration(
                              hintText: "Perihal",
                              border: InputBorder.none,
                              hintStyle:
                                  TextStyle(color: Colors.grey.shade700)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Dasar Surat (Optional)",
                        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: image == null
                                ? GestureDetector(
                                    onTap: () {
                                      getImage();
                                    },
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      color: Colors.blue,
                                      radius: const Radius.circular(8),
                                      dashPattern: [7],
                                      child: const SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: Center(
                                            child: Text(
                                          '+ Tambah Foto',
                                          style: TextStyle(color: Colors.blue),
                                        )),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 150,
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, right: 10),
                                          child: Image.file(
                                            image!,
                                            width: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  color: Colors.white),
                                              child: const Icon(
                                                Icons.circle,
                                                color: Colors.white,
                                              ),
                                            )),
                                        Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  image = null;
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: Colors.grey.shade600,
                                                ),
                                              ),
                                            )),
                                      ],
                                    )),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     if (image != null) {
                          //       return uploadImage(image);
                          //     }
                          //   },
                          //   child: Icon(Icons.upload),
                          // )
                        ],
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
                            selectDate(tanggalKembaliController, false);
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
                        tambahSuratTugas();
                      }),
                ),
              ),
            ],
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
    print(listNama);
  }

  void getNoSurat() async {
    var snap = await FirebaseFirestore.instance
        .collection('nota_dinas')
        .orderBy('send_time', descending: true)
        .limit(1)
        .get();

    if (snap.docs.isNotEmpty) {
      String data = snap.docs[0]["no_surat"];
      data = data.substring(4, 7);
      int noSurat = int.parse(data);
      noSurat += 1;
      data = noSurat.toString().padLeft(3, '0');
      noSuratController.text = "090/$data-ND/Diskominfo";
    } else {
      setState(() {
        noSuratController.text = "090/001-ND/Diskominfo";
      });
    }
  }

  void getNameImage() {
    var random = Random();
    var rand = random.nextInt(1000000000);
    setState(() {
      nameImage = "dasar-surat-$rand";
    });
  }

  uploadImage(img) async {
    await Firebase.initializeApp();

    try {
      await FirebaseStorage.instance.ref('$nameImage.jpg').putFile(img);
      print("Uploaded image");
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  getImage() async {
    // You can also change the source to gallery like this: "source: ImageSource.camera"
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        getNameImage();
        print(nameImage);
      } else {
        print('No image has been selected.');
      }
    });
  }

  void tambahSuratTugas() async {
    if (noSuratController.text.isNotEmpty &&
        selectedValuePegawai != "" &&
        tempatTujuanController.text.isNotEmpty &&
        maksudTujuanController.text.isNotEmpty &&
        perihalController.text.isNotEmpty &&
        tanggalBerangkatController.text.isNotEmpty &&
        tanggalKembaliController.text.isNotEmpty) {
      try {
        if (image != null) {
          uploadImage(image);
        }
        await FirebaseFirestore.instance.collection('nota_dinas').add({
          'no_surat': noSuratController.text,
          'nama': selectedValuePegawai,
          'maksud_tujuan': maksudTujuanController.text,
          'tempat_tujuan': tempatTujuanController.text,
          'perihal': perihalController.text,
          'dasar': image == null ? "" : '$nameImage.jpg',
          'tanggal_berangkat': selectedDate1,
          'tanggal_kembali': selectedDate2,
          'verifikasi': false,
          'userId': FirebaseAuth.instance.currentUser?.uid,
          'send_time': DateTime.now(),
        });

        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => NotaDinasPage(),
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
