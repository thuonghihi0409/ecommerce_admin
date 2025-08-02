import 'dart:developer';
import 'dart:typed_data';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuongmaidientu/core/app_color.dart';
import 'package:thuongmaidientu/features/product/domain/entities/category.dart';
import 'package:thuongmaidientu/features/product/domain/entities/product_detail.dart';
import 'package:thuongmaidientu/features/product_management/presentation/bloc/product_management_bloc/product_management_bloc.dart';
import 'package:thuongmaidientu/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:thuongmaidientu/shared/service/firebase_service.dart';
import 'package:thuongmaidientu/shared/service/navigator_service.dart';
import 'package:thuongmaidientu/shared/utils/extension.dart';
import 'package:thuongmaidientu/shared/utils/helper.dart';
import 'package:thuongmaidientu/shared/utils/parse_error_model.dart';
import 'package:thuongmaidientu/shared/widgets/button_custom.dart';
import 'package:thuongmaidientu/shared/widgets/upload_image_widget.dart';

class CreateProductPage extends StatefulWidget {
  const CreateProductPage({super.key});

  @override
  State<CreateProductPage> createState() => _CreateProductPageState();
}

class _CreateProductPageState extends State<CreateProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final List<VariantForm> _variants = [VariantForm()];

  late ProductManagementBloc _bloc;
  List<Uint8List> images = [];
  String categoryId = "";
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _bloc = context.read<ProductManagementBloc>();
  }

  void _addVariant() {
    setState(() {
      _variants.add(VariantForm());
    });
  }

  void _removeVariant(int index) {
    setState(() {
      _variants.removeAt(index);
    });
  }

  void _submit() async {
    try {
      setState(() {
        isLoading = true;
      });
      final store = context.read<ProfileBloc>().state.store;
      final listImage = await Future.wait(images.map((image) async {
        final url = await FirebaseService.instance.uploadImagesData(image);
        return ImageItem(id: "", url: url, alt: "image");
      }));

      final listVariant = await Future.wait(_variants.map((variant) async {
        late String url;
        url = await FirebaseService.instance.uploadImagesData(variant.image);
        return Variant(
            id: "",
            name: variant.nameController.text,
            price: int.tryParse(variant.priceController.text) ?? 0,
            stock: int.tryParse(variant.stockController.text) ?? 0,
            cover: url,
            totalSold: 0);
      }));

      final product = ProductDetail(
          productId: "",
          productName: _productNameController.text,
          description: _descriptionController.text,
          price: int.tryParse(_priceController.text) ?? 0,
          store: store,
          categoryId: categoryId,
          images: listImage,
          variants: listVariant,
          avgRating: 0.0,
          totalRating: 0,
          totalSold: 0,
          cover: listImage[0].url);
      _bloc.add(SellerCreateProduct(
          productDetail: product,
          onSuccess: () {
            setState(() {
              isLoading = false;
            });
            Helper.showToastBottom(message: ("key_create_success".tr()));
            NavigationService.instance.pushNamed("productmanagement");
          },
          onError: () {
            setState(() {
              isLoading = false;
            });
          }));
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Helper.showToastBottom(message: ParseError.fromJson(e).message);
      log(ParseError.fromJson(e).message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductManagementBloc, ProductManagementState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(title: const Text('Tạo sản phẩm mới')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Thông tin sản phẩm',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _productNameController,
                  decoration: const InputDecoration(
                    labelText: 'Tên sản phẩm',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Bắt buộc' : null,
                ),
                20.h,
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Mô tả',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                20.h,
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(
                          labelText: 'Giá cơ bản (VNĐ)',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    20.w,
                    Expanded(
                      child: DropdownSearch<Category>(
                        dropdownBuilder: (context, province) =>
                            Text(province?.name ?? ""),
                        itemAsString: (item) => item.name ?? "",
                        compareFn: (Category a, Category b) => a.id == b.id,
                        items: (String filter, LoadProps? props) async {
                          return (state.listCategory ??
                                    [
                                     
                                    ])
                              .where(
                                  (item) => (item.name ?? "").contains(filter))
                              .toList();
                        },
                        popupProps: const PopupProps.menu(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                                decoration: InputDecoration(
                                    focusColor: AppColor.greyColor,
                                    contentPadding: EdgeInsets.all(8)))),
                        decoratorProps: const DropDownDecoratorProps(
                          decoration: InputDecoration(
                            hint: Text("Phân loại sản phẩm"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        onChanged: (value) {
                          categoryId = value?.id ?? "";
                        },
                      ),
                    ),
                  ],
                ),
                30.h,
                MultiImagePickerWidget(
                  onSuccess: (list) {
                    images = list;
                  },
                ),
                30.h,
                const Text('Biến thể sản phẩm',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                20.h,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _variants.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Biến thể ${index + 1}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            const Spacer(),
                            if (_variants.length > 1)
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removeVariant(index),
                              ),
                          ],
                        ),
                        10.h,
                        _variants[index],
                        20.h,
                      ],
                    );
                  },
                ),
                CustomButton(
                  text: "Thêm biến thể",
                  onPressed: _addVariant,
                  isMinWidth: true,
                  icon: const Icon(Icons.add),
                ),
                32.h,
                CustomButton(
                  text: 'Tạo sản phẩm',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submit();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class VariantForm extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  late Uint8List image;

  VariantForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Tên biến thể',
            border: OutlineInputBorder(),
          ),
          validator: (value) =>
              value == null || value.isEmpty ? 'Bắt buộc' : null,
        ),
        20.h,
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: priceController,
                decoration: const InputDecoration(
                  labelText: 'Giá (VNĐ)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            30.w,
            Expanded(
              child: TextFormField(
                controller: stockController,
                decoration: const InputDecoration(
                  labelText: 'Số lượng tồn kho',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        30.h,
        MultiImagePickerWidget(
          allowMultiple: false,
          onSuccess: (p0) {
            if (p0.isNotEmpty) {
              image = p0[0];
            }
          },
        ),
        30.h,
      ],
    );
  }
}
