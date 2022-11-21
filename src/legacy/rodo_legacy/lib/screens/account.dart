import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:rodo/utilities/constants.dart';
import 'dart:io' show Platform;

enum MobileVerificationState { MOBILE_PHONE_FORM, VERIFICATION_CODE_FORM }

class Account extends StatefulWidget {
  static const String route = '/account';

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  MobileVerificationState currentState =
      MobileVerificationState.MOBILE_PHONE_FORM;

  final phoneController = TextEditingController();
  final verificationController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  var verificationId;

  bool showLoading = false;

  String countryCode = '+32';

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  //TODO: move custom widget to separate files
  getMobilePhoneForm(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: kPrimaryColor),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: CountryCodePicker(
                  hideMainText: true,
                  padding: EdgeInsets.all(0),
                  searchStyle: generalTextStyle,
                  dialogTextStyle: generalTextStyle,
                  searchDecoration: textFieldDecoration.copyWith(
                      prefixIcon: Icon(
                    Icons.search,
                    color: kPrimaryColor,
                  )),
                  onChanged: (code) {
                    setState(() {
                      countryCode = code.dialCode.toString();
                    });
                  },
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: 'BE',
                  favorite: ['BE', 'NL', 'FR', 'IT', 'ES', 'US'],
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                  textStyle: generalBoldTextStyle,
                ),
              ),
              Expanded(
                  flex: 0,
                  child: Text(
                    countryCode,
                    style: generalBoldTextStyle.copyWith(fontSize: 18),
                  )),
              SizedBox(
                width: 4,
              ),
              Expanded(
                flex: 2,
                child: TextField(
                  style: generalTextStyle.copyWith(fontSize: 18),
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.start,
                  controller: phoneController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    hintText: 'Mobile number',
                  ).copyWith(
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              )
            ],
          ),
        ),
        TextButton(
          onPressed: () async {
            setState(() {
              showLoading = true;
            });
            await _auth.verifyPhoneNumber(
              phoneNumber: countryCode + phoneController.text,
              verificationCompleted: (phoneAuthCredential) async {
                setState(() {
                  showLoading = false;
                });
                //signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              verificationFailed: (verificationFailed) async {
                setState(() {
                  showLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(verificationFailed.message.toString())));
              },
              codeSent: (verificationId, resendingToken) async {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.VERIFICATION_CODE_FORM;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) async {},
            );
          },
          child: Text(
            'SEND',
            style: generalBoldTextStyle.copyWith(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => kPrimaryColor),
          ),
        ),
      ],
    );
  }

  //TODO: move custom widget to separate files
  getVerificationCodeForm(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          keyboardType: TextInputType.number,
          style: generalTextStyle,
          controller: verificationController,
          textAlign: TextAlign.center,
          decoration: textFieldDecoration.copyWith(
            hintText: 'Verification Code',
          ),
        ),
        TextButton(
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: verificationController.text);
            signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          child: Text(
            'VERIFY',
            style: generalBoldTextStyle.copyWith(color: Colors.white),
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => kPrimaryColor),
          ),
        ),
      ],
    );
  }

  void logOut() async {
    await _auth.signOut();
    setState(() {
      countryCode = '+32';
      currentState = MobileVerificationState.MOBILE_PHONE_FORM;
      phoneController.clear();
      verificationController.clear();
    });
  }

  profilePage() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi Louis!',
                  style: generalBoldTextStyle.copyWith(fontSize: 28),
                ),
                SizedBox(
                  height: 15,
                ),
                ListTile(
                  leading: Icon(
                    Icons.account_circle_outlined,
                    color: kPrimaryColor,
                    size: 30,
                  ),
                  title: Text(
                    'My Profile',
                    style:
                        generalTextStyle.copyWith(fontWeight: FontWeight.w600),
                  ),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.event_outlined,
                    color: kPrimaryColor,
                    size: 30,
                  ),
                  title: Text(
                    'Reservations',
                    style:
                        generalTextStyle.copyWith(fontWeight: FontWeight.w600),
                  ),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.payment_outlined,
                    color: kPrimaryColor,
                    size: 30,
                  ),
                  title: Text(
                    'Payment Method',
                    style:
                        generalTextStyle.copyWith(fontWeight: FontWeight.w600),
                  ),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings_outlined,
                    color: kPrimaryColor,
                    size: 30,
                  ),
                  title: Text(
                    'Settings',
                    style:
                        generalTextStyle.copyWith(fontWeight: FontWeight.w600),
                  ),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.help_outline,
                    color: kPrimaryColor,
                    size: 30,
                  ),
                  title: Text(
                    'FAQ',
                    style:
                        generalTextStyle.copyWith(fontWeight: FontWeight.w600),
                  ),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                ),
                SizedBox(
                  height: 50,
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout_outlined,
                    color: kPrimaryColor,
                    size: 30,
                  ),
                  title: Text(
                    'Log Out',
                    style:
                        generalTextStyle.copyWith(fontWeight: FontWeight.w600),
                  ),
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 0,
                  onTap: Platform.isAndroid
                      ? () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Log out?'),
                              content: const Text(
                                  'Are you sure you want to log out?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('Discard');
                                    logOut();
                                  },
                                  child: const Text('Log Out'),
                                ),
                              ],
                            ),
                          )
                      : () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: const Text('Log out?'),
                              content: const Text(
                                  'Are you sure you want to log out?'),
                              actions: <CupertinoDialogAction>[
                                CupertinoDialogAction(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: const Text('Log Out'),
                                  isDestructiveAction: true,
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('Discard');
                                    logOut();
                                  },
                                )
                              ],
                            ),
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Account',
          style: appBarTextStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: showLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              )
            : _auth.currentUser != null
                ? profilePage()
                : currentState == MobileVerificationState.MOBILE_PHONE_FORM
                    ? getMobilePhoneForm(context)
                    : getVerificationCodeForm(context),
      ),
    );
  }
}
