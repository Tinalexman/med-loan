import 'package:go_router/go_router.dart';
import 'package:med_loan/pages/auth/kyc.dart';
import 'package:med_loan/pages/auth/login.dart';
import 'package:med_loan/pages/auth/register.dart';

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
  )
];
