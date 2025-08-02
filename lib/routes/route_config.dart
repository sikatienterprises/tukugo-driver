import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tukugo/auth/aadhar.dart';
import 'package:tukugo/auth/driving_license.dart';
import 'package:tukugo/auth/location.dart';
import 'package:tukugo/auth/vehicle_rc.dart';
import 'package:tukugo/auth/vehicle_selection_page.dart';
import 'package:tukugo/auth/verification_screen01.dart';
import 'package:tukugo/components/bottom_navbar.dart';
import 'package:tukugo/routes/route_constants.dart';
import 'package:tukugo/screen/drawer/aboutUs.dart';
import 'package:tukugo/screen/drawer/wallet.dart';
import 'package:tukugo/screen/history_screen.dart';
import 'package:tukugo/screen/home_screen.dart';
import 'package:tukugo/screen/notification_screen.dart';
import 'package:tukugo/screen/payment/paymentPage.dart';
import 'package:tukugo/screen/payment/qr_screen.dart';
import 'package:tukugo/screen/payment/success_screen.dart';
import 'package:tukugo/screen/otp-startRide.dart';
import 'package:tukugo/screen/drawer/change-password.dart';
import 'package:tukugo/screen/drawer/chat.dart';
import 'package:tukugo/screen/drawer/transaction.dart';
import 'package:tukugo/screen/drawer/contactUs.dart';
import 'package:tukugo/screen/drawer/method_selection.dart';
import 'package:tukugo/screen/drawer/add_money.dart';
import 'package:tukugo/screen/splash_screen.dart';
import 'package:tukugo/screen/phone_verification_screen.dart';
import 'package:tukugo/screen/otp-resetPassword.dart';
import 'package:tukugo/screen/set_password_screen.dart';
import 'package:tukugo/auth/login_screen.dart';
import 'package:tukugo/auth/register_screen.dart';
import 'package:tukugo/screen/open-splash.dart';
import 'package:tukugo/screen/drawer/profile_drawer.dart';

// class MyAppRouter {
//   GoRouter router = GoRouter(
//     initialLocation: '/', // Ensure initialLocation points to SplashScreen
//     routes: [
// GoRoute(
//   name: MyAppRouteConstants.vehicle_selection_pageRouteName,
//   path: '/',
//   builder: (context, state) =>
//       VehicleSelectionPage(), // Show VehicleSelectionPage
// ),

//       GoRoute(
//         name: MyAppRouteConstants.layout,
//         path: '/',
//         builder: (context, state) => Layout(),
//       ),

//       GoRoute(
//         name: MyAppRouteConstants.verification_screen01RouteName,
//         path: '/verificationscreen01',
//         builder: (context, state) => VerificationScreen01(),
//       ),

//       GoRoute(
//         name: MyAppRouteConstants.driving_licenseRouteName,
//         path: '/driving_license',
//         builder: (context, state) => LicenseUploadPage(),
//       ),
//       GoRoute(
//         name: MyAppRouteConstants.locationRouteName,
//         path: '/location/access',
//         builder: (context, state) => LocationAccessScreen(),
//       ),

//       GoRoute(
//         name: MyAppRouteConstants.vehicle_rcRouteName,
//         path: '/vehiclerc',
//         builder: (context, state) => VehicleRc(),
//       ),
//       GoRoute(
//         name: MyAppRouteConstants.aadharRouteName,
//         path: '/aadhar',
//         builder: (context, state) => AadhaarUploadPage(),
//       ),

//       GoRoute(
//         name: MyAppRouteConstants.home_screenRouteName,
//         path: '/home',
//         builder: (context, state) => HomeScreen(),
//       ),

//       GoRoute(
//         path: '/payment',
//         name: MyAppRouteConstants.paymentPageRouteName,
//         builder: (context, state) => const PaymentScreen(),
//         routes: [
//           GoRoute(
//             path: 'qr',
//             builder: (context, state) => QrScreen(),
//           ),
//           GoRoute(
//             path: 'payment-success',
//             builder: (context, state) => PaymentSuccessScreen(),
//           ),
//         ],
//       ),
//     ],
//   );
// }

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class MyAppRouter {
  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      // ✅ Auth/onboarding — outside layout
      GoRoute(
        path: '/',
        name: MyAppRouteConstants.vehicle_selection_pageRouteName,
        builder: (context, state) => VehicleSelectionPage(),
      ),
      GoRoute(
        path: '/verificationscreen01',
        name: MyAppRouteConstants.verification_screen01RouteName,
        builder: (context, state) => VerificationScreen01(),
      ),
      GoRoute(
        path: '/driving_license',
        name: MyAppRouteConstants.driving_licenseRouteName,
        builder: (context, state) => LicenseUploadPage(),
      ),
      GoRoute(
        path: '/location/access',
        name: MyAppRouteConstants.locationRouteName,
        builder: (context, state) => LocationAccessScreen(),
      ),
      GoRoute(
        path: '/vehiclerc',
        name: MyAppRouteConstants.vehicle_rcRouteName,
        builder: (context, state) => VehicleRc(),
      ),
      GoRoute(
        path: '/aadhar',
        name: MyAppRouteConstants.aadharRouteName,
        builder: (context, state) => AadhaarUploadPage(),
      ),

      // Main App with Bottom Navigation as layout starts here ( Atul ).
      // if want to overlay a class then use (context: Navigator.of(context, rootNavigator: true).context) in context of the class
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey, // ✅ overlays
        path: '/payment/qr',
        builder: (context, state) => QrScreen(),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/payment/success',
        builder: (context, state) => PaymentSuccessScreen(),
      ),
      GoRoute(
        name: MyAppRouteConstants.aboutUs,
        path: '/aboutus',
        builder: (context, state) => AboutUs(),
      ),
      GoRoute(
        name: MyAppRouteConstants.wallet,
        path: '/wallet',
        builder: (context, state) => MyWallet(),
      ),
      GoRoute(
        name: MyAppRouteConstants.paymentScreen,
        path: '/payment',
        builder: (context, state) => PaymentScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return Layout(child: child); // Bottom nav layout
        },
        routes: [
          GoRoute(
            path: '/home',
            name: MyAppRouteConstants.home_screenRouteName,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/home/profile',
            name: MyAppRouteConstants.profileScreen,
            builder: (context, state) => ProfileScreen(),
            // routes: [
            //   GoRoute(
            //     path: 'qr', // 👈 becomes /payment/qr
            //     builder: (context, state) => QrScreen(),
            //   ),
            //   GoRoute(
            //     path: 'payment-success',
            //     builder: (context, state) => PaymentSuccessScreen(),
            //   ),
            // ],
          ),
          GoRoute(
            path: '/ride-history',
            name: MyAppRouteConstants.rideHistory,
            builder: (context, state) => const PaymentHistory(),
          ),
          GoRoute(
            path: '/notifications',
            name: MyAppRouteConstants.notifications,
            builder: (context, state) => const Notifications(),
          ),
        ],
      ),
      GoRoute(
        path: '/otp/start/ride',
        name: MyAppRouteConstants.otpStartride,
        builder: (context, state) => OtpStartride(),
      ),
      GoRoute(
        path: '/auth/drawer/changepassword',
        name: MyAppRouteConstants.ChangePasswordScreen,
        builder: (context, state) => ChangePasswordScreen(),
      ),
      GoRoute(
        path: '/auth/drawer/chat',
        name: MyAppRouteConstants.chat,
        builder: (context, state) => ChatScreen(),
      ),
      GoRoute(
        path: '/auth/drawer/transactions',
        name: MyAppRouteConstants.transactions,
        builder: (context, state) => TransactionScreen(),
      ),
      GoRoute(
        path: '/auth/drawer/contactus',
        name: MyAppRouteConstants.contactUs,
        builder: (context, state) => ContactUsScreen(),
      ),
      GoRoute(
        path: '/auth/drawer/paymentmethod',
        name: MyAppRouteConstants.paymentMethodSelection,
        builder: (context, state) => PaymentMethodScreen(),
      ),
      GoRoute(
        path: '/auth/drawer/addmoney',
        name: MyAppRouteConstants.addMoney,
        builder: (context, state) => AddMoneyPage(),
      ),

      GoRoute(
        path: '/login/splash',
        name: MyAppRouteConstants.loginSplashScreen,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/login/set-password',
        name: MyAppRouteConstants.setPasswordRouteName,
        builder: (context, state) => SetPasswordScreen(),
      ),
      GoRoute(
        path: '/login/OTP/reset-password',
        name: MyAppRouteConstants.otpResetPasswordRouteName,
        builder: (context, state) => OtpResetpassword(),
      ),
      GoRoute(
        path: '/auth/phoneverification',
        name: MyAppRouteConstants.phoneVerificationRouteName,
        builder: (context, state) => PhoneVerificationScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        name: MyAppRouteConstants.registerRouteName,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        name: MyAppRouteConstants.loginRouteName,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/splash',
        name: MyAppRouteConstants.OpenSplashRouteName,
        builder: (context, state) => OpenSplashScreen(),
      ),
    ],
  );
}
