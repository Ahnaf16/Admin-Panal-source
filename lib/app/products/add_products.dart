import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gngm_web/app/products/upload_model.dart';
import 'package:gngm_web/app/products/product_preview.dart';
import 'package:gngm_web/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nanoid/nanoid.dart';
import '../../services/provider.dart';
import '../../widgets/widget_export.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final categorysList = catagoryListProvider;
  int categoryIndex = -1;

  bool discountSwitch = false;

  FlyoutController flyoutController = FlyoutController();

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController brandCtrl = TextEditingController();
  final TextEditingController descCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController discountCtrl = TextEditingController();
  final TextEditingController pIDctrl = TextEditingController();

  List<XFile> selectedImage = [];

  ImgSelector imgSelector = ImgSelector(imagePicker: ImagePicker());

  pubishPreview(context) {
    return showDialog(
      context: context,
      builder: (_) => ContentDialog(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 1.3,
        ),
        content: ProductPreview(
          model: ProductUploadModel(
            pID: pIDctrl.text,
            name: nameCtrl.text,
            brand: brandCtrl.text,
            description: descCtrl.text,
            price: int.parse(priceCtrl.text),
            discountPrice:
                discountCtrl.text.isEmpty ? 0 : int.parse(discountCtrl.text),
            category: categorysList[categoryIndex],
            images: selectedImage,
            haveDiscount: discountSwitch,
          ),
        ),
      ),
    );
  }

  easytoast(conditionOn) {
    return EasyLoading.showToast(
      'Please select an $conditionOn',
      toastPosition: EasyLoadingToastPosition.bottom,
    );
  }

  publishCondition() async {
    if (nameCtrl.text.isEmpty) {
      easytoast('name');
    } else if (brandCtrl.text.isEmpty) {
      easytoast('brand');
    } else if (descCtrl.text.isEmpty) {
      easytoast('description');
    } else if (priceCtrl.text.isEmpty) {
      easytoast('price');
    } else if (discountSwitch == true && discountCtrl.text.isEmpty) {
      easytoast('discount');
    } else if (categoryIndex == -1) {
      easytoast('category');
    } else if (selectedImage.isEmpty) {
      easytoast('image');
    } else {
      await EasyLoading.show();
      pubishPreview(context);
      EasyLoading.dismiss();
    }
  }

  void clearAll() {
    return setState(() {
      nameCtrl.clear();
      brandCtrl.clear();
      descCtrl.clear();
      priceCtrl.clear();
      discountCtrl.clear();
      pIDctrl.text = nanoid();
      selectedImage.clear();
      categoryIndex = -1;
      discountSwitch = false;
    });
  }

  @override
  void initState() {
    super.initState();
    pIDctrl.text = nanoid();
  }

  @override
  void dispose() {
    flyoutController.dispose();
    pIDctrl.dispose();
    nameCtrl.dispose();
    brandCtrl.dispose();
    descCtrl.dispose();
    priceCtrl.dispose();
    discountCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: const Text('Add Product '),
        commandBar: Expanded(
          child: CommandBar(
            mainAxisAlignment: MainAxisAlignment.end,
            primaryItems: [
              CommandBarButton(
                onPressed: () {
                  publishCondition();
                  setState(() {
                    pIDctrl.text = nanoid();
                  });
                },
                icon: const Icon(FluentIcons.preview_link),
                label: const Text('Priview Product'),
              ),
              CommandBarButton(
                onPressed: () {
                  clearAll();
                },
                icon: const Icon(FluentIcons.clear),
                label: const Text('Clear All Fields'),
              ),
            ],
          ),
        ),
      ),
      content: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            //---main row
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.8,
                  //-------------left side
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Card(
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          //------------- name and brand
                          child: nameAndBrand(),
                        ),
                      ),
                      //-------------Description
                      const SizedBox(height: 20),
                      descBox(),
                      const SizedBox(height: 20),
                      //-------------img selection
                      imageSelectButtons(),
                      const SizedBox(height: 20),
                      //-------------show selected img
                      selectedImage.isEmpty ? Container() : selectedImgList(),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                //--------------------------right side
                const SizedBox(width: 20),
                Expanded(
                  child: Card(
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //-------------price
                        priceBox(),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Default Discount?'),
                            //----------------------discount switch
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: ToggleSwitch(
                                focusNode: FocusNode(
                                  skipTraversal: true,
                                ),
                                checked: discountSwitch,
                                onChanged: (value) {
                                  setState(() {
                                    discountSwitch = !discountSwitch;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        //-----------------duscount box
                        discountSwitch ? discountBox() : const SizedBox(),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 20),
                        //----------------categorys
                        resetCategory(context),

                        categoryRadio(),
                        const SizedBox(height: 20),
                        const Divider(),
                        const SizedBox(height: 20),
                        //-----------------product id
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Flexible(
                              child: pIDbox(),
                            ),
                            const SizedBox(width: 10),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: OutlinedButton(
                                child: const Text('Generate ID'),
                                onPressed: () {
                                  pIDctrl.text = nanoid();
                                },
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
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

  TextBox kTextBox({
    required TextEditingController controller,
    required String header,
    bool numberOnly = false,
    bool isexpandes = false,
    double maxheight = 150,
    bool readOnly = false,
    bool skipTraversal = false,
  }) {
    final numberOnlyInput =
        FilteringTextInputFormatter(RegExp(r'[0-9]'), allow: true);
    return TextBox(
      textInputAction: TextInputAction.next,
      controller: controller,
      header: header,
      readOnly: readOnly,
      inputFormatters: numberOnly == true ? [numberOnlyInput] : [],
      maxLines: isexpandes ? null : 1,
      minHeight: isexpandes ? maxheight : null,
      expands: isexpandes,
      focusNode: FocusNode(
        canRequestFocus: !readOnly,
        skipTraversal: skipTraversal,
      ),
      suffix: IconButton(
          icon: const Icon(FluentIcons.clear),
          onPressed: () {
            controller.clear();
          }),
      suffixMode: readOnly
          ? OverlayVisibilityMode.never
          : OverlayVisibilityMode.editing,
      decoration: BoxDecoration(
        color: Colors.grey[10],
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.grey[100],
          width: 1,
        ),
      ),
    );
  }

  Column nameAndBrand() {
    return Column(
      children: [
        kTextBox(
          controller: nameCtrl,
          header: 'Name',
        ),
        const SizedBox(height: 20),
        kTextBox(controller: brandCtrl, header: 'Brand'),
      ],
    );
  }

  MouseRegion descBox() {
    return MouseRegion(
      cursor: SystemMouseCursors.text,
      child: Card(
        borderRadius: BorderRadius.circular(10),
        child: kTextBox(
          controller: descCtrl,
          header: 'Description',
          isexpandes: true,
        ),
      ),
    );
  }

  TextBox priceBox() {
    return kTextBox(
      controller: priceCtrl,
      header: 'Price',
      numberOnly: true,
    );
  }

  TextBox discountBox() {
    return kTextBox(
      controller: discountCtrl,
      header: 'Set Default Discount Price',
      numberOnly: true,
    );
  }

  TextBox pIDbox() {
    return kTextBox(
      controller: pIDctrl,
      header: 'Product ID',
      readOnly: true,
    );
  }

  Row resetCategory(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Category',
          style: FluentTheme.of(context).typography.bodyLarge,
        ),

        /// -1 means no category selected
        categoryIndex == -1
            ? Container()
            : MouseRegion(
                cursor: SystemMouseCursors.click,
                child: IconButton(
                  icon: const Icon(FluentIcons.reset),
                  onPressed: () {
                    if (categoryIndex != -1) {
                      setState(() {
                        categoryIndex = -1;
                      });
                    }
                  },
                ),
              )
      ],
    );
  }

  Column categoryRadio() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        categorysList.length,
        (index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: RadioButton(
                checked: categoryIndex == index,
                onChanged: (value) => setState(() => categoryIndex = index),
                content: Text(categorysList[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  CommandBarCard imageSelectButtons() {
    return CommandBarCard(
      child: CommandBar(
        primaryItems: [
          CommandBarButton(
            onPressed: () {
              imgSelector
                  .getMultiImgs(path: 'path', fileName: 'fileName')
                  .then((imgs) => {
                        setState(() {
                          selectedImage.addAll(imgs!);
                        })
                      });
            },
            icon: const Icon(FluentIcons.file_image),
            label: const Text('Select Image'),
          ),
          selectedImage.isEmpty
              ? const CommandBarSeparator()
              : CommandBarButton(
                  onPressed: () {
                    setState(() {
                      selectedImage.clear();
                    });
                  },
                  icon: const Icon(FluentIcons.delete),
                  label: const Text('Clear Selected Images'),
                ),
        ],
      ),
    );
  }

  Wrap selectedImgList() {
    return Wrap(
      children: List.generate(
        selectedImage.length,
        (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Hero(
                  tag: 'image$index',
                  child: selectedImage.isNotEmpty
                      ? Image.network(
                          selectedImage[index].path,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : Container(),
                ),
                Positioned(
                  left: 70,
                  child: imgOptionsbutton(index),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Flyout imgOptionsbutton(int index) {
    return Flyout(
      openMode: FlyoutOpenMode.press,
      content: (context) {
        return imgMenuOption(context, index);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey.withOpacity(1),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Icon(
            FluentIcons.more,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  MenuFlyout imgMenuOption(BuildContext context, int index) {
    return MenuFlyout(
      items: [
        MenuFlyoutItem(
          leading: const Icon(FluentIcons.view),
          text: const Text('View'),
          onPressed: () {
            flyoutController.close();
            imgPreviewDialog(context, index);
          },
        ),
        MenuFlyoutItem(
          leading: const Icon(FluentIcons.remove),
          text: const Text('Remove'),
          onPressed: () {
            setState(() {
              selectedImage.removeAt(index);
            });

            Navigator.pop(context);
          },
        )
      ],
    );
  }

  Future<Object?> imgPreviewDialog(BuildContext context, int index) {
    return showDialog(
      context: context,
      builder: (_) => ContentDialog(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width / 1.5,
        ),
        content: ImgView(
          tag: 'image$index',
          url: selectedImage[index].path,
        ),
      ),
    );
  }
}
