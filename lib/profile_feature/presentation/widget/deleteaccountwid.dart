
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faith/colorapp.dart';
import 'package:faith/signinpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Deleteaccountwid extends StatelessWidget {
  const Deleteaccountwid({super.key});

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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => _deleteAccount(context),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: width * 0.85,
          height: height * 0.06,
          decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(
              width: 1,
              color: Colors.red.withOpacity(0.2),
            ),
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
                child: const Center(
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(width: width * 0.02),
              const Text(
                'Delete Account',
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
