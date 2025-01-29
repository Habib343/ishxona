import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Te()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Center(
           child: Container(
            height: 200,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(image: AssetImage("rasm/55.png"),fit: BoxFit.cover)
            ),
           ),
         ),
        ],
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
  bool rememberMe = false; // Checkbox holati

  void funksiya() {
    if (input1.text == user && input2.text == parol) {
      if (rememberMe) {
        saqlash(); // Agar belgilangan bo'lsa, login va parolni saqlaydi
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Bulim()),
      );
    }
  }

  Future<void> saqlash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('login', input1.text);
    await prefs.setString('parol', input2.text);
  }

  Future<void> yuklash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      input1.text = prefs.getString('login') ?? '';
      input2.text = prefs.getString('parol') ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    yuklash(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Kirish",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "Hisobingizga kirish uchun ma'lumotlarni kiriting",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                controller: input1,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Foydalanuvchi nomi yoki email kiriting",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                style: TextStyle(
                  color: Colors.black,
                ),
                controller: input2,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Parolingizni kiriting",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value!;
                      });
                    },
                  ),
                  Text(
                    "Eslab qoling",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: funksiya,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text(
                  "Kirish",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Text.rich(
                TextSpan(
                  text: "Hisobingiz yo'qmi? ",
                  style: TextStyle(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: "Ro'yxatdan o'ting",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}