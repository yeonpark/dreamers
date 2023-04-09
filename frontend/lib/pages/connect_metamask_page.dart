import 'package:dreamers/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/colors.dart';

class ConnectMetamaskPage extends StatefulWidget {
  const ConnectMetamaskPage({super.key});

  @override
  State<ConnectMetamaskPage> createState() => _ConnectMetamaskPageState();
}

class _ConnectMetamaskPageState extends State<ConnectMetamaskPage> {
  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'dreamers',
        description: 'A crowd-scholarship app',
        url: 'https://walletconnect.org',
      ));
  var _session;
  var _uri;

  @override
  void initState() {
    if (_session != Null) {
      Future(() {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfilePage()));
      });
    }
    super.initState();
  }

  loginUsingMetaMask(BuildContext context) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        debugPrint(session.accounts[0]);
        debugPrint(session.chainId as String?);

        setState(() {
          _session = session;
        });
        Future(() {
          Future(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          });
        });
      } catch (e) {
        print('error => $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Connect to Use Full Feature",
            style: GoogleFonts.ubuntu(
              color: titleTextColor,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          OutlinedButton(
            onPressed: () => loginUsingMetaMask(context),
            style: OutlinedButton.styleFrom(
                fixedSize: const Size(200, 36),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.black))),
            child: Text("Connect with Metamask",
                style: GoogleFonts.ubuntu(
                    color: titleTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12)),
          ),
          OutlinedButton(
            onPressed: () =>
                {Navigator.pushNamed(context, "/connect-coinbase")},
            style: OutlinedButton.styleFrom(
                fixedSize: const Size(200, 36),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.black))),
            child: Text("Connect with Coinbase",
                style: GoogleFonts.ubuntu(
                    color: titleTextColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 12)),
          )
        ]),
      ),
    ));
  }
}
