import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:shop_app/providers/order.dart' as OI;

class OrderItem extends StatefulWidget {
  final OI.OrderItem ord;

  OrderItem(this.ord);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.ord.totalAmount}'),
            subtitle: Text(DateFormat('dd-MM-yyyy hh:mm').format(widget.ord.dateTime)),
            trailing:
              IconButton(
                icon:  Icon((_isExpanded) ? Icons.expand_less : Icons.expand_more), 
                onPressed: (){
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                }
                ),
          ),
          if(_isExpanded)
            Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: min(widget.ord.products.length * 20.0 + 10, 150) ,
             child: ListView(
              children: widget.ord.products
              .map(
                (prod)=>  
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      prod.title, 
                      style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold
                        ),
                        ),
                    SizedBox(width: 4,),   
                    Text('${prod.quantity}x \$${prod.price}'),   
                  ],
                )
              ).toList(),
            ),
            )
        ],
      ),
    );
  }
}