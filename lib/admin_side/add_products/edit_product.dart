import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nicotine/admin_side/services/firestore_methods.dart';
import 'package:sizer/sizer.dart';

import '../../utils/utils.dart';

class EditProduct extends StatefulWidget {
   final  String title;
   final String price;
    final String  description;
    final imgUrl;
    final String newID;



   EditProduct({ required this.price,required this.description,  required this.title,required this.imgUrl, required this.newID});
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {


  Future _selectImage() async {
    Uint8List im = await pickIamge(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  TextEditingController _title  = TextEditingController();
  TextEditingController _price  = TextEditingController();
  TextEditingController _description  = TextEditingController();
  bool _showProgress = false;
  // void dispose() {
  //   super.dispose();
  //   _title.dispose();
  //   _description.dispose();
  //   _price.dispose();
  // }

  _clearThings(){

    _image?.clear();
    _title.clear();
    _description.clear();
    _price.clear();
  }

  Uint8List? _image;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         appBar: AppBar(title: Text("Edit Products"),backgroundColor:   Color(0xffD61E3C),),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _image != null? Container(
                    height: 22.h,
                    width: 80.w,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: Image(image: MemoryImage(_image!,),
                      fit: BoxFit.cover,

                    )

                ):Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),

                  ),

                  height: 22.h,width: 80.w,child: Center(child: Image.network(widget.imgUrl.toString(),fit: BoxFit.cover,),),),

                IconButton(
                  tooltip: 'Take Image or pick from gallery',
                  onPressed: ()=>_selectImage(),
                  icon: Icon(
                    Icons.camera_alt,
                    color: Color(0xffD61E3C),
                    size: 30,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(

                          controller: _title,

                          validator: (value) {
                            if (value!.isEmpty ) {
                              return 'Please add title at least 4 characters';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: 'Title',hintText: widget.title),


                        ),
                        TextFormField(
                          controller: _price,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please add  price  of your product';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Price',hintText: widget.price),
                          keyboardType: TextInputType.number,

                        ),
                        TextFormField(
                          controller: _description,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please add  description of your product';
                            }
                            return null;
                          },
                          decoration: InputDecoration(

                              labelText: 'Description', hintText: widget.description),

                        ),



                        const SizedBox(height: 45.0),
                        _showProgress?Center(child: CircularProgressIndicator(color: Color(0xffD61E3C),),): MaterialButton(
                          child: Text("Update Product"),
                          color: Color(0xffD61E3C),
                          onPressed:() async{
                            if(_formKey.currentState!.validate()) {
                              setState(() {
                                _showProgress = true;
                              });
                              print("nnnnn....${widget.newID}");

                              await FirestoreMethods().
                              updateProduct(description: _description.text,
                                  file: _image,
                                  title: _title.text,
                                  price: _price.text,
                                  id: widget.newID).then((value) {
                                if (value == "success") {
                                  setState(() {
                                    _showProgress = false;
                                  });

                                  showSnackBar(
                                      "Product Updated Sucessfully", context);

                                  _clearThings();
                                }
                              });
                            }


                          },
                          textColor: Colors.white,
                          padding: const EdgeInsets.all(16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}