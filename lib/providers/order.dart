import 'package:flutter/cupertino.dart';

import 'cart_item.dart';

class OrderItem{
  final String id;
  final double totalAmount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({this.id, this.totalAmount, this.products, this.dateTime});
    
  }
  class Order with ChangeNotifier {
    List<OrderItem> _orders=[];

    List<OrderItem> get orders{
      return [..._orders];
    }

    void addOrder (double totalAmount, List<CartItem> cartItems){
        _orders.add(OrderItem(id: DateTime.now().toString(), totalAmount: totalAmount, products: cartItems, dateTime: DateTime.now()));
    }
    
  }
  