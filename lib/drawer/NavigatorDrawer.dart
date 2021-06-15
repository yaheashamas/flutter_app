import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../screens/LoginScreen.dart';
import 'package:provider/provider.dart';

class NavigatorDrawer extends StatefulWidget {
  NavigatorDrawer({Key key}) : super(key: key);

  @override
  _NavigatorDrawerState createState() => _NavigatorDrawerState();
}

class _NavigatorDrawerState extends State<NavigatorDrawer> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return Auth();
      },
      child: Container(
        child: Drawer(
          child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 15),
              child: ListView(
                children: [
                  ListTile(
                    title: Text(
                      "اضافة عقار",
                      style: TextStyle(fontSize: 18),
                    ),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                  Consumer<Auth>(builder: (context, provider, child) {
                    return ListTile(
                      title: Text(
                        "تسجيل خروج",
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        /*click logout code move to page {auth} to function logout
                      * chane authintication ture => false
                      */
                        provider.logout();
                        // Provider.of<Auth>(context ,listen: false).logout();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                    );
                  }),
                ],
              )),
        ),
      ),
    );
  }
}
