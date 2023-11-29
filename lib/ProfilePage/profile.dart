import 'package:e_commerce_ui/ProfilePage/login_screen.dart';
import 'package:e_commerce_ui/ProfilePage/recent_viewed.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'You',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 60,
                  child: Text(
                    'N',
                    style: TextStyle(fontSize: 60, color: Colors.white),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Netto Ryuki',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          const ListTile(
            leading: Icon(
              Icons.list_alt,
              color: Colors.blue,
            ),
            title: Text(
              'My Purchases',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RecentProductScreen()));
            },
            leading: Icon(
              Icons.access_time,
              color: Colors.blue,
            ),
            title: Text(
              'Recently Viewed',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.payment,
              color: Colors.blue,
            ),
            title: Text(
              'Payment Details',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            title: Text(
              'My Account',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            leading: Icon(
              Icons.logout,
              color: Colors.blue,
            ),
            title: Text(
              'Log Out',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
