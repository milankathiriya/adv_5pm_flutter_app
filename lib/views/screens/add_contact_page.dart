import 'package:contact_diary_5pm_app/models/contact.dart';
import 'package:contact_diary_5pm_app/utils/globals.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/providers/theme_provider.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({Key? key}) : super(key: key);

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  int currentStepperValue = 0;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add"),
        actions: [
          IconButton(
            icon: Icon(Icons.circle),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
          ),
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              String fullName = fullNameController.text;
              String email = emailController.text;
              String phoneNumber = phoneController.text;

              Contact c1 = Contact(
                  fullName: fullName, email: email, phoneNumber: phoneNumber);

              Globals.allContacts.add(c1);

              await Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);

              setState(() {});
            },
          ),
        ],
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: currentStepperValue,
        // controlsBuilder: (context, controlDetails) {
        //   return Container();
        // },
        onStepContinue: () {
          setState(() {
            if (currentStepperValue < 3) {
              currentStepperValue++;
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (currentStepperValue > 0) {
              currentStepperValue--;
            }
          });
        },
        onStepTapped: (val) {},
        steps: [
          Step(
            title: Text("Pick Image"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey,
                      child: Text("Add"),
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.add),
                      mini: true,
                    ),
                  ],
                ),
              ],
            ),
            isActive: (currentStepperValue >= 0) ? true : false,
            state: StepState.editing,
          ),
          Step(
            title: Text("Full Name"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter full name here...",
                      labelText: "Full Name",
                    ),
                  ),
                ),
              ],
            ),
            isActive: (currentStepperValue >= 1) ? true : false,
            state: StepState.editing,
          ),
          Step(
            title: Text("Phone Number"),
            isActive: (currentStepperValue >= 2) ? true : false,
            state: StepState.editing,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter phone no. here...",
                      labelText: "Phone No.",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Step(
            title: Text("Email"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter your email here...",
                      labelText: "Email",
                    ),
                  ),
                ),
              ],
            ),
            isActive: (currentStepperValue >= 3) ? true : false,
            state: StepState.complete,
          ),
        ],
      ),
    );
  }
}
