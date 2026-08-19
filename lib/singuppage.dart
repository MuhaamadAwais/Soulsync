import 'package:faith/colorapp.dart';
import 'package:faith/profile_feature/presentation/widget/profilepage.dart';
import 'package:faith/signinpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Singuppage extends StatefulWidget {
  const Singuppage({super.key});

  @override
  State<Singuppage> createState() => _SinguppageState();
}

class _SinguppageState extends State<Singuppage> {
  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      throw Exception("Passwords do not match");
    }

    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      // Full Name Firebase user profile mein save
      await credential.user?.updateDisplayName(fullName.trim());

      print("Sign Up Successful");
    } on FirebaseAuthException catch (e) {
      print(e.code);
      rethrow;
    }
  }

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: width,
                height: height * 0.35,
                color: AppColors.emeraldGreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Assalamu Alaikum",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "Create Account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.28),
                width: width,
                height: height * 0.72,
                color: Colors.grey.shade100,
              ),
              Positioned(
                top: height * 0.23,
                left: 10,
                right: 10,
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    height: height * 0.6,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          width: width * 0.8,
                          height: height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: TextField(
                            controller: _namecontroller,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: AppColors.emeraldGreen,
                              ),
                              hintText: "Full Name",
                            ),
                          ),
                        ),

                        SizedBox(height: 15),
                        Container(
                          width: width * 0.8,
                          height: height * 0.07,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: TextField(
                              controller: _emailcontroller,
                              textAlignVertical: TextAlignVertical.center,
                              // obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: AppColors.emeraldGreen,
                                ),
                                hint: Text("Email"),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: width * 0.8,
                          height: height * 0.07,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: TextField(
                              controller: _passwordcontroller,
                              textAlignVertical: TextAlignVertical.center,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: AppColors.emeraldGreen,
                                ),
                                hint: Text("Password"),
                                suffixIcon: Icon(Icons.visibility_outlined),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 15),
                        Container(
                          width: width * 0.8,
                          height: height * 0.07,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                          ),
                          child: Center(
                            child: TextField(
                              controller: _confirmpasswordcontroller,
                              textAlignVertical: TextAlignVertical.center,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: AppColors.emeraldGreen,
                                ),
                                hint: Text("Confirm  Password"),
                                suffixIcon: Icon(Icons.visibility_outlined),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        SizedBox(height: 20),
                        InkWell(
                          onTap: () async {
                            await signUp(
                              fullName: _namecontroller.text,
                              email: _emailcontroller.text,
                              password: _passwordcontroller.text,
                              confirmPassword: _confirmpasswordcontroller.text,
                            );
                            if (mounted) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => Profilepage(),
                                ),
                                (route) => false,
                              );
                            }
                          },
                          child: Container(
                            width: width * 0.75,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.gold,
                            ),
                            child: Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: width * 0.3,
                              child: Divider(
                                thickness: 1,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            Text(
                              "OR",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.34,
                              child: Divider(
                                thickness: 1,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: width * 0.02),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => Signinpage(),
                                  ),
                                  (route) => false,
                                );
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: AppColors.emeraldGreen,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
