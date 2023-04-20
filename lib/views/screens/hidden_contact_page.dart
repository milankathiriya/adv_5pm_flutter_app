import 'package:contact_diary_5pm_app/controllers/providers/theme_provider.dart';
import 'package:contact_diary_5pm_app/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HiddenContactPage extends StatefulWidget {
  const HiddenContactPage({Key? key}) : super(key: key);

  @override
  State<HiddenContactPage> createState() => _HiddenContactPageState();
}

class _HiddenContactPageState extends State<HiddenContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hidden Contacts"),
        actions: [
          IconButton(
            icon: Icon(Icons.circle),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
          ),
        ],
      ),
      body: (Globals.hiddenContacts.isNotEmpty)
          ? ListView.builder(
              itemCount: Globals.hiddenContacts.length,
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('detail_page',
                        arguments: Globals.hiddenContacts[i]);
                  },
                  leading: CircleAvatar(radius: 30),
                  title: Text("${Globals.hiddenContacts[i].fullName}"),
                  subtitle: Text(
                      "${Globals.hiddenContacts[i].email}\n+91 ${Globals.hiddenContacts[i].phoneNumber}"),
                  trailing: IconButton(
                    icon: Icon(Icons.phone, color: Colors.green),
                    onPressed: () async {
                      await launchUrl(Uri.parse(
                          "tel:+91${Globals.hiddenContacts[i].phoneNumber}"));
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
    );
  }
}
