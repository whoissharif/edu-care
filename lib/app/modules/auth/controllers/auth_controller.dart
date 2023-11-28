import 'package:edu_care/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Controller for handling authentication operations.
class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  /// Reactive variable to hold the current user.
  Rx<User?> user = Rx<User?>(null);

  /// Reactive variable to indicate loading state.
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    // Bind the user stream to the reactive variable.
    user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  /// Sign up a new user with email and password.
  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      // Display an error snackbar if sign-up fails.
      if (Get.isSnackbarOpen != true) {
        Get.snackbar('Error', 'Failed to sign up. Please try again.');
      }
    } finally {
      isLoading.value = false;
      // Navigate to the authentication page and display a success snackbar.
      if (Get.isSnackbarOpen != true) {
        Get.offAllNamed(Routes.AUTH);
        Get.snackbar('Success', 'Sign up successful!\nNow login to continue');
      }
    }
  }

  /// Sign in a user with email and password.
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // Navigate to the dashboard on successful sign-in.
      Get.offAllNamed(Routes.DASHBOARD);
    } catch (e) {
      // Display an error snackbar if sign-in fails.
      if (Get.isSnackbarOpen != true) {
        Get.snackbar('Error', 'Failed to sign in. Check your credentials.');
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Sign in a user with Google authentication.
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);
      // Navigate to the dashboard on successful sign-in.
      Get.offAllNamed(Routes.DASHBOARD);
    } catch (e) {
      // Display an error snackbar if sign-in with Google fails.
      if (Get.isSnackbarOpen != true) {
        Get.snackbar('Error', 'Failed to sign in with Google.');
      }
    } finally {}
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    try {
      isLoading.value = true;
      await _auth.signOut();
      await googleSignIn.signOut();
      // Navigate to the authentication page on successful sign-out.
      Get.offAllNamed(Routes.AUTH);
    } catch (e) {
      print("Error signing out: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
