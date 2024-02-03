import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/cupertino.dart';

class SplashScreeProvider extends ChangeNotifier{

  checkIfUserIsLoggedIn()  {
    final _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    bool isOneDayOlder = checkLastLoggedTime(user);
    //check for log
    if(isOneDayOlder){
      return true;
    }else{
      return false;
    }

  }

  bool checkLastLoggedTime(User? user) {
    if (user != null) {
      // Access user metadata
      UserMetadata? metadata = user.metadata;
      // Get the last sign-in time
      DateTime lastSignInTime = metadata?.lastSignInTime ?? DateTime.now();
      // Get the current date and time
      DateTime currentDate = DateTime.now();
      // Calculate the difference in days
      int differenceInDays = currentDate.difference(lastSignInTime).inDays;
      // Return true if the difference is greater than or equal to 1 (user not logged in for 1 day)
      return differenceInDays > 1 ? false : true;
    } else {
      // User is not logged in, return false
      return false;
    }
  }

}