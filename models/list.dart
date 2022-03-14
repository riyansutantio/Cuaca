import 'package:flutter/material.dart';

class Cuaca {
  final int id;
  final String propinsi;
  final String kota;
  final String kecamatan;
  final int lat;
  final int lon;

  Cuaca(this.id, this.propinsi, this.kota, this.kecamatan, this.lat, this.lon);
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propinsi': propinsi,
      'kota': kota,
      'kecamatan': kecamatan,
      'lat': lat,
      'lon': lon,
    };
  }
}
