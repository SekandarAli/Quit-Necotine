import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nicotine/admin_side/services/firestore_methods.dart';
import 'package:sizer/sizer.dart';
import '../../utils/utils.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Future _selectImage() async {
    Uint8List im = await pickIamge(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  TextEditingController _title = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _description = TextEditingController();
  bool _showProgress = false;

  clear() {
    _title.clear();
    _price.clear();
    _description.clear();
    _image?.clear();
  }

  Uint8List? _image;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                _image != null
                    ? Container(
                        height: 22.h,
                        width: 80.w,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image(
                          image: MemoryImage(
                            _image!,
                          ),
                          fit: BoxFit.cover,
                        ))
                    : Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 22.h,
                        width: 80.w,
                        child: Center(
                            child: Text(
                                "Please Select  product Image from gallery")),
                      ),
                IconButton(
                  tooltip: 'Take Image or pick from gallery',
                  onPressed: () => _selectImage(),
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
                            if (value!.isEmpty) {
                              return 'Please add title  of your  product';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: 'Title'),
                        ),
                        TextFormField(
                          controller: _price,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please add  price  of your product';
                            }
                            return null;
                          },
                          decoration: InputDecoration(labelText: 'Price'),
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
                          decoration: InputDecoration(labelText: 'Description'),
                        ),
                        const SizedBox(height: 45.0),
                        _showProgress
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffD61E3C),
                                ),
                              )
                            : MaterialButton(
                                child: const Text("Upload Product"),
                                color: const Color(0xffD61E3C),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _showProgress = true;
                                    });

                                    await FirestoreMethods()
                                        .uploadProduct(
                                            description: _description.text,
                                            file: _image!,
                                            title: _title.text,
                                            price: _price.text)
                                        .then((value) {
                                      if (value == "success") {
                                        setState(() {
                                          _showProgress = false;
                                        });

                                        showSnackBar(
                                            "Product Uploaded Successfully",
                                            context);

                                        clear();
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
