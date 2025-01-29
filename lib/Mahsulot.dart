import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ishxona_uchun_ilova/bulim.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MahsulotPage extends StatefulWidget {
  const MahsulotPage({super.key});

  @override
  State<MahsulotPage> createState() => _MahsulotPageState();
}

class _MahsulotPageState extends State<MahsulotPage> {
  final TextEditingController nomiController = TextEditingController();
  final TextEditingController narxiController = TextEditingController();

  List<Map<String, String>> mahsulotlar = [];

  @override
  void initState() {
    super.initState();

  }



  Future<void> saveMahsulotlar() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('mahsulotlar', jsonEncode(mahsulotlar));
  }

  void mahsulotQoshish() {
    if (nomiController.text.isNotEmpty &&
        narxiController.text.isNotEmpty &&
        double.tryParse(narxiController.text) != null) {
      setState(() {
        mahsulotlar.add({
          "nomi": nomiController.text,
          "narxi": narxiController.text,
        });
        saveMahsulotlar();
        nomiController.clear();
        narxiController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Mahsulot qo'shildi!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Iltimos, barcha maydonlarni to'g'ri to'ldiring!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mahsulotlar"),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Bulim(),
                ),
              );
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nomiController,
              decoration: const InputDecoration(
                labelText: "Mahsulot nomi",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.shopping_bag),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: narxiController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Mahsulot narxi",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: mahsulotQoshish,
                  icon: const Icon(Icons.add,color: Colors.black,),
                  label: const Text("Qo'shish",
                      style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Mahsulotnomi(mahsulotlar: mahsulotlar),
                      ),
                    );
                  },
                  icon: const Icon(Icons.list,color: Colors.black,),
                  label: const Text("Ro'yxatni ko'rsatish",
                      style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Mahsulotnomi extends StatefulWidget {
  final List<Map<String, String>> mahsulotlar;

  const Mahsulotnomi({super.key, required this.mahsulotlar});

  @override
  State<Mahsulotnomi> createState() => _MahsulotnomiState();
}

class _MahsulotnomiState extends State<Mahsulotnomi> {
  late List<Map<String, String>> mahsulotlar;

  @override
  void initState() {
    super.initState();
    mahsulotlar = widget.mahsulotlar;
  }

  Future<void> deleteMahsulot(int index) async {
    setState(() {
      mahsulotlar.removeAt(index);
    });

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('mahsulotlar', jsonEncode(mahsulotlar));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Mahsulot o'chirildi!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Mahsulotlar Ro'yxati"),
                  leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MahsulotPage(),),);}, icon: Icon(Icons.arrow_back_ios)),

          ),
      body: mahsulotlar.isEmpty
          ? const Center(child: Text("Mahsulotlar ro'yxati bo'sh!"))
          : ListView.builder(
              itemCount: mahsulotlar.length,
              itemBuilder: (context, index) {
                final mahsulot = mahsulotlar[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(mahsulot['nomi'] ?? 'Nomi yo\'q',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text("Narxi: ${mahsulot['narxi']} so'm",
                        style: const TextStyle(fontSize: 16)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteMahsulot(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
