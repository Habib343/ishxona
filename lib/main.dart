import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'bulim.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Tex(
      
    ),
  ));
}

class Tex extends StatefulWidget {
  const Tex({super.key});

  @override
  State<Tex> createState() => _TexState();
}

class _TexState extends State<Tex> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Te()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.black,
        ),
      ),
    );
  }
}

class Te extends StatefulWidget {
  const Te({super.key});

  @override
  State<Te> createState() => _TeState();
}

class _TeState extends State<Te> {
  String user = "Habib";
  String parol = "343";
  TextEditingController input1 = TextEditingController();
  TextEditingController input2 = TextEditingController();

  void funksiya() {
    if (input1.text == user && input2.text == parol) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Bulim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  controller: input1,
                  decoration: InputDecoration(
                    label: Text(
                      "Foydalanuvchi",
                      style: s,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) => funksiya(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  controller: input2,
                  decoration: InputDecoration(
                    label: Text(
                      "Parol",
                      style: s,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) => funksiya(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final s = TextStyle(color: Colors.black);

