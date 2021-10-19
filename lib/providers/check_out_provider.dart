import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/models/delivery_address_model.dart';
import 'package:location/location.dart';

class CheckOutProvider with ChangeNotifier{

  bool isLoading = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController alternateMobileNo = TextEditingController();
  TextEditingController society = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  LocationData?  setLocation ;


  void validator(context,myType) async {
    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "firstName is empty");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "lastName is empty");
    } else if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "mobileNo is empty");
    } else if (alternateMobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "alternateMobileNo is empty");
    } else if (society.text.isEmpty) {
      Fluttertoast.showToast(msg: "society is empty");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "street is empty");
    } else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: "landmark is empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "city is empty");
    } else if (area.text.isEmpty) {
      Fluttertoast.showToast(msg: "area is empty");
    } else if (pinCode.text.isEmpty) {
      Fluttertoast.showToast(msg: "pinCode is empty");

    } else if (setLocation==null) {
      Fluttertoast.showToast(msg: "setLocation is empty");

  }else{
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance.collection('AddDeliveryAddress').
      doc(FirebaseAuth.instance.currentUser!.uid).
        set({
    "firstName": firstName.text,
    "lastName": lastName.text,
    "mobileNo": mobileNo.text,
    "alternateMobileNo": alternateMobileNo.text,
    "society": society.text,
    "street": street.text,
    "landmark": landmark.text,
    "city": city.text,
    "area": area.text,
    "pinCode": pinCode.text,
    "addressType":myType.toString(),
    "longitude":setLocation!.longitude,
    "latitude":setLocation!.latitude,
    }).then((value) async {
        isLoading = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your deliver address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
       }
    }
   List<DeliveryAddressModel> deliveryAddressList = [];
    void getDeliveryAddressData()async {
      List<DeliveryAddressModel> newList = [];
    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db =
      await FirebaseFirestore.instance.
      collection('AddDeliveryAddress').
      doc(FirebaseAuth.instance.currentUser!.uid).
      get();
      if(_db.exists){
        deliveryAddressModel = DeliveryAddressModel(
          firstName:_db.get('firstName'),
          lastName:_db.get('lastName'),
          mobileNo:_db.get('mobileNo'),
          city:_db.get('city'),
          area:_db.get('area'),
          alternateMobileNo:_db.get('alternateMobileNo'),
          society:_db.get('society'),
          street:_db.get('street'),
          landMark:_db.get('landmark'),
          pinCode:_db.get('pinCode'),
         addressType:_db.get('addressType'),
        );
        newList.add(deliveryAddressModel);
        notifyListeners();
      }
    }
}
