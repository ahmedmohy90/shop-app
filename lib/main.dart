import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_app/providers/cart_item.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/screens/cart.screen.dart';
import 'package:shop_app/screens/product_details_screen.dart';
import 'package:shop_app/screens/products_overview_screens.dart';


import './providers/products.dart';

import './screens/orders_screen.dart';
import './screens/edit_product_screen.dart';
import 'screens/user_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Order(),
            ),
                ],
                child: MaterialApp(
                    title: 'MyShop',
                    theme: ThemeData(
                      primarySwatch: Colors.purple,
                      accentColor: Colors.deepOrange,
                      fontFamily: 'Lato',
                    ),
                    home: ProductsOverview(),
                    routes: {
                      ProductDetails.routeName: (ctx) => ProductDetails(),
                      CartScreen.routeName: (ctx) => CartScreen(),
                      OrdersScreen.routeName: (ctx) => OrdersScreen(),
                      UserProductScreen.routeName: (ctx) => UserProductScreen(),
                      EditProductScreen.routeName: (ctx) => EditProductScreen(),
                    }),
              );
            }
          }
          
          
