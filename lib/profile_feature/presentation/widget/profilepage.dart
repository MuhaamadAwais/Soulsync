import 'dart:io';
import 'package:faith/bottomnavi.dart';
import 'package:faith/colorapp.dart';
import 'package:faith/profile_feature/presentation/provider/profileselectprovider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});
  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();

    super.dispose();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    final provider = Provider.of<Profileselectprovider>(context, listen: false);

    await prefs.setString("name", nameController.text);
    await prefs.setString("age", ageController.text);
    await prefs.setInt("goal", provider.selectedIndex);

    if (image != null) {
      await prefs.setString("image", image!.path);
    }
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    nameController.text = prefs.getString("name") ?? "";
    ageController.text = prefs.getString("age") ?? "";

    final provider = Provider.of<Profileselectprovider>(context, listen: false);

    provider.goals(prefs.getInt("goal") ?? 0);

    String? path = prefs.getString("image");

    if (path != null && File(path).existsSync()) {
      setState(() {
        image = XFile(path);
      });
    }
  }

  Future<void> imageSelect(ImageSource source) async {
    final XFile? pickedImage = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });

      await saveData();
    }
  }

  void showImagePickerDialog() {
    showModalBottomSheet(
      backgroundColor: AppColors.white,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () {
                  Navigator.pop(context);
                  imageSelect(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  imageSelect(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: width,
                    height: height * 0.30,
                    color: AppColors.emeraldGreen,
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.04),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Almost there",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "Setup Your Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: -30,
                    child: GestureDetector(
                      onTap: () {
                        showImagePickerDialog();
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white,
                          border: Border.all(
                            color: AppColors.emeraldGreen,
                            width: 3,
                          ),
                        ),
                        child: ClipOval(
                          child: image == null
                              ? Icon(Icons.account_circle, size: 40)
                              : Image.file(
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: -40,
                    left: width * 0.5,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.emeraldGreen,
                        border: Border.all(color: AppColors.white, width: 1),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: AppColors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: width,
                    height: height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "FULL NAME",
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.85,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade100,
                              border: Border.all(
                                width: 1,
                                color: AppColors.emeraldGreen,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: TextField(
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Your name",
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "AGE",
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.85,
                            height: height * 0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade100,
                              border: Border.all(
                                width: 1,
                                color: AppColors.emeraldGreen,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: TextField(
                                  controller: ageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Your age",
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // goals
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: width,
                    height: height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Select Your Goals",
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),

                          Text(
                            "Choose What you'd like to track",
                            style: TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          goalItem(
                            width * 0.5,
                            height * 0.05,
                            0,
                            "Salah Tracking",
                            Icons.mosque,
                          ),
                          goalItem(
                            width * 0.5,
                            height * 0.05,
                            1,
                            "Quran Reading",
                            Icons.menu_book,
                          ),
                          goalItem(
                            width * 0.5,
                            height * 0.05,
                            2,
                            "Daily Duas",
                            Icons.favorite,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // save
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    // await saveData();

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Bottomnavi()),
                      (route) => false,
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      width: width * 0.75,
                      height: height * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.emeraldGreen,
                      ),
                      child: Center(
                        child: Text(
                          "Save & Continue",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget goalItem(
    double width,
    double height,
    int index,
    String title,
    IconData icon,
  ) {
    final provider = Provider.of<Profileselectprovider>(context);
    bool isSelected = provider.selectedIndex == index;
    return GestureDetector(
      onTap: () {
        provider.goals(index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.emeraldGreen.withValues(alpha: 0.2)
              : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppColors.emeraldGreen : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Icon(
                icon,
                color: isSelected ? AppColors.emeraldGreen : AppColors.black,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 8,
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected ? AppColors.emeraldGreen : AppColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
