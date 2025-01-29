import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ishxona_uchun_ilova/bulim.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HodimlarPage extends StatefulWidget {
  const HodimlarPage({super.key});

  @override
  State<HodimlarPage> createState() => _HodimlarPageState();
}

class _HodimlarPageState extends State<HodimlarPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ishchiController = TextEditingController();
  final List<Map<String, dynamic>> _hodimlar = [];
  final String _currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _loadHodimlar(); // Ma'lumotlarni yuklash
  }

  Future<void> _loadHodimlar() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedData = prefs.getString('hodimlar');
    if (savedData != null) {
      setState(() {
        _hodimlar.addAll(List<Map<String, dynamic>>.from(jsonDecode(savedData)));
      });
    }
  }

  Future<void> _saveHodimlar() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(_hodimlar);
    await prefs.setString('hodimlar', encodedData);
  }

  void _addEntry() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _hodimlar.add({
          'kun': _currentDate,
          'hodim': _ishchiController.text,
        });
      });
      _saveHodimlar(); // Yangi ma'lumotni saqlash
      _resetForm(); // Forma tozalash
    }
  }

  void _resetForm() {
    _ishchiController.clear();
  }

   void _deleteEntry(int index) {
    setState(() {
      _hodimlar.removeAt(index); // Listadan hodimni o'chirish
    });
    _saveHodimlar(); // Yangilangan ma'lumotni saqlash
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hodimlar ro‘yxati'),
                leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Bulim(),),);}, icon: Icon(Icons.arrow_back_ios)),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kun: $_currentDate',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _ishchiController,
                    decoration: const InputDecoration(labelText: 'Hodim ismi'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Hodim ismini kiriting';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addEntry,
                    child: const Text('Saqlash'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _hodimlar.length,
                itemBuilder: (context, index) {
                  final hodim = _hodimlar[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HodimDetailPage(hodim: hodim),
                          ),
                        );
                      },
                      child: ListTile(
                        trailing:  IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteEntry(index), 
                      ),
                        title: Text(hodim['hodim']),
                        subtitle: Text('Kun: ${hodim['kun']}'),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class HodimDetailPage extends StatefulWidget {
  final Map<String, dynamic> hodim;

  const HodimDetailPage({super.key, required this.hodim});

  @override
  State<HodimDetailPage> createState() => _HodimDetailPageState();
}

class _HodimDetailPageState extends State<HodimDetailPage> {
  final Map<int, Map<String, dynamic>> _data = {}; // Har bir kun uchun ma'lumotlar

  double _calculateTotal(int day) {
    final data = _data[day] ?? {};
    final double quantity = double.tryParse(data['quantity'] ?? '0') ?? 0.0;
    final double price = double.tryParse(data['price'] ?? '0') ?? 0.0;
    return quantity * price;
  }

  double _calculateOverallTotal() {
    double total = 0.0;
    _data.forEach((day, data) {
      total += _calculateTotal(day);
    });
    return total;
  }

 void _showBottomSheet(BuildContext context, int day) {
  final productController = TextEditingController(
      text: _data[day]?['product'] ?? ''); // Saved product name
  final quantityController = TextEditingController(
      text: _data[day]?['quantity'] ?? ''); // Saved quantity
  final priceController = TextEditingController(
      text: _data[day]?['price'] ?? ''); // Saved price

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 16.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Kun $day: Maʼlumotni kiriting',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: productController,
                decoration: InputDecoration(
                  labelText: 'Mahsulot nomi',
                  labelStyle: const TextStyle(fontSize: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Mahsulot soni',
                  labelStyle: const TextStyle(fontSize: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Mahsulot narxi',
                  labelStyle: const TextStyle(fontSize: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Text(
                      'Bekor qilish',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _data[day] = {
                          'product': productController.text,
                          'quantity': quantityController.text,
                          'price': priceController.text,
                        };
                      });
                      final total = _calculateTotal(day);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Kun $day: $total so‘m hisoblandi')),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                    child: const Text(
                      'Saqlash',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    final overallTotal = _calculateOverallTotal(); // Umumiy hisobni olish
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hodim Tafsilotlari'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hodim: ${widget.hodim['hodim']}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Kun: ${widget.hodim['kun']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Umumiy hisob: $overallTotal so‘m',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Kunlar:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 31,
                itemBuilder: (context, index) {
                  final day = index + 1;
                  final total = _calculateTotal(day);
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text('Kun $day'),
                      subtitle: total > 0
                          ? Text('Hisoblangan: $total so‘m')
                          : const Text('Maʼlumot kiritilmagan'),
                      onTap: () => _showBottomSheet(context, day),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
