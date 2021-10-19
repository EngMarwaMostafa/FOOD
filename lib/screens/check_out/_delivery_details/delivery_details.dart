import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/check_out_provider.dart';
import 'package:food_app/screens/check_out/_add_delivery_address/add_delivery_address.dart';
import 'package:food_app/screens/check_out/_delivery_details/single_delivery_item.dart';
import 'package:food_app/screens/check_out/_payment_summary/payment_summary.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatelessWidget {
  List<Widget> address = [
    SingleDeliveryItem(
      address:
      "area, Cairo/Egypt, street,10, society 07, pincode 8000",
      title: "Flutter Developer",
      number: "01111111111",
      addressType: "Home",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    CheckOutProvider deliveryAddressProvider = Provider.of(context);
    var deliveryAddressModel =
        deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Details"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
        },
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          child: address.isEmpty
              ? Text("Add new Address")
              : Text("Payment Summary"),
          onPressed: () {
           Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddDeliveryAddress(),
              ),
            );
          },
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Deliver To"),

          ),
          Divider(
            height: 1,
          ),
          Column(
            children: [
              address.isEmpty?
              Container()
                 :SingleDeliveryItem(
          address: 'cairo',
          title: 'Flutter Developer',
          addressType: 'Home',
          number:'011111111111',
              ),
            ],
          )
        ],
      ),
    );
  }
}