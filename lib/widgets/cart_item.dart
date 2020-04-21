import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_item.dart';

class CartItems extends StatelessWidget {
  final String productId;

  CartItems(this.productId);
  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<CartItem>(context);    
    return Dismissible(
        key: ValueKey(cartItem.id),
        background: Container(
          child: Icon(Icons.delete,),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          color : Theme.of(context).errorColor,),
        direction: DismissDirection.endToStart,   
        confirmDismiss: (direction){
          return showDialog(
            context: context,
            builder: (ctx)=>AlertDialog(
                  title: Text('Are You Sure?!'), 
                  content: Text('Do you want to remove this item from Cart?!'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: ()=>Navigator.of(ctx).pop(false), 
                      child: Text('No'),
                      ),
                    FlatButton(
                      onPressed: ()=>Navigator.of(ctx).pop(true),
                       child: Text('Yes'),
                       )  
                  ],
                  )
            
            );
        },     
        onDismissed: (direction)=> 
          Provider.of<Cart>(context).removeItem(productId),
        child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Padding(padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox
            (child: 
            Text('\$${cartItem.price}'),
            ),  
          ),
          title: Text(cartItem.title),
          subtitle: Text('Total \$${cartItem.price*cartItem.quantity}'),
          trailing: Text('${cartItem.quantity.toString()}x'),
        ),
        ),
      ),
    );
  }
}