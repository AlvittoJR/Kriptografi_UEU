import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XOR Encryption/Decryption',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _result = '';

  Future<void> encrypt(String inputFile, String outputFile, String key) async {
    final input = await File(inputFile).readAsString();
    final keyLength = key.length;
    final encryptedData = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      encryptedData.writeCharCode(input.codeUnitAt(i) ^ key.codeUnitAt(i % keyLength));
    }

    await File(outputFile).writeAsString(encryptedData.toString());
    setState(() {
      _result = 'Encrypted data:\n${encryptedData.toString()}';
    });
  }

  Future<void> decrypt(String inputFile, String outputFile, String key) async {
    final input = await File(inputFile).readAsString();
    final keyLength = key.length;
    final decryptedData = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      decryptedData.writeCharCode(input.codeUnitAt(i) ^ key.codeUnitAt(i % keyLength));
    }

    await File(outputFile).writeAsString(decryptedData.toString());
    setState(() {
      _result = 'Decrypted data:\n${decryptedData.toString()}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('XOR Encryption/Decryption'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                const key = 'secretkey';
                encrypt('plain.txt', 'cipher.txt', key);
              },
              child: const Text('Encrypt'),
            ),
            ElevatedButton(
              onPressed: () {
                const key = 'secretkey';
                decrypt('cipher.txt', 'plain2.txt', key);
              },
              child: const Text('Decrypt'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
