//  Koşul kuralları

import 'package:crud_operations/core/widgets/snackbar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

const firebaseAuthExceptionRulesRegister = {
  'email-already-in-use': 'E-posta Zaten Kullanılıyor',
  'wrong-password': 'Hatalı Şifre',
  'weak-password': 'zayıf şifre: minimum 6 karakter giriniz.',
  'invalid-email': 'Geçersiz E-posta',
};

const firebaseAuthExceptionRulesLogin = {
  'invalid-email': 'Geçersiz E-posta',
  'wrong-password': 'Hatalı Şifre',
  'user-not-found': 'Kullanıcı Bulunamadı',
  'network-request-failed': 'Ağ Hatası',
  'too-many-requests': 'Çok Fazla İstek',
};

String forgotPasswordRules(FirebaseAuthException e, String message, context) {
  if (e.code == "invalid-email") {
    message = "Geçersiz e-posta";
  } else if (e.code == "network-request-failed") {
    message = "Ağ Hatası";
  } else if (e.code == "user-not-found") {
    message = "Kullanıcı bulunamadı.";
  }
  snackBarMessage(context, message);
  return message;
}
