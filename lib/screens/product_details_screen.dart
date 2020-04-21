import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/product_details';

  @override
  Widget build(BuildContext context) {
  
   final productId = ModalRoute.of(context).settings.arguments as String;
   final itemProduct = Provider.of<Products>(context).findById(productId);
   final AppBar  appBar =  AppBar(
        title: Text(itemProduct.title),
      );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            height: (MediaQuery.of(context).size.height
                  -MediaQuery.of(context).padding.top
                  - appBar.preferredSize.height)*.5,
            width: double.infinity,
            child: Image.network(itemProduct.imageUrl,),
          ),
          Container(
            height: (MediaQuery.of(context).size.height
                  -MediaQuery.of(context).padding.top
                  - appBar.preferredSize.height)*.2,
            child: Text(
              '\$${itemProduct.price}', 
              style: TextStyle(
                color: Colors.grey, 
                fontSize: 20),
            ),
          ),
          Container(
            height: (MediaQuery.of(context).size.height
                  -MediaQuery.of(context).padding.top
                  - appBar.preferredSize.height)*.3,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              itemProduct.description, 
              textAlign: TextAlign.center, 
              softWrap: true,
              ),
            ),

        ],
        )
      ),
    );
  }
}