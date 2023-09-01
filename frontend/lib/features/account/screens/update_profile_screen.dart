import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:dreamers/features/account/services/profile_service.dart';
import 'package:provider/provider.dart';
import 'package:dreamers/providers/story_provider.dart';
import 'package:dreamers/constants/global_variables.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routeName = '/edit-profile';
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _introductionUpdateController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _introductionUpdateController.dispose();
  }

  final ProfileServices profileServices = ProfileServices();

  void updateProfile() {
    profileServices.updateProfile(
        context: context,
        updatedIntroduction: _introductionUpdateController.text);
  }

  Widget build(BuildContext context) {
    final userModel = Provider.of<StoryProvider>(context).profile;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfffca5a5),
        leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: const Icon(LineAwesomeIcons.angle_left)),
        title: Text("Edit Profile",
            style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
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
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0xfffca5a5)),
                        // child: const Icon(LineAwesomeIcons.camera,
                        //     color: Colors.black, size: 20),
                        child: IconButton(
                            icon: const Icon(LineAwesomeIcons.alternate_pencil,
                                color: Colors.white),
                            onPressed: () {
                              profileServices.uploadProfileImage(
                                  context: context);
                            })),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _introductionUpdateController,
                      decoration: const InputDecoration(
                          focusColor: Color(0xfffca5a5),
                          fillColor: Color(0xfffca5a5),
                          floatingLabelStyle:
                              TextStyle(color: Color(0xfffca5a5)),
                          iconColor: Color(0xfffca5a5),
                          label: Text("Enter a status message"),
                          prefixIcon: Icon(LineAwesomeIcons.user)),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => {
                          updateProfile(),
                          Navigator.pop(context),
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xfffca5a5)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        child: Text("Update user profile",
                            style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
