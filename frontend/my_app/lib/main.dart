import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/provider/user_provider.dart';
import 'package:my_app/views/screens/authentication_screens/login_screen.dart';
import 'package:my_app/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {

  runApp( ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  Future<void>_checkTokenAndSetUser(WidgetRef ref) async
  {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('auth_token');
    String? userJson = preferences.getString('user');
    if( token!=null && userJson!=null )
      {
        ref.read(userProvider.notifier).setUser(userJson);
      }
  }
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      // home: LoginScreen(),
      home:FutureBuilder(future: _checkTokenAndSetUser(ref), builder: (context,snapshot){

        if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(child: CircularProgressIndicator(),);
          }
        final user = ref.watch(userProvider);
        // return LoginScreen();
        print("user");
        print(user);
        return user !=  null? MainScreen():LoginScreen();

      }),
    );
  }
}

