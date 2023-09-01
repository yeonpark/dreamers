import 'dart:io';

import 'package:dreamers/common/widgets/bottom_bar.dart';
import 'package:dreamers/common/widgets/custom_button.dart';
import 'package:dreamers/common/widgets/custom_textfield.dart';
import 'package:dreamers/constants/global_variables.dart';
import 'package:dreamers/constants/utils.dart';
// import 'package:dreamers/features/admin/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dreamers/features/home/screens/item_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:dreamers/features/story/services/story_services.dart';
import 'package:image_picker/image_picker.dart';

class PostStoryScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const PostStoryScreen({Key? key}) : super(key: key);

  @override
  State<PostStoryScreen> createState() => _PostStoryScreenState();
}

class _PostStoryScreenState extends State<PostStoryScreen> {
  final storyServices = StoryServices();
  final TextEditingController headingController = TextEditingController();
  final TextEditingController subHeadingController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();
  final TextEditingController fullDetailController = TextEditingController();
  final TextEditingController fundRequestSizeController =
      TextEditingController();

  String category = 'primary';
  List<File> selectedImages = [];
  final picker = ImagePicker();
  final _postStoryFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    headingController.dispose();
    subHeadingController.dispose();
    summaryController.dispose();
    fullDetailController.dispose();
    countryController.dispose();
  }

  List<String> productCategories = [
    'primary',
    'secondary',
    'tertiary',
  ];

  void postStory() {
    // if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
    if (_postStoryFormKey.currentState!.validate()) {
      storyServices.postStory(
          context: context,
          heading: headingController.text,
          sub_heading: subHeadingController.text,
          country: countryController.text,
          summary: summaryController.text,
          full_detail: fullDetailController.text,
          category: category,
          fundRequesSize: int.parse(fundRequestSizeController.text),
          images: selectedImages);
    }
  }

  // void selectImages() async {
  //   var res = await pickImages();
  //   setState(() {
  //     images = res;
  //   });
  // }
  void selectImages() async {
    final pickedFile = await picker.pickMultiImage();
    List<XFile> xfilePick = pickedFile;
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        selectedImages.add(File(xfilePick[i].path));
      }
      setState(() {});
    } else {
      showSnackBar(context, "No Image selected!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Text(
            'Post Story',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _postStoryFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                selectedImages.isNotEmpty
                    ? CarouselSlider(
                        items: selectedImages.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Select Your Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: headingController,
                  hintText: 'Heading',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: subHeadingController,
                  hintText: 'Sub Heading',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: countryController,
                  hintText: 'Country',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: summaryController,
                  hintText: 'Summary',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: fullDetailController,
                  hintText: 'Full Detail',
                  maxLines: 7,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: fundRequestSizeController,
                  hintText: 'Fund Request Size',
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomButton(
                    text: 'Post',
                    onTap: () {
                      postStory();
                      Navigator.pushNamed(context, BottomBar.routeName);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
