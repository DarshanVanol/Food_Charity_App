import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('UserData');
  final CollectionReference donatedFoodCollection =
      FirebaseFirestore.instance.collection('DonatedFood');

  Future updateUserData(String first, String last, String phone, String uid,
      String? email) async {
    Map<String, dynamic> userMap = new Map();
    userMap = {
      "first": first,
      "last": last,
      "phone": phone,
      "isAdmin": false,
      "email": email
    };
    await userDataCollection.doc(uid).set(userMap);
  }

  checkIsAdmin(String uid) async {
    DocumentSnapshot snapshot = await userDataCollection.doc(uid).get();
    return snapshot.get('isAdmin');
  }

  Stream<QuerySnapshot> donateStatus(String uid, String filter) {
    if (filter == 'donated') {
      Query query = donatedFoodCollection
          .where('donatorId', isEqualTo: uid)
          .where('status', isEqualTo: 'Donated');
      return query.snapshots();
    } else if (filter == 'accepted') {
      Query query = donatedFoodCollection
          .where('donatorId', isEqualTo: uid)
          .where('status', isEqualTo: 'Accepted');
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
      return donatedFoodCollection
          .where('status', isEqualTo: 'Uploaded')
          .snapshots();
    } else {
      Query query = donatedFoodCollection.where('city', isEqualTo: city);
      return query.where('status', isEqualTo: 'Uploaded').snapshots();
    }
  }

  Stream<QuerySnapshot> recieveFood() {
    Query query = donatedFoodCollection.where('status', isEqualTo: 'Uploaded');
    return query.snapshots();
  }

  Stream<QuerySnapshot> orderStatus(String recieverId) {
    Query query =
        donatedFoodCollection.where('recieverId', isEqualTo: recieverId);
    return query.snapshots();
  }

  Future uploadFoodData(
      String url,
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
      GeoPoint? gp,
      String donator,
      String phone,
      bool isDirection) async {
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
      "reciever": '',
      "url": url,
      "geoPoint": gp,
      "isDirection": isDirection
    };
    try {
      await donatedFoodCollection.add(foodMap);
    } catch (e) {
      print('error from database ===$e');
    }
  }
}
