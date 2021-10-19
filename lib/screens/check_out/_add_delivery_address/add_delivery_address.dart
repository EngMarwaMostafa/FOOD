
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/check_out_provider.dart';
import 'package:food_app/screens/check_out/google_map/google_map.dart';
import 'package:food_app/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddDeliveryAddress extends StatefulWidget {

  @override
  _AddDeliveryAddressState createState() => _AddDeliveryAddressState();
}

enum AddressTypes
{
 Home,
 Work,
 Other,
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  var myType = AddressTypes.Home;
  @override
  Widget build(BuildContext context) {
    
    CheckOutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Add Delivery Address',
      style: TextStyle(),),
      ),
     bottomNavigationBar: Container(
       margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
       width: 160,
       height: 48,
       child: checkoutProvider.isLoading == false
           ? MaterialButton(
         onPressed: (){
           checkoutProvider.validator(context, myType);
         },
         child: Text(
         'Add Address',
         style:TextStyle(
           color: textColor,
         ),
         ),
         color: primaryColor,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(
           30,
         ),
       ),
       ):Center(
        child: CircularProgressIndicator(),
       ),
     ),
      body: Padding(
        padding:EdgeInsets.symmetric(
          horizontal: 20,
        ) ,
        child: ListView(
          children: [
            CustomTextField(
              labText: "First name",
              controller: null,
            ),
            CustomTextField(
              labText: "Last name",
             controller: checkoutProvider.lastName,
            ),
            CustomTextField(
              labText: "Mobile No",
              controller: checkoutProvider.mobileNo,
            ),
            CustomTextField(
              labText: "Alternate Mobile No",
             controller: checkoutProvider.alternateMobileNo,
            ),
            CustomTextField(
              labText: "Society",
             controller: checkoutProvider.society,
            ),
            CustomTextField(
              labText: "Street",
            controller: checkoutProvider.street,
            ),
            CustomTextField(
              labText: "Landmark",
             controller: checkoutProvider.landmark,
            ),
            CustomTextField(
              labText: "City",
              controller: checkoutProvider.city,
            ),
            CustomTextField(
              labText: "Area",
              controller: checkoutProvider.area,
            ),
            CustomTextField(
              labText: "PinCode",
             controller: checkoutProvider.pinCode,
            ),
            InkWell(
           onTap: (){},
           child: Container(
             height: 47,
             width: double.infinity,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 checkoutProvider.setLocation == null? Text('Set Location'):
             Text('Done!'),
               ],
             ),
           ),
            ),
            Divider(
              color:Colors.black ,
            ),
            ListTile(
              title: Text('Address Type*'),
            ),
            RadioListTile(
                value: AddressTypes.Home,
                groupValue: myType,
                title: Text('Home') ,
              onChanged: (AddressTypes? value){
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(Icons.home,
              size: 32,
              color: primaryColor,),
            ),
            RadioListTile(
              value: AddressTypes.Work,
              groupValue: myType,
              title: Text('Work') ,
              onChanged: (AddressTypes? value){
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(Icons.work,
                size: 32,
                color: primaryColor,),
            ),
            RadioListTile(
              value: AddressTypes.Other,
              groupValue: myType,
              title: Text('Other') ,
              onChanged: (AddressTypes? value){
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(Icons.devices_other,
                size: 32,
                color: primaryColor,),
            ),
          ],
        ),
      ),
    );
  }
}
