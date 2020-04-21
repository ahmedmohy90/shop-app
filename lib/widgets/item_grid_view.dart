import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/products_item.dart';

class ItemGrid extends StatelessWidget {
  var favItems =false;
  ItemGrid(this.favItems);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final items = favItems 
      ? productData.favoriteItems 
      : productData.items;
    return GridView.builder(
      itemBuilder: (context, index)=> ChangeNotifierProvider.value(
        value : items[index],
        child: ProductItems(),
      ),
       padding: EdgeInsets.all(10),
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2 , 
          childAspectRatio: 3/2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
       ),
       
       itemCount: items.length,
       );
  }
}