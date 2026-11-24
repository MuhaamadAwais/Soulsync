import 'package:faith/colorapp.dart';
import 'package:flutter/material.dart';

class Faqspage extends StatefulWidget {
  const Faqspage({super.key});

  @override
  State<Faqspage> createState() => _FaqspageState();
}

class _FaqspageState extends State<Faqspage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                height: height * 0.14,
                width: double.infinity,
                color: AppColors.emeraldGreen,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: width * 0.08,
                          height: width * 0.08,
                          decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.2),
                            border: Border.all(
                              width: 1,
                              color: AppColors.white,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              size: 18,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.03),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Help & FAQs",
                            style: TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "We're here to help you on your\nfaith journey",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Title Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColors.emeraldGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.question_mark,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "Frequently Asked Questions",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.03),
              // FAQs
              faqTile(
                "What is Faith Check?",
                "Faith Check helps users track prayers, dhikr, and daily Islamic activities.",
              ),

              SizedBox(height: height * 0.015),
              faqTile(
                "How do I track my prayers?",
                "Open the prayer section and mark each prayer as completed.",
              ),

              SizedBox(height: height * 0.015),
              faqTile(
                "Can I use the app offline?",
                "Yes, most features are available without an internet connection.",
              ),

              SizedBox(height: height * 0.015),
              faqTile(
                "Is my data secure?",
                "Yes, your data is stored securely and protected.",
              ),

              SizedBox(height: height * 0.015),
              faqTile(
                "How do I reset my password?",
                "Go to Settings > Privacy & Security > Change Password.",
              ),

              SizedBox(height: height * 0.015),
              faqTile(
                "How can I contact support?",
                "You can contact us through the Help & Support section inside the app.",
              ),
              SizedBox(height: height * 0.05),
            ],
          ),
        ),
      ),
    );
  }

  Widget faqTile(String question, String answer) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),

      child: ExpansionTile(
        shape: Border(),
        collapsedShape: Border(),
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        iconColor: AppColors.emeraldGreen,
        collapsedIconColor: AppColors.emeraldGreen,
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
