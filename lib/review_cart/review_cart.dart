import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/models/review_cart_model.dart';
import 'package:food_app/providers/review_cart_provider.dart';
import 'package:food_app/screens/check_out/_delivery_details/delivery_details.dart';
import 'package:food_app/widgets/single_item.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatelessWidget {
  ReviewCartProvider? reviewCartProvider;
  showAlertDialog(BuildContext context, ReviewCartModel delete) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        reviewCartProvider!.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you delete on cartProduct?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: Text('Total Amount'),
        subtitle: Text(
          '\$ ${reviewCartProvider.getTotalPrice()}',
          style: TextStyle(
            color: Colors.green[900],
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            child: Text('Submit'),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>DeliveryDetails(),
                ),
              );
            },
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Review Cart',
        style: TextStyle(
          color: textColor,
          fontSize: 18,
        ),),
      ),
      body: reviewCartProvider.getReviewDataList.isEmpty?Center(
        child: Text('NO DATA'),
      ): ListView.builder(
        itemCount: reviewCartProvider.getReviewDataList.length,
        itemBuilder: (context,index){
          ReviewCartModel data = reviewCartProvider.getReviewDataList[index];
    return Column(
    children: [
    SizedBox(
    height: 10,
    ),
    SingleItem(
     wishList: false,
    isBool: true,
    productName: data.cartName,
    productImage:data.cartImage,
    productPrice:data.cartPrice,
      productQuantity: data.cartQuantity,
      productId: data.cartId,
      onDelete: (){
      showAlertDialog(context, data);
      }, productUnit: null,
    ),
    ],
    );
    },
      ),
    );
  }
}
