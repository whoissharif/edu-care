import 'package:edu_care/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Rx<User?> user = Rx<User?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    user.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print("Error signing up with email and password: $e");
      Get.snackbar('Error', 'Failed to sign up. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // Navigate to the dashboard on successful sign-in
      Get.offAllNamed(Routes.DASHBOARD);
    } catch (e) {
      print("Error signing in with email and password: $e");
      Get.snackbar('Error', 'Failed to sign in. Check your credentials.');
    } finally {
      isLoading.value = false;
    }
  }

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
      // Navigate to the dashboard on successful sign-in
      Get.offAllNamed(Routes.DASHBOARD);
    } catch (e) {
      print("Error signing in with Google: $e");
      Get.snackbar('Error', 'Failed to sign in with Google.');
    } finally {}
  }

  Future<void> signOut() async {
    try {
      isLoading.value = true;
      await _auth.signOut();
      await googleSignIn.signOut();
      Get.offAllNamed(Routes.AUTH);
    } catch (e) {
      print("Error signing out: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
