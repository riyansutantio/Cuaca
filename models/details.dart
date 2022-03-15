class Details {
  final String jamcuaca;
  final String kodecuaca;
  final String cuaca;
  final int humidity;
  final int tempc;
  final int tempf;

  Details(this.jamcuaca, this.kodecuaca, this.cuaca, this.humidity, this.tempc,
      this.tempf);
  Map<String, dynamic> toJson() {
    return {
      'jamCuaca': jamcuaca,
      'kodeCuaca': kodecuaca,
      'cuaca': cuaca,
      'humidity': humidity,
      'tempC': tempc,
      'tempF': tempf,
    };
  }
}
