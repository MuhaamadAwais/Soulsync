import 'package:faith/bottomnavi.dart';
import 'package:faith/colorapp.dart';
import 'package:faith/profile_feature/presentation/provider/profileselectprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});
  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    final provider = Provider.of<Profileselectprovider>(context, listen: false);
    await prefs.setString("name", _nameController.text);
    await prefs.setString("age", _ageController.text);
    await prefs.setInt("goal", provider.selectedIndex);
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    _nameController.text = prefs.getString("name") ?? "";
    _ageController.text = prefs.getString("age") ?? "";

    final provider = Provider.of<Profileselectprovider>(context, listen: false);

    provider.goals(prefs.getInt("goal") ?? 0);
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
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    width: width,
                    height: height * 0.25,
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
                            padding: const EdgeInsets.only(left: 2, top: 4),
                            child: Text(
                              "FULL NAME",
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 05),
                          Container(
                            width: width * 0.85,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade100,
                            ),
                            child: Center(
                              child: TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColors.emeraldGreen,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                      width: 1,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Your name",
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 2, top: 5),
                            child: Text(
                              "AGE",
                              style: TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 05),

                          Container(
                            width: width * 0.85,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade100,
                            ),
                            child: Center(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: _ageController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColors.emeraldGreen,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: AppColors.white,
                                      width: 1,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Your age",
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
                  elevation: 2,
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
                    await saveData();

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
              flex: 3,
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
