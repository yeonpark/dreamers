import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ConnectMetaMaskPage extends StatefulWidget {
  const ConnectMetaMaskPage({super.key});

  @override
  State<ConnectMetaMaskPage> createState() => _ConnectMetaMaskPageState();
}

class _ConnectMetaMaskPageState extends State<ConnectMetaMaskPage> {
  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'dreamers',
        description: 'A crowd-scholarship app',
        url: 'https://walletconnect.org',
      ));
  var _session;
  var _uri;

  loginUsingMetaMask(BuildContext context) async {
    if (!connector.connected) {
      try {
        var session = await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        print(session.accounts[0]);
        print(session.chainId);

        setState(() {
          _session = session;
        });
      } catch (e) {
        print('error => $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Connect to Metamask'),
        ),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/images/buffett.jpeg',
            fit: BoxFit.fitHeight,
          ),
          ElevatedButton(
            onPressed: () => loginUsingMetaMask(context),
            child: const Text("Connect with Metamask"),
          )
        ])));
  }
}
