import 'package:go_router/go_router.dart';
import 'package:tukugo/auth/aadhar.dart';
import 'package:tukugo/auth/driving_license.dart';
import 'package:tukugo/auth/location.dart';
import 'package:tukugo/auth/vehicle_rc.dart';
import 'package:tukugo/auth/vehicle_selection_page.dart';
import 'package:tukugo/auth/verification_screen01.dart';
import 'package:tukugo/routes/route_constants.dart';
import 'package:tukugo/screen/home_screen.dart';



class MyAppRouter {
  GoRouter router = GoRouter(
    initialLocation: '/', // Ensure initialLocation points to SplashScreen
    routes: [
      // SplashScreen route
      GoRoute(
        name: MyAppRouteConstants.vehicle_selection_pageRouteName,
        path: '/',
        builder: (context, state) =>
            VehicleSelectionPage(), // Show VehicleSelectionPage
      ),

      
      GoRoute(
        name: MyAppRouteConstants.verification_screen01RouteName,
        path: '/verificationscreen01',
        builder: (context, state) => VerificationScreen01(),
      ),
    
      GoRoute(
        name: MyAppRouteConstants.driving_licenseRouteName,
        path: '/driving_license',
        builder: (context, state) => LicenseUploadPage(),
      ),
      GoRoute(
        name: MyAppRouteConstants.locationRouteName,
        path: '/location/access',
        builder: (context, state) => LocationAccessScreen(),
      ),
     
      GoRoute(
        name: MyAppRouteConstants.vehicle_rcRouteName,
        path: '/vehiclerc',
        builder: (context, state) => VehicleRc(),
      ),
      GoRoute(
        name: MyAppRouteConstants.aadharRouteName,
        path: '/aadhar',
        builder: (context, state) => AadhaarUploadPage(),
      ),
      
      GoRoute(
        name: MyAppRouteConstants.home_screenRouteName,
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
