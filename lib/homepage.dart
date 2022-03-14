import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? wilayah;
  final String _baseUrl =
      "https://ibnux.github.io/BMKG-importer/cuaca/wilayah.json";
  List<dynamic> _dataProvince = [];
  List<dynamic> _detailProvince = [];
  String? _valProvince;

  Future<void> getProvince() async {
    final respose = await http
        .get(Uri.parse(_baseUrl), headers: {"Accept": "application/json"});
    var listData = jsonDecode(respose.body);
    //print("data : $listData");
    setState(() {
      _dataProvince = listData;
    });
  }

  // Future<void> getDetail() async {
  //   String uri = "https://ibnux.github.io/BMKG-importer/cuaca/$wilayah.json";
  //   final respose =
  //       await http.get(Uri.parse(uri), headers: {"Accept": "application/json"});
  //   var listData = jsonDecode(jsonEncode(respose.body));
  //   print("data : $listData");
  //   setState(() {
  //     _detailProvince = listData;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // getDetail();
    getProvince();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff695BFC), Color(0xffffffff)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "Daerah",
                    style: GoogleFonts.roboto(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  DropdownButton(
                    hint: const Text("Select Province"),
                    dropdownColor: Colors.black12,
                    value: _valProvince,
                    items: _dataProvince.map((item) {
                      return DropdownMenuItem(
                        child: Text(
                          item['propinsi'] + " - " + item['kota'],
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        value: item['id'],
                      );
                    }).toList(),
                    onChanged: (val) => setState(() {
                      _valProvince = val as String;
                    }),
                  ),
                  //Text(_valProvince.toString()),
                  Container(
                    padding: const EdgeInsets.fromLTRB(25, 20, 0, 0),
                    child: Text(
                      "27°",
                      style: GoogleFonts.roboto(
                          fontSize: 100, color: Colors.white),
                    ),
                  ),
                  Text(
                    "Senin, 14 Maret 13:40",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      "Cerah Berawan",
                      style: GoogleFonts.roboto(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Image(
                    image: AssetImage(
                        "assets/images/Status-weather-clear-icon.png"),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Card(
                      color: Colors.white,
                      child: Column(
                        children: [Row()],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
