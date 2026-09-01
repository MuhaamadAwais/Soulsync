import 'package:faith/colorapp.dart';
import 'package:faith/profile_feature/presentation/provider/nameprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Inputfielsdwid extends StatefulWidget {
  const Inputfielsdwid({super.key});

  @override
  State<Inputfielsdwid> createState() => _InputfielsdwidState();
}

class _InputfielsdwidState extends State<Inputfielsdwid> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;

  String selectedGender = "Male";

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _ageController = TextEditingController();

    final provider = Provider.of<Nameprovider>(
      context,
      listen: false,
    );

    _nameController.text = provider.name;
    _ageController.text = provider.age;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // ================= FULL NAME =================

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "FULL NAME",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14,
              ),
            ),
          ),

          SizedBox(height: height * 0.01),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
            ),
            child: TextField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.grey,
                ),
                hintText: "Name",

                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.emeraldGreen,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // ================= AGE =================

          SizedBox(height: height * 0.02),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "AGE",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14,
              ),
            ),
          ),

          SizedBox(height: height * 0.01),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
            ),
            child: TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
                hintText: "Age",

                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.emeraldGreen,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // ================= GENDER =================

          SizedBox(height: height * 0.03),

          const Divider(
            height: 5,
            color: Colors.grey,
          ),

          SizedBox(height: height * 0.02),

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "GENDER",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14,
              ),
            ),
          ),

          SizedBox(height: height * 0.01),

          Row(
            children: [

              // ================= MALE =================

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGender = "Male";
                    });
                  },
                  child: Container(
                    height: height * 0.065,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                      border: Border.all(
                        width: 1,
                        color: selectedGender == "Male"
                            ? AppColors.emeraldGreen
                            : Colors.grey,
                      ),

                      color: selectedGender == "Male"
                          ? AppColors.emeraldGreen
                          : AppColors.white,
                    ),

                    child: Center(
                      child: Text(
                        "Male",
                        style: TextStyle(
                          color: selectedGender == "Male"
                              ? AppColors.white
                              : AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: width * 0.04),

              // ================= FEMALE =================

              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedGender = "Female";
                    });
                  },
                  child: Container(
                    height: height * 0.065,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                      border: Border.all(
                        width: 1,
                        color: selectedGender == "Female"
                            ? AppColors.emeraldGreen
                            : Colors.grey,
                      ),

                      color: selectedGender == "Female"
                          ? AppColors.emeraldGreen
                          : AppColors.white,
                    ),

                    child: Center(
                      child: Text(
                        "Female",
                        style: TextStyle(
                          color: selectedGender == "Female"
                              ? AppColors.white
                              : AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ================= SAVE =================

          SizedBox(height: height * 0.03),

          const Divider(
            height: 5,
            color: Colors.grey,
          ),

          SizedBox(height: height * 0.03),

          Center(
            child: GestureDetector(
              onTap: () async {
                final newName = _nameController.text.trim();
                final newAge = _ageController.text.trim();

                // Name validation
                if (newName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter your name"),
                    ),
                  );
                  return;
                }

                // Age validation
                if (newAge.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please enter your age"),
                    ),
                  );
                  return;
                }

                final provider = Provider.of<Nameprovider>(
                  context,
                  listen: false,
                );

                // Save Name
                await provider.updateName(newName);

                // Save Age
                await provider.updateAge(newAge);

                if (!context.mounted) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Changes saved successfully",
                    ),
                  ),
                );

                Navigator.pop(context);
              },

              child: Container(
                width: width * 0.8,
                height: height * 0.06,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.emeraldGreen,
                ),

                child: const Center(
                  child: Text(
                    "Save Changes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: height * 0.05),
        ],
      ),
    );
  }
}