import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_item.dart';
import '../providers/Product.dart';
import '../screens/product_details_screen.dart';
class ProductItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        final productItem = Provider.of<Product>(context, listen: false);
        final cart = Provider.of<Cart>(context, listen: false);
         return ClipRRect(
           borderRadius: BorderRadius.circular(15),
           child: GridTile(
             child: GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed(ProductDetails.routeName, arguments:productItem.id);
                },
                child: Image.network(
                 productItem.imageUrl,
                 fit: BoxFit.cover,),
             ),
              footer: GridTileBar(
                backgroundColor: Colors.black87,
                title: Text(
                  productItem.title,
                  textAlign: TextAlign.center,
                  ),
                leading: Consumer<Product>(
                  builder: (ctx, productItem, child) =>IconButton(
                    icon: Icon(
                      productItem.isFavorite ? Icons.favorite
                                             : Icons.favorite_border
                    ),
                    color: Theme.of(context).accentColor, 
                    onPressed: () {
                      productItem.toggleFavorite();
                    }
                    ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.shopping_cart),
                    color: Theme.of(context).accentColor, 
                  onPressed: (){
                    cart.addCartItems(productItem.id, productItem.price, productItem.title);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('This item is added to your Cart'),
                        duration: Duration(seconds: 2),
                        action: SnackBarAction(label: 'UNDO'
                        ,onPressed: ()=>cart.removeCartItem(productItem.id)
                        ),
                        ),
                        );
                  }
                  ),
         
              ),
             ),
         );

  }      
}