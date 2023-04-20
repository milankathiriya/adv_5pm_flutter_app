import 'package:contact_diary_5pm_app/models/contact.dart';
import 'package:contact_diary_5pm_app/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/providers/theme_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Contact contact = ModalRoute.of(context)!.settings.arguments as Contact;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
        actions: [
          IconButton(
            icon: Icon(Icons.circle),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Spacer(flex: 3),
                CircleAvatar(radius: 60),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    contact.fullName = "JAYNESH CHODVADIYA";
                    contact.email = "jaynesh@gmail.com";
                    contact.phoneNumber = "7894567895";

                    await Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);

                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    Globals.allContacts.remove(contact);

                    await Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);

                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(Icons.account_box),
                  onPressed: () async {
                    Globals.hiddenContacts.add(contact);
                    Globals.allContacts.remove(contact);

                    await Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);

                    setState(() {});
                  },
                ),
              ],
            ),
            Text("${contact.fullName}"),
            Text("+91 ${contact.phoneNumber}"),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  child: Icon(Icons.phone),
                  onPressed: () async {
                    await launchUrl(Uri.parse("tel:+91${contact.phoneNumber}"));
                  },
                ),
                FloatingActionButton(
                  child: Icon(Icons.message),
                  onPressed: () async {
                    await launchUrl(Uri.parse("sms:+91${contact.phoneNumber}"));
                  },
                ),
                FloatingActionButton(
                  child: Icon(Icons.email),
                  onPressed: () async {
                    await launchUrl(Uri.parse(
                        "mailto:${contact.email}?subject=Hello ${contact.fullName}&body=How are you!"));
                  },
                ),
                FloatingActionButton(
                  child: Icon(Icons.share),
                  onPressed: () async {
                    await Share.share(
                        "${contact.fullName}: +91 ${contact.phoneNumber}");
                  },
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
