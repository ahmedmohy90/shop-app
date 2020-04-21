import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';
import '../providers/cart_item.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart'),
      ),
      body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total: ', 
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 10,),
                    Chip(
                      label: Text(
                        '\$${cart.totalPrice}', 
                        style: TextStyle(
                          color: Theme.of(context).primaryTextTheme.title.color),
                          ), 
                      backgroundColor: Theme.of(context).primaryColor,
                      ),
                    FlatButton(
                      onPressed: (){
                        Provider.of<Order>(context).addOrder(
                          cart.totalPrice, 
                          cart.items.values.toList()
                          );
                        cart.clearCart();
                      }, 
                      child: Text(
                        'ORDER NOW', 
                        style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    )
                  ],
                ),
                ),
            ),
            SizedBox(width: 8,),
            Expanded(
              child: ListView.builder(
                itemCount: cart.totalItems(),
                itemBuilder: (ctx, index)=> ChangeNotifierProvider.value(
                  value: cart.items.values.toList()[index],
                  child: CartItems(
                    cart.items.keys.toList()[index]
                  ),)),
            ),
          ],
        ),
    );
  }
}