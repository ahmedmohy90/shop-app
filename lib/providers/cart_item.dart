import 'package:flutter/cupertino.dart';

class CartItem with ChangeNotifier{

  String id;
  String title;
  double price;
  int quantity;
  
  CartItem({
    this.id, 
    this.title,
    this.price,
    this.quantity}
    );
}

class Cart with ChangeNotifier{

Map<String, CartItem> _items={};

Map<String, CartItem> get items{

  return{..._items};
}
double get totalPrice{
  var _total=0.0;
  _items.forEach((key, cartItem){
    _total += cartItem.price*cartItem.quantity;
  });
  return _total; 
}
int totalItems(){
  return items.length;
}

void addCartItems(String productId, double price, String title){
  if(_items.containsKey(productId)){
    _items.update(productId, (exsistingItem)=>
    CartItem(
      id: exsistingItem.id, 
      title: exsistingItem.title, 
      price: exsistingItem.price, 
      quantity: exsistingItem.quantity+1),
      );
  }else{
    _items.putIfAbsent(productId, ()=>
    CartItem(
      id: DateTime.now().toString(), 
      title: title, 
      price: price, 
      quantity: 1),
      );   
  }
  notifyListeners();
}
 void removeCartItem (String productId){
    if(!_items.containsKey(productId)){ // may no need for this condition
      return;
    }if(_items[productId].quantity>1){
      _items.update(productId, (exsistingCartItem)=>CartItem(
        id: exsistingCartItem.id, 
        title: exsistingCartItem.title, 
        price: exsistingCartItem.price, 
      quantity: exsistingCartItem.quantity-1));
    }else{
      _items.remove(productId);
    }
    notifyListeners();
  }
 void removeItem(String productId){
   items.remove(productId);
   
   notifyListeners(); 
}
void clearCart(){
  _items = {};
  notifyListeners();
}
}