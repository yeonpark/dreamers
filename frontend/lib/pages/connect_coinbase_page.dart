import 'package:coinbase_wallet_sdk/configuration.dart';
import 'package:coinbase_wallet_sdk/eth_web3_rpc.dart';
import 'package:coinbase_wallet_sdk/request.dart';
import 'package:flutter/material.dart';
import 'package:coinbase_wallet_sdk/coinbase_wallet_sdk.dart';

class ConnectCoinbasePage extends StatefulWidget {
  const ConnectCoinbasePage({super.key});

  @override
  State<ConnectCoinbasePage> createState() => _ConnectCoinbasePageState();
}

class _ConnectCoinbasePageState extends State<ConnectCoinbasePage> {
  String _address = "";
  String _signed = "";
  String _sessionCleared = "";

  @override
  void initState() {
    CoinbaseWalletSDK.shared.configure(Configuration(
        ios: IOSConfiguration(
          host: Uri.parse('cbwallet://wsegue'),
          callback: Uri.parse('tribesxyzsample://mycallback'),
        ),
        android: AndroidConfiguration(
          domain: Uri.parse('https://www.myappxyz.com'),
        )));
    super.initState();
  }

  Future<void> _requestAccount() async {
    String address;
    try {
      final results = await CoinbaseWalletSDK.shared.initiateHandshake([
        const RequestAccounts(),
      ]);

      address = results[0].account?.address ?? "<no address>";
    } catch (e) {
      address = 'Failed to get address. => $e';
    }

    if (!mounted) return;

    setState(() {
      _address = address;
    });
  }

  Future<void> _personalSign() async {
    String message = "Hello, World!";
    String signed;
    try {
      final request = Request(
        actions: [PersonalSign(address: _address, message: message)],
      );
      final results = await CoinbaseWalletSDK.shared.makeRequest(request);

      signed = results[0].value ?? "<no signature>";
    } catch (e) {
      debugPrint('error --> $e');
      signed = "Failed to sign message.";
    }

    if (!mounted) return;

    setState(() {
      _signed = signed;
    });
  }

  Future<void> _resetSession() async {
    try {
      await CoinbaseWalletSDK.shared.resetSession();
      setState(() {
        _sessionCleared = "Session Cleared!";
      });
    } catch (e) {
      setState(() {
        _sessionCleared = "Failed to reset session";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Coinbase Flutter SDK')),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  FutureBuilder<bool>(
                      future: CoinbaseWalletSDK.shared.isAppInstalled(),
                      builder: ((context, snapshot) {
                        return Text('Is installed? ${snapshot.data}');
                      })),
                  TextButton(
                    onPressed: () => _requestAccount(),
                    child: const Text("Request Account"),
                  ),
                  Text('Address is \n\n $_address'),
                  const SizedBox(height: 50),
                  TextButton(
                    onPressed: () => _personalSign(),
                    child: const Text("personalSign"),
                  ),
                  Text('signed message is \n\n $_signed'),
                  const SizedBox(height: 50),
                  TextButton(
                    onPressed: () => _resetSession(),
                    child: const Text("Reset Session"),
                  ),
                  Text('is reset \n\n $_sessionCleared'),
                ]))));
  }
}
