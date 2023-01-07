
import 'package:flutter/material.dart';
import 'package:geteat/views/main_sign_page.dart';
import 'package:geteat/views/signup/signup_code_page.dart';
import 'package:geteat/views/signup/signup_name_page.dart';
import 'package:geteat/views/signup/signup_password_page.dart';

import 'themes/main_theme.dart';


void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      title: 'GetEat',
      theme: mainTheme.defaultTheme,
    );
  }
}


// Route class
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //UserConnection userConnection = UserConnection();
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const MainSignPage());
        /*return MaterialPageRoute(
            builder: (context) => StreamBuilder(
                  stream: userConnection.userStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        //if a user is connected show the client page
                        return MainScreen();
                      } else {
                        //if not showing sign in page
                        return SignInPage();
                      }
                    }
                    
                    return Container();
                  },
                ));*/
      case '/signup_code':
        return MaterialPageRoute(builder: (context) => const SignupCodePage());
      case '/signup_name':
        return MaterialPageRoute(builder: (context) => const SignupNamePage());
        case '/signup_password':
        return MaterialPageRoute(builder: (context) => const SignupPasswordPage());
     /* case '/newPost/confirmation':
        return MaterialPageRoute(
            builder: (context) => const NewPostConfirmationPage());
      case '/post':
        return MaterialPageRoute(
            builder: (context) =>
                PostPage(post: settings.arguments as PostModel));
      case '/channel':
        return MaterialPageRoute(
            builder: (context) =>
                ChannelPage(channel: settings.arguments as ChannelModel));
      case '/signup':
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case '/loading':
        if (settings.arguments != null) {
          Map<String, dynamic>? args =
              settings.arguments as Map<String, dynamic>;
          String? text = args.containsKey('text') ? args['text'] : null;
          Duration timeOffset = args.containsKey('timeOffset')
              ? args['timeOffset']
              : Duration.zero;
          Function()? callBack =
              args.containsKey('callBack') ? args['callBack'] : null;
          return MaterialPageRoute(
              builder: (context) => LoaderPage(
                    text: text,
                    timeOffset: timeOffset,
                    callBack: callBack,
                  ));
        } else {
          return MaterialPageRoute(
              builder: (context) => LoaderPage(
                    timeOffset: Duration(seconds: 1),
                  ));
        }
      */
      default:
        return MaterialPageRoute(builder: (context) => Container());
    }
  }
}
