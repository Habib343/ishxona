import 'package:flutter/material.dart';
import 'package:ishxona_uchun_ilova/bulim.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mahsulot Qo\'shish',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const XomAshyoPage(),
    );
  }
}

class XomAshyoPage extends StatefulWidget {
  const XomAshyoPage({super.key});

  @override
  State<XomAshyoPage> createState() => _XomAshyoPageState();
}

class _XomAshyoPageState extends State<XomAshyoPage> {
  List<Map<String, dynamic>> _mahsulotList = [];
  final TextEditingController _mahsulotController = TextEditingController();
  final TextEditingController _kilolarController = TextEditingController();
  final TextEditingController _narxController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  void _addMahsulot() {
    final String mahsulot = _mahsulotController.text;
    final double kilolar = double.tryParse(_kilolarController.text) ?? 0;
    final double narx = double.tryParse(_narxController.text) ?? 0;

    if (mahsulot.isNotEmpty && kilolar > 0 && narx > 0) {
      setState(() {
        _mahsulotList.add({
          'mahsulot': mahsulot,
          'kilolar': kilolar,
          'narx': narx,
          'jamiNarx': kilolar * narx,
          'sana': _selectedDate.toIso8601String(),
        });
      });

      _mahsulotController.clear();
      _kilolarController.clear();
      _narxController.clear();
      _saveMahsulotlar();

      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MahsulotlarListPage(mahsulotlar: _mahsulotList)),
      );
    } else {
      _showAlert("Ma'lumot noto‘g‘ri", "Iltimos, barcha maydonlarni to‘g‘ri qiymatlar bilan to‘ldirganingizni tekshiring.");
    }
  }

  void _saveMahsulotlar() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> mahsulotlarJson = _mahsulotList.map((e) => json.encode(e)).toList();
    await prefs.setStringList('mahsulotlar', mahsulotlarJson);
  }

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xomashyo Qo\'shish'),
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Bulim(),),);}, icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            TextField(
              controller: _mahsulotController,
              decoration: InputDecoration(
                labelText: 'Mahsulot nomi',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _kilolarController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Kilogrammi',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _narxController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Narxi',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text('Sana: ${_selectedDate.toLocal()}'),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _addMahsulot,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Mahsulot qo\'shish',style: TextStyle(
                color: Colors.black,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}

class MahsulotlarListPage extends StatelessWidget {
  final List<Map<String, dynamic>> mahsulotlar;

  const MahsulotlarListPage({super.key, required this.mahsulotlar});

  double _jamiNarx(List<Map<String, dynamic>> mahsulotlar) {
    double jami = 0;
    for (var mahsulot in mahsulotlar) {
      jami += mahsulot['jamiNarx'];
    }
    return jami;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => XomAshyoPage(),),);}, icon: Icon(Icons.arrow_back_ios)),
        title: const Text('Mahsulotlar Ro\'yxati'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: mahsulotlar.length,
                itemBuilder: (context, index) {
                  final mahsulot = mahsulotlar[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        mahsulot['mahsulot'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                          'Kilolar: ${mahsulot['kilolar']} - Narx: ${mahsulot['narx']} - Jami: ${mahsulot['jamiNarx']} - Sana: ${mahsulot['sana']}'),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                'Jami narx: ${_jamiNarx(mahsulotlar)} so\'m',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
