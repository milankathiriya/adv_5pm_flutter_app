import 'package:contact_diary_5pm_app/controllers/providers/theme_provider.dart';
import 'package:contact_diary_5pm_app/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalAuthentication localAuthentication = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: [
          IconButton(
            icon: Icon(Icons.circle),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () async {
              bool canCheckBiometrics =
                  await localAuthentication.canCheckBiometrics;
              bool isDeviceSupported =
                  await localAuthentication.isDeviceSupported();

              try {
                if (canCheckBiometrics || isDeviceSupported) {
                  bool isAuthenticated = await localAuthentication.authenticate(
                      localizedReason:
                          "Authenticate your identity with your biometric...");

                  if (isAuthenticated) {
                    Navigator.of(context).pushNamed('hidden_contact_page');
                  } else {
                    print("***********************");
                    print("Authentication is failed...");
                    print("***********************");
                  }
                } else {
                  print("*******************");
                  print("Biometric not supported...");
                  print("*******************");
                }
              } on PlatformException catch (e) {
                print("*******************");
                print("${e.code}");
                print("*******************");
              }
            },
          ),
          // PopupMenuButton(
          //   itemBuilder: (context) {
          //     return [
          //       PopupMenuItem(child: Text("First")),
          //       PopupMenuItem(
          //         child: Text("Hidden Page"),
          //         onTap: () async {
          //           Navigator.of(context).pop();
          //
          //           print("aaya sudhi to aave chhe...");
          //
          //           await Navigator.of(context)
          //               .pushNamed('hidden_contact_page');
          //         },
          //       ),
          //     ];
          //   },
          // ),
        ],
      ),
      body: (Globals.allContacts.isNotEmpty)
          ? ListView.builder(
              itemCount: Globals.allContacts.length,
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('detail_page',
                        arguments: Globals.allContacts[i]);
                  },
                  leading: CircleAvatar(radius: 30),
                  title: Text("${Globals.allContacts[i].fullName}"),
                  subtitle: Text(
                      "${Globals.allContacts[i].email}\n+91 ${Globals.allContacts[i].phoneNumber}"),
                  trailing: IconButton(
                    icon: Icon(Icons.phone, color: Colors.green),
                    onPressed: () async {
                      await launchUrl(Uri.parse(
                          "tel:+91${Globals.allContacts[i].phoneNumber}"));
                    },
                  ),
                );
              },
            )
          : Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_box_outlined,
                    size: 180,
                  ),
                  Text(
                    "You have no contacts yet",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('add_contact_page');
        },
      ),
    );
  }
}
