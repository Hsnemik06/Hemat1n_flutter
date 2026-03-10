import 'package:flutter/material.dart';

class DataController extends ChangeNotifier {

  // ===== DATA IOT =====
  double currentWatt = 576;
  double currentKwh = 62.5;
  int currentCost = 95000;

  int monthlyCost = 180000;

  double powerLimit = 800;
  bool deviceOn = true;

  bool overload = false;

  List<double> weeklyUsage = [
    2.1, 3.3, 4.0, 4.6, 5.8, 4.5, 4.2
  ];

  // ===== ROOM =====
  String selectedRoom = "Bedroom";

  void changeRoom(String room){
    selectedRoom = room;
    notifyListeners();
  }

  // ===== POWER LIMIT =====
  void changePowerLimit(double value){
    powerLimit = value;
    notifyListeners();
  }

  // ===== DEVICE CONTROL =====
  void toggleDevice(){
    deviceOn = !deviceOn;
    notifyListeners();
  }

  // ===== OVERLOAD CHECK =====
  void checkOverload(){
    if(currentWatt > powerLimit){
      overload = true;
    }else{
      overload = false;
    }

    notifyListeners();
  }


  // =================================================
  // NANTI DI SINI TEMPAT AMBIL DATA DARI FIREBASE
  // =================================================

  Future<void> fetchIoTData() async {

    // contoh nanti
    /*
    FirebaseFirestore.instance
        .collection('iot')
        .doc('power')
        .snapshots()
        .listen((data){

      currentWatt = data['watt'];
      currentKwh = data['kwh'];

      checkOverload();

      notifyListeners();
    });
    */

  }

}