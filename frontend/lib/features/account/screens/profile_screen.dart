import 'package:dreamers/constants/global_variables.dart';
import 'package:dreamers/features/auth/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dreamers/providers/story_provider.dart';
import 'package:flutter/material.dart';
import 'package:dreamers/features/account/services/profile_service.dart';
import 'package:dreamers/features/account/screens/profile_screen_widget.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:dreamers/features/account/screens/update_profile_screen.dart';

class AccountScreen extends StatefulWidget {
  static const String routeName = '/profile-screen';
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final AuthService authService = AuthService();
  final ProfileServices profileServices = ProfileServices();

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<StoryProvider>(context).profile;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                          '$uri/static/images${userModel[0].profileImage}'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Text("${userModel[0].user}",
              Text("Bukayo Saka",
                  style: GoogleFonts.ubuntu(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              Text(userModel[0].introduction,
                  style: GoogleFonts.ubuntu(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400)),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.pushNamed(context, UpdateProfileScreen.routeName)
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xfffca5a5)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  child: Text("Edit Profile",
                      style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 15)),
                ),
              ),
              const SizedBox(height: 30),
              ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xfffca5a5),
                    ),
                    child:
                        const Icon(LineAwesomeIcons.cog, color: Colors.white),
                  ),
                  title: Text("Donations Made",
                      style: GoogleFonts.ubuntu(
                          color: Colors.black, fontWeight: FontWeight.w400)),
                  trailing: Text("${userModel[0].donationsMade}",
                      style: GoogleFonts.ubuntu(
                          color: Colors.black, fontWeight: FontWeight.w600))),
              ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xfffca5a5),
                    ),
                    child: const Icon(LineAwesomeIcons.user_check,
                        color: Colors.white),
                  ),
                  title: Text("Story Made",
                      style: GoogleFonts.ubuntu(
                          color: Colors.black, fontWeight: FontWeight.w400)),
                  trailing: Text("${userModel[0].storyMade}",
                      style: GoogleFonts.ubuntu(
                          color: Colors.black, fontWeight: FontWeight.w600))),
              ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xfffca5a5),
                    ),
                    child: const Icon(LineAwesomeIcons.wallet,
                        color: Colors.white),
                  ),
                  title: Text("Total Donations Size",
                      style: GoogleFonts.ubuntu(
                          color: Colors.black, fontWeight: FontWeight.w400)),
                  trailing: Text("${userModel[0].totalDonationSize}",
                      style: GoogleFonts.ubuntu(
                          color: Colors.black, fontWeight: FontWeight.w600))),
              const Divider(thickness: 5),
              const SizedBox(height: 10),
              ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xfffca5a5),
                    ),
                    child: const Icon(LineAwesomeIcons.wallet,
                        color: Colors.white),
                  ),
                  title: Text("Created At",
                      style: GoogleFonts.ubuntu(
                          color: Colors.black, fontWeight: FontWeight.w400)),
                  trailing: Text("${userModel[0].createdAt}",
                      style: GoogleFonts.ubuntu(
                          color: Colors.black, fontWeight: FontWeight.w600))),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.black,
                  endIcon: false,
                  onPress: () {
                    authService.logout(context: context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
