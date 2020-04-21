import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Product.dart';
import '../providers/Products.dart';

class EditProductScreen extends StatefulWidget {
 static const routeName = '/EditProduct';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
      
    final _imageUrlController = TextEditingController();
    final _imageFocusNode = FocusNode();
    final _form = GlobalKey<FormState>();
    var _editProduct = Product(id: null, title: '', price: 0, description: '', imageUrl: '');

  void _saveForm(){
    final isValid = _form.currentState.validate();
    if(!isValid){
      return ;
    }
    _form.currentState.save();
    
    Provider.of<Products>(context, listen: false).addProduct(_editProduct);   
    Navigator.of(context).pop();
  }
    @override 
  void initState() {
    _imageFocusNode.addListener(updateImageUrl);
    super.initState();
  }
  void updateImageUrl(){
    if(!_imageFocusNode.hasFocus){
      setState(() {
        
      });
    }
  }
    @override
  void dispose() {
    _imageFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save), 
            onPressed: _saveForm,
            )
        ],       
      ),
      body: Form(
        key: _form,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'title',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                   validator: (value){
                    if(value.isEmpty){
                      return 'please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _editProduct = Product(
                      title: value, 
                      price: _editProduct.price, 
                      description: _editProduct.description, 
                      imageUrl: _editProduct.imageUrl);
                  },
                 
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'price'
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  onFieldSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                   validator: (value){
                    if(value.isEmpty){
                      return 'please enter a price';
                    }
                    if(double.tryParse(value) == null){
                      return 'please enter a number';
                    }
                    if(double.parse(value)<=0){
                      return 'please enter a number bigger than Zero';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _editProduct = Product(
                      title: _editProduct.title, 
                      price: double.parse(value), 
                      description: _editProduct.description, 
                      imageUrl: _editProduct.imageUrl);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description'
                  ),
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  onFieldSubmitted:(_)=>FocusScope.of(context).nextFocus(),
                   validator: (value){
                    if(value.isEmpty){
                      return 'please enter a valid description';
                    }
                    if(value.length<10){
                      return 'Should be at least 10 characters long';
                    }
                    return null;
                  },
                  onSaved: (value){
                    _editProduct = Product(
                      title: _editProduct.title, 
                      price: _editProduct.price, 
                      description: value, 
                      imageUrl: _editProduct.imageUrl);
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.only(top: 8, right: 10),
                        decoration: BoxDecoration(border: Border.all(width: 1),
                        color: Colors.grey),
                        child:
                         _imageUrlController.text.isEmpty 
                         ? Text('Enter Image Url') 
                         : FittedBox(child: Image.network(_imageUrlController.text, fit: BoxFit.cover,),
                        ),

                    ),
                    Expanded(
                       child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Image Url',
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageFocusNode,
                        onFieldSubmitted: (_) {
                        _saveForm();
                         },
                        validator: (value){
                          if(value.isEmpty){
                            return 'please enter a an Image Url';
                            }
                          if((!value.startsWith('http')) && (!value.startsWith('https'))){
                            return 'please enter a valid image url';
                          }
                          
                          return null;
                          },
                        onSaved: (value){
                          _editProduct = Product(
                            title: _editProduct.title, 
                            price: _editProduct.price, 
                            description: _editProduct.description, 
                            imageUrl: value);
                  },
                      ),
                    )
                  ],
                )
              ],
            ),
            ),
        ),
      ),
    );
  }
}