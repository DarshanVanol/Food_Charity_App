import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('UserData');
  final CollectionReference donatedFoodCollection =
      FirebaseFirestore.instance.collection('DonatedFood');

  Future updateUserData(
      String first, String last, String phone, String uid) async {
    Map<String, dynamic> userMap = new Map();
    userMap = {
      "first": first,
      "last": last,
      "phone": phone,
    };
    await userDataCollection.doc(uid).set(userMap);
  }

  Stream<QuerySnapshot> donateStatus(String uid, String filter) {
    if (filter == 'donated') {
      Query query = donatedFoodCollection
          .where('donatorId', isEqualTo: uid)
          .where('status', isEqualTo: 'Donated');
      return query.snapshots();
    } else if (filter == 'booked') {
      Query query = donatedFoodCollection
          .where('donatorId', isEqualTo: uid)
          .where('status', isEqualTo: 'Booked');
      return query.snapshots();
    } else if (filter == 'uploaded') {
      Query query = donatedFoodCollection
          .where('donatorId', isEqualTo: uid)
          .where('status', isEqualTo: 'Uploaded');
      return query.snapshots();
    } else {
      Query query = donatedFoodCollection.where('donatorId', isEqualTo: uid);
      return query.snapshots();
    }
  }

  Stream<QuerySnapshot> reciveFoodData(String city) {
    if (city.isEmpty) {
      return donatedFoodCollection.snapshots();
    } else {
      Query query = donatedFoodCollection.where('city', isEqualTo: city);
      return query.snapshots();
    }
  }

  Stream<QuerySnapshot> recieveFood() {
    Query query = donatedFoodCollection.where('status', isEqualTo: 'Uploaded');
    return query.snapshots();
  }

  Stream<QuerySnapshot> orderStatus(String recieverId) {
    Query query =
        donatedFoodCollection.where('reciever', isEqualTo: recieverId);
    return query.snapshots();
  }

  Future uploadFoodData(
      DateTime date,
      TimeOfDay time,
      String tittle,
      String name,
      bool isVeg,
      String quantity,
      String city,
      String address,
      String desc,
      String donatorId,
      String donator,
      String phone) async {
    Map<String, dynamic> foodMap = new Map();
    foodMap = {
      "status": 'Uploaded',
      "tittle": tittle,
      "date": date,
      "time": '${time.hour}:${time.minute}',
      "name": name,
      "isVeg": isVeg,
      "quantity": quantity,
      "city": city,
      "address": address,
      "desc": desc,
      "donatorId": donatorId,
      "donator": donator,
      "phone": phone,
      "reciever": ''
    };
    try {
      await donatedFoodCollection.add(foodMap);
    } catch (e) {
      print('error from database ===$e');
    }
  }
}
