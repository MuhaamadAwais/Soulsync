import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faith/colorapp.dart';
import 'package:faith/profile_feature/presentation/provider/nameprovider.dart';
import 'package:faith/profile_feature/presentation/widget/accountwid.dart';
import 'package:faith/profile_feature/presentation/widget/namewid.dart';
import 'package:faith/signinpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profilepagemain extends StatelessWidget {
  const Profilepagemain({super.key});
  @override
  Widget build(BuildContext context) {
    final name = context.watch<Nameprovider>().name;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.emeraldGreen,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: AppColors.white),
            color: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) {
              if (value == 'logout') {
                _showLogoutDialog(context);
              } else if (value == 'delete') {
                _deleteAccount(context);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, size: 20),
                    SizedBox(width: 10),
                    Text('Logout'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 20, color: Colors.red),
                    SizedBox(width: 10),
                    Text('Delete Account', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: width,
                  height: height * 0.15,
                  color: AppColors.emeraldGreen,
                ),
        
                Positioned(
                  bottom: -35,
                  child: Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      border: Border.all(
                        color: AppColors.emeraldGreen,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.emeraldGreen,
                        ),
                        child: Center(
                          child: Text(
                            name.isNotEmpty ? name[0] : "",
                            style: TextStyle(
                              fontSize: 30,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Center(child: Namewid()),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 16),
              child: Text(
                "Account",
                style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            Accountwid(),
        
            
          ],
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: Text(
            "Confirm logout",
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),

            TextButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Signinpage()),
                    (route) => false,
                  );
                }
              },
              child: Text("ok"),
            ),
          ],
        );
      },
    );
  }
 
  Future<void> _deleteAccount(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login first.')),
      );
      return;
    }

    // Confirmation dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          title: Text(
            'Confirm Delete Account',
            style: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: const Text(
            'Are you sure you want to permanently delete your account?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirm != true || !context.mounted) return;

    // Show loading dialog
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final uid = user.uid;

      // Delete user document from Firestore if it exists
      final userDoc = FirebaseFirestore.instance
          .collection('users')
          .doc(uid);

      final docSnapshot = await userDoc.get();

      if (docSnapshot.exists) {
        await userDoc.delete();
      }

      // Delete Firebase Authentication account
      await user.delete();

      if (!context.mounted) return;

      // Close loading dialog
      Navigator.of(context, rootNavigator: true).pop();

      // Navigate to Signinpage and remove previous screens
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Signinpage(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e, stackTrace) {
      debugPrint('AUTH DELETE ERROR: ${e.code} - ${e.message}');
      debugPrintStack(stackTrace: stackTrace);

      if (!context.mounted) return;

      // Close loading dialog
      Navigator.of(context, rootNavigator: true).pop();

      final message = e.code == 'requires-recent-login'
          ? 'Please log out, log in again, and retry account deletion.'
          : 'Authentication error: ${e.code}';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 6),
        ),
      );
    } on FirebaseException catch (e, stackTrace) {
      debugPrint('FIREBASE ERROR: ${e.code} - ${e.message}');
      debugPrintStack(stackTrace: stackTrace);

      if (!context.mounted) return;

      // Close loading dialog
      Navigator.of(context, rootNavigator: true).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Firebase error: ${e.code}'),
          duration: const Duration(seconds: 6),
        ),
      );
    } catch (e, stackTrace) {
      debugPrint('DELETE ACCOUNT ERROR: $e');
      debugPrintStack(stackTrace: stackTrace);

      if (!context.mounted) return;

      // Close loading dialog
      Navigator.of(context, rootNavigator: true).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Account deletion failed. Please try again.',
          ),
          duration: Duration(seconds: 6),
        ),
      );
    }
  }

}
