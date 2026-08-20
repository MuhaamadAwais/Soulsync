import 'package:faith/colorapp.dart';
import 'package:faith/signinpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Logoutwid extends StatelessWidget {
  const Logoutwid({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> logout() async {
      try {
        await FirebaseAuth.instance.signOut();
        print("Logout successful");
      } on FirebaseAuthException catch (e) {
        print("Logout error: ${e.message}");
      }
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () async {
        await logout();
        if (context.mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Signinpage()),
            (route) => false,
          );
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          width: width * 0.85,
          height: height * 0.06,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(width: 1, color: Colors.red.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width * 0.1,
                height: width * 0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red.withOpacity(0.2),
                ),
                child: Center(child: Icon(Icons.logout, color: Colors.red)),
              ),
              SizedBox(width: width * 0.02),
              Text(
                "Log Out",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
