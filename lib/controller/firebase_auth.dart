import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final uid = ''.obs;
  final idToken = ''.obs;

  // メールアドレスとパスワードを使ってユーザー登録
  Future createUserWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print('Create user successful.');
      print('Email : ' + result.user!.email.toString());
      print('UserId : ' + result.user!.uid);
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar("エラー", e.message.toString(),
          backgroundColor: Colors.red.shade300);
    } catch (e) {
      Get.defaultDialog(
        title: "エラー",
        middleText: e.toString(),
        textCancel: "OK",
      );
    }
  }

  // メールアドレスとパスワードを使ってログイン
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('Login successful.');
      print('Email : ' + result.user!.email.toString());
      print('UserId : ' + result.user!.uid);
      uid.value = result.user!.uid;
      await auth.currentUser!.getIdToken().then((value) {
        idToken.value = value;
        print('idToken : ' + value);
      });
    } on FirebaseAuthException catch (e) {
      Get.back();
      Get.snackbar("エラー", e.message.toString(),
          backgroundColor: Colors.red.shade300);
    } catch (e) {
      Get.defaultDialog(
        title: "エラー",
        middleText: e.toString(),
        textCancel: "OK",
      );
    }
  }

  // Googleを使ってログイン
  Future signInWithGoogle() async {
    // 認証フローのトリガー
    final googleUser = await _googleSignIn.signIn();
    // リクエストから、認証情報を取得
    final googleAuth = await googleUser!.authentication;
    // クレデンシャルを新しく作成
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    Get.toNamed('/registar');
    Get.snackbar("通知", "ログインに成功しました");
    // ログインしたら、UserCredentialを返す
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  // ログアウト
  Future signOut() async {
    try {
      await auth.signOut();
      // await _googleSignIn.signOut();
      uid.value = '';
      idToken.value = '';
      Get.toNamed('/login');
      Get.snackbar("通知", "ログアウトに成功しました",
          backgroundColor: Colors.green.shade300);
    } catch (e) {
      Get.defaultDialog(
        title: "エラー",
        middleText: e.toString(),
        textCancel: "OK",
      );
    }
  }

  Future checkLoginState() async {
    if (auth.currentUser == null)
      return false;
    else {
      uid.value = auth.currentUser!.uid;
      await auth.currentUser!.getIdToken().then((value) {
        idToken.value = value;
      });
      return true;
    }
  }
}
