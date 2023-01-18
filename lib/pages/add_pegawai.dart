import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class AddPegawai extends StatefulWidget {
  const AddPegawai({super.key});

  @override
  State<AddPegawai> createState() => _AddPegawaiState();
}

class _AddPegawaiState extends State<AddPegawai> {
  TextEditingController namaController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  TextEditingController waktuController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String? formattedDate;
  String? selectedValuePegawai;

  List<String> listNama = [];

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

  @override
  void initState() {
    super.initState();

    getPegawai();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference tugas = firestore.collection('tugas');

    return Scaffold(
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
                controller: namaController,
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
                  return 'Pilih Bidang';
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
                controller: keteranganController,
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
                controller: keteranganController,
                cursorColor: Colors.black,
                style: GoogleFonts.poppins(fontSize: 15),
                decoration: InputDecoration(
                    hintText: "Maksud Tujuan",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.shade700)),
              ),
            ),
            const SizedBox(height: 15),

            // DropdownButtonFormField2(
            //   value: selectedValueBidang,
            //   buttonDecoration: BoxDecoration(
            //     color: const Color(0xffEBECF0),
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   decoration: const InputDecoration(
            //       border: InputBorder.none, isDense: true),
            //   hint: Text(
            //     'Pilih Bidang',
            //     style: GoogleFonts.poppins(fontSize: 15),
            //   ),
            //   icon: const Icon(
            //     Icons.arrow_drop_down,
            //     color: Colors.black45,
            //   ),
            //   iconSize: 30,
            //   buttonHeight: 50,
            //   dropdownDecoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //   ),
            //   items: listBidang
            //       .map((item) => DropdownMenuItem<String>(
            //             value: item,
            //             child: Text(
            //               item,
            //               style: GoogleFonts.poppins(
            //                 fontSize: 15,
            //               ),
            //             ),
            //           ))
            //       .toList(),
            //   validator: (value) {
            //     if (value == null) {
            //       return 'Pilih Bidang';
            //     }
            //   },
            //   onChanged: (value) {
            //     selectedValueBidang = value.toString();

            //     setState(() {
            //       getPegawai();
            //     });
            //   },
            //   onSaved: (value) {
            //     selectedValueBidang = value.toString();
            //     print(value);
            //   },
            // ),

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
                controller: tanggalController,
                onTap: () {
                  selectDate();
                },
                readOnly: true,
                cursorColor: Colors.black,
                style: GoogleFonts.poppins(fontSize: 15),
                decoration: InputDecoration(
                    hintText: "Tanggal Kembali",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.shade700)),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: size.width,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  try {
                    tugas.add({
                      'nama_tugas': namaController.text,
                      'keterangan': keteranganController.text.isEmpty
                          ? ''
                          : keteranganController.text,
                      'pegawai': selectedValuePegawai,
                      'tanggal': tanggalController.text,
                      'batas_waktu': waktuController.text,
                    });
                  } catch (e) {
                    print(e);
                  }

                  print(selectedValuePegawai);
                  print(tanggalController);
                  print(waktuController);
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
}
