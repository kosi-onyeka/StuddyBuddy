import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:studdy_bestie/resources/auth_methods.dart';
import 'package:studdy_bestie/resources/stored_data.dart';
import 'package:studdy_bestie/screens/login_screen.dart';
import 'package:studdy_bestie/utils/colors.dart';
import 'package:studdy_bestie/utils/dimensions.dart';
import 'package:studdy_bestie/widgets/previous_sessions.dart';
import 'package:studdy_bestie/widgets/text_field_input.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

void logOutUser(BuildContext context) async {
  await AuthMethods().logOutUser();
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const LoginInScreen()));
}

class _LandingScreenState extends State<LandingScreen> {
  String username = "";
  @override
  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        //leading: const Icon(Icons.menu),
        title: const Text('Home'),
        actions: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: 36,
              width: 36,
              child: const Icon(Icons.person),
            ),
          )
        ],
      ),
      drawer: LandingScreenDrawer(context: context, username: username),
      body: SafeArea(
        child: Column(children: [
          InkWell(
            onTap: () {
              newStudySessionSheet(context: context);
            },
            child: Container(
                height: rowObjectSize,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/background.png'),
                      fit: BoxFit.cover),
                  color: primaryColorPalette,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsetsDirectional.all(25),
                child: const Center(child: Text('Start New Study Session'))),
          ),
          const Center(child: Text("Previous Sessions")),
          Flexible(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: EdgeInsets.all(20),
              children: const [
                PreviousSessions(sessionName: 'Math'),
                PreviousSessions(sessionName: "English"),
                PreviousSessions(sessionName: "Physics")
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Future<dynamic> newStudySessionSheet({required BuildContext context}) {
    return showModalBottomSheet(
      backgroundColor: Colors.grey[500],
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: 600,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 48,
                        ),
                        TextFieldInput(
                            textEditingController: TextEditingController(),
                            hintText: "Enter Study Session name",
                            textInputType: TextInputType.name),
                        const SizedBox(
                          height: 48,
                        ),
                        TextFieldInput(
                            textEditingController: TextEditingController(),
                            hintText: " Whats your main goal for this Session?",
                            textInputType: TextInputType.name),
                        const SizedBox(
                          height: 48,
                        ),
                        TextFieldInput(
                            textEditingController: TextEditingController(),
                            hintText: "Set timer intervals",
                            textInputType: TextInputType.name)
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.9, 0.9),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColorPalette),
                    child: const Text('Lets learn!'),
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ));
      },
    );
  }
}

class LandingScreenDrawer extends StatefulWidget {
  const LandingScreenDrawer({
    Key? key,
    required BuildContext context,
    required String username,
  }) : super(key: key);

  @override
  State<LandingScreenDrawer> createState() => _LandingScreenDrawerState();
}

class _LandingScreenDrawerState extends State<LandingScreenDrawer> {
  final User? _user = FirebaseAuth.instance.currentUser;
  String currUsername = "";
  @override
  void initState() {
    super.initState();
    getUsername();
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      currUsername = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            //NEXTSTEP: pull username for data base and display in drawer
            accountName: (Text('Welcome ' '$currUsername' '!')),
            accountEmail: Text((_user?.email).toString()),
            currentAccountPicture:
                const CircleAvatar(backgroundColor: Colors.black),
            decoration: const BoxDecoration(color: primaryColorPalette),
          ),
          Flexible(
            flex: 1,
            child: Container(),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Sign out"),
            onTap: () {
              logOutUser(context);
            },
          )
        ],
      ),
    );
  }
}
