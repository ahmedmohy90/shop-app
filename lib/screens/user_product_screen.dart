import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../providers/Products.dart';
import '../widgets/user_items.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/userProduct';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Products'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: (){
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            }),
        ],
      ),
      drawer: AppDrawer(),
      body: ChangeNotifierProvider.value(
        value: Products(),
        child: Consumer<Products>(
          builder: (ctx, product, child)=> ListView.builder(
            itemCount: product.items.length,
            itemBuilder: (ctx, i)=>Column(
            children: <Widget>[
              UserItem(product.items[i].title, product.items[i].imageUrl),
              Divider(),
            ],
            ),
            )
        ),
      ),
    
    );
  }
}