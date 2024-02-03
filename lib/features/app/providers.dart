
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:video_post/features/login&singup/login_page_provider.dart';
import 'package:video_post/features/splash_screen/splash_screen.dart';

class Providers {
static List<SingleChildWidget> getAllProviders() {
  List<SingleChildWidget> _providers = [
    ChangeNotifierProvider(create: (context) => SplashScreeProvider()),

  ];
  return _providers;
}
}