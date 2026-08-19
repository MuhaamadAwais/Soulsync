import 'package:faith/colorapp.dart';
import 'package:flutter/material.dart';

class Inputfielsdwid extends StatefulWidget {
  const Inputfielsdwid({super.key});

  @override
  State<Inputfielsdwid> createState() => _InputfielsdwidState();
}

class _InputfielsdwidState extends State<Inputfielsdwid> {
  String selectedGender = "Male";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "FULL NAME",
              style: TextStyle(color: AppColors.black, fontSize: 14),
            ),
          ),
          SizedBox(height: height * 0.01),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
            ),
            child: Center(
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.emeraldGreen,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.grey,
                  ),
                  hint: Text("Name"),
                ),
              ),
            ),
          ),

          SizedBox(height: height * 0.02),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "EMAIL ADDRESS",
              style: TextStyle(color: AppColors.black, fontSize: 14),
            ),
          ),
          SizedBox(height: height * 0.01),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.white,
            ),
            child: Center(
              child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.emeraldGreen,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                  hint: Text("Email"),
                ),
              ),
            ),
          ),

          SizedBox(height: height * 0.03),
          Divider(height: 5, color: Colors.grey),

          SizedBox(height: height * 0.02),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "GENDER",
              style: TextStyle(color: AppColors.black, fontSize: 14),
            ),
          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedGender = "Male";
                  });
                },
                child: Container(
                  width: width * 0.45,
                  height: height * 0.065,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: selectedGender == "Male"
                          ? Colors.grey
                          : AppColors.emeraldGreen,
                    ),
                    color: selectedGender == "Male"
                        ? AppColors.white
                        : AppColors.emeraldGreen,
                  ),
                  child: Center(
                    child: Text(
                      "Male",
                      style: TextStyle(
                        color: selectedGender == "Male"
                            ? AppColors.black
                            : AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(width: width * 0.04),

              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedGender = "Female";
                  });
                },
                child: Container(
                  width: width * 0.45,
                  height: height * 0.065,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: selectedGender == "Female"
                          ? Colors.grey
                          : AppColors.emeraldGreen,
                    ),
                    color: selectedGender == "Female"
                        ? AppColors.white
                        : AppColors.emeraldGreen,
                  ),
                  child: Center(
                    child: Text(
                      "Female",
                      style: TextStyle(
                        color: selectedGender == "Female"
                            ? AppColors.black
                            : AppColors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: height * 0.03),
          Divider(height: 5, color: Colors.grey),

          SizedBox(height: height * 0.03),
          Center(
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Save changes")));
                Navigator.pop(context);
              },
              child: Container(
                width: width*0.7,
                height: height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.emeraldGreen,
                ),
                child: Center(
                  child: Text(
                    "Save Changes",
                    style: TextStyle(
                      color: AppColors.white,
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
