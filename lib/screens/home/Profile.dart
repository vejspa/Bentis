import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:untitled/screens/authenticate/sign_in.dart';
import 'Support.dart';
import '../../shared/constants.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class ProfileScreen extends StatefulWidget {
  final List<String>? cities;
  const ProfileScreen(this.cities, {Key? key}) : super(key: key);
  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  String phoneNumber = '';
  String name = '';
  String surname = '';

  @override
  void initState() {
    super.initState();
    GetInfo();

  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(414,896));

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: kSpacingUnit.w * 5,
                  backgroundImage: const AssetImage('assets/images/avatar.png'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: kSpacingUnit.w * 2.5,
                    width: kSpacingUnit.w * 2.5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      heightFactor: kSpacingUnit.w * 1.5,
                      widthFactor: kSpacingUnit.w * 1.5,
                      child: IconButton(
                          icon: const Icon(LineAwesomeIcons.pen),
                          color: kDarkPrimaryColor,
                          iconSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                          onPressed: ()  {

                          }

                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            name + " "+ surname ,
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 1.5),
          Text(
            phoneNumber,
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
        ],
      ),
    );



    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        profileInfo,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );



    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(28),
            child: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              header,
              Expanded(
                child: Column(
                    children: [

                      SizedBox(height: 15),
                      ElevatedButton.icon(
                          icon:  Icon(LineAwesomeIcons.user_shield),
                          label: Text('Privacy'),
                          style:ElevatedButton.styleFrom(fixedSize: const Size(240, 15), primary: Colors.black),
                          onPressed:()=>
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Support()),
                            )
                          }
                      ),
                      SizedBox(height: 15),
                      ElevatedButton.icon(
                          icon: const Icon(LineAwesomeIcons.history),
                          label: const Text('Purchase History'),
                          style:ElevatedButton.styleFrom(fixedSize: const Size(240, 15), primary: Colors.black),
                          onPressed:()=>
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Support()),
                            )
                          }
                      ),
                      SizedBox(height: 15),
                      ElevatedButton.icon(
                          icon: const Icon(LineAwesomeIcons.question_circle),
                          label: const Text('Help & Support'),
                          style:ElevatedButton.styleFrom(fixedSize: const Size(240, 15), primary: Colors.black),
                          onPressed:()=>
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Support()),
                            )
                          }
                      ),
                      SizedBox(height: 15),
                      ElevatedButton.icon(
                          icon: const Icon(LineAwesomeIcons.cog),
                          label: const Text('Settings'),
                          style:ElevatedButton.styleFrom(fixedSize: const Size(240, 15), primary: Colors.black),
                          onPressed:()=>
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Support()),
                            )
                          }
                      ),
                      SizedBox(height: 15),
                      ElevatedButton.icon(
                          icon: const Icon(LineAwesomeIcons.user_plus),
                          label: const Text('Invite a Friend'),
                          style:ElevatedButton.styleFrom(fixedSize: const Size(240, 15), primary: Colors.black),
                          onPressed:()=>
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Support()),
                            )
                          }
                      ),
                      SizedBox(height: 15),
                      ElevatedButton.icon(
                          icon: const Icon(LineAwesomeIcons.alternate_sign_out),
                          label: const Text('Logout'),
                          style:ElevatedButton.styleFrom(fixedSize: const Size(240, 15), primary: Colors.black),
                          onPressed: () async {
                            _signOut().then((value) => Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (BuildContext context) => SignIn(widget.cities))));
                        },
                      ),

                    ]
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _signOut() async {
    await _auth.signOut();
  }

  void GetInfo() async {
    await _firestore.collection("users").doc(_auth.currentUser?.uid).get().then((event) {
      setState(() {
        name = event.data()!['name'];
        surname = event.data()!['surname'];
        phoneNumber = event.data()!['phoneNumber'];
      });
    });
  }
}