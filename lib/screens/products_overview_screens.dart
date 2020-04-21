import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import '../providers/cart_item.dart';
import '../screens/cart.screen.dart';
import '../widgets/item_grid_view.dart';
import '../widgets/padge.dart';

enum FilterOptions{
  FavoriteItems,
  AllItems
}

class ProductsOverview extends StatefulWidget {
  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  bool _showFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Overview'),
        actions: <Widget>[
          Consumer<Cart>(
            builder:(_, cart, ch) => Badge(
              child: ch, 
              value: cart.totalItems().toString(),
              ),
            child:  IconButton(
            icon: Icon(Icons.shopping_cart), 
            onPressed: (){
              Navigator.of(context).pushNamed(CartScreen.routeName);
            }
            ),  
            ),
          
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue){
              setState(() {
                if(selectedValue == FilterOptions.FavoriteItems){
                _showFavorite = true;
              }else{
                _showFavorite = false;
              }
              });              
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_)=>[
              PopupMenuItem(
                child: Text('Favorite Item'),
                value: FilterOptions.FavoriteItems,
              ),
              PopupMenuItem(
                child: Text('All Items'),
                value:FilterOptions.AllItems,
                )
            ],
            )
        ],
        ),
        drawer: AppDrawer(),
        body: ItemGrid(_showFavorite),
    );
  }
}