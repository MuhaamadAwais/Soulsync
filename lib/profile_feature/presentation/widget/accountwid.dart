import 'package:faith/colorapp.dart';
import 'package:faith/profile_feature/presentation/pages/editprofilepage.dart';
import 'package:faith/profile_feature/presentation/pages/faqspage.dart';
import 'package:flutter/material.dart';

class Accountwid extends StatefulWidget {
  const Accountwid({super.key});

  @override
  State<Accountwid> createState() => _AccountwidState();
}

bool notification = false;

class _AccountwidState extends State<Accountwid> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: width,
          height: height * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.white,
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                designsss(
                  height * 0.07,
                  height * 0.07,
                  Icons.manage_accounts_outlined,
                  "Edit Profile",
                  "Update your personal info",
                  () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Editprofilepage(),
                      ),
                    );
                  },
                ),
                Divider(color: Colors.grey.shade100, thickness: 3),
                designsnotification(
                  height * 0.07,
                  height * 0.07,
                  Icons.notifications_outlined,
                  "Notifications",
                  "Prayer times & reminders",
                  notification,
                ),

                Divider(color: Colors.grey.shade100, thickness: 3),
                designsss(
                  height * 0.07,
                  height * 0.07,
                  Icons.help_outline,
                  "Help & Support",
                  "FAQs, contact us",
                  () {
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => Faqspage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget designsss(
    double width,
    double height,
    IconData iconssele,
    String heading,
    String titles,
    VoidCallback onTabs,
  ) {
    return GestureDetector(
      onTap: onTabs,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.emeraldGreen.withOpacity(0.2),
              ),
              child: Icon(iconssele, color: AppColors.emeraldGreen),
            ),
          ),
          SizedBox(width: width * 0.2),
          Expanded(
            flex: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                Text(
                  titles,
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget designsnotification(
    double width,
    double height,
    IconData iconssele,
    String heading,
    String titles,
    bool off,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.emeraldGreen.withOpacity(0.2),
            ),
            child: Icon(iconssele, color: AppColors.emeraldGreen),
          ),
        ),
        SizedBox(width: width * 0.2),
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                heading,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              Text(
                titles,
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Switch(
            value: off,
            activeColor: AppColors.emeraldGreen, // Thumb ON
            activeTrackColor: AppColors.emeraldGreen.withOpacity(
              0.4,
            ), // Track ON
            inactiveThumbColor: AppColors.black,
            inactiveTrackColor: AppColors.black.withOpacity(0.25),
            onChanged: (value) {
              setState(() {
                notification = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
