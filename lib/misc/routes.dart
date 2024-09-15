import 'package:go_router/go_router.dart';
import 'package:med_loan/pages/auth/kyc.dart';
import 'package:med_loan/pages/auth/login.dart';
import 'package:med_loan/pages/auth/register.dart';
import 'package:med_loan/pages/auth/upload_image.dart';
import 'package:med_loan/pages/home/home.dart';
import 'package:med_loan/pages/profile/profile.dart';

import 'constants.dart';

final List<GoRoute> routes = [
  GoRoute(
    path: Pages.login.path,
    name: Pages.login,
    builder: (_, __) => const LoginPage(),
  ),
  GoRoute(
    path: Pages.register.path,
    name: Pages.register,
    builder: (_, __) => const RegisterPage(),
  ),
  GoRoute(
    path: Pages.kyc.path,
    name: Pages.kyc,
    builder: (_, __) => const KYCPage(),
  ),
  GoRoute(
    name: Pages.uploadImage,
    path: Pages.uploadImage.path,
    builder: (_, state) => UploadImage(data: state.extra as Map<String, String>),
  ),
  GoRoute(
    name: Pages.home,
    path: Pages.home.path,
    builder: (_, __) => const Homepage(),
  ),
  GoRoute(
    name: Pages.profile,
    path: Pages.profile.path,
    builder: (_, __) => const ProfilePage(),
  )
];
