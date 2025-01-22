// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart'; 

// class hodimlarPage extends StatefulWidget {
//   const hodimlarPage({super.key});

//   @override
//   State<hodimlarPage> createState() => _hodimlarPageState();
// }

// class _hodimlarPageState extends State<hodimlarPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _ishchiController = TextEditingController();
//   final TextEditingController _mahsulotController = TextEditingController();
//   final TextEditingController _soniController = TextEditingController();
//   final TextEditingController _narxiController = TextEditingController();
//   double _jamiNarx = 0.0;

  
//   final List<Map<String, dynamic>> _ishchilar = [];

  
//   final String _currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

//   void _calculateTotalPrice() {
//     final int soni = int.tryParse(_soniController.text) ?? 0;
//     final double narxi = double.tryParse(_narxiController.text) ?? 0.0;
//     setState(() {
//       _jamiNarx = soni * narxi;
//     });
//   }

//   void _saveData() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _ishchilar.add({
//           'kun': _currentDate, 
//           'ishchi': _ishchiController.text,
//           'mahsulot': _mahsulotController.text,
//           'soni': _soniController.text,
//           'narxi': _narxiController.text,
//           'jami': _jamiNarx,
//         });
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Ma\'lumot saqlandi!')),
//       );
//       _resetForm();
//     }
//   }

//   void _resetForm() {
//     _ishchiController.clear();
//     _mahsulotController.clear();
//     _soniController.clear();
//     _narxiController.clear();
//     setState(() {
//       _jamiNarx = 0.0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hodimlar ro‘yxati'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Form(
//               key: _formKey,
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Kun:',
//                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           _currentDate,
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       controller: _ishchiController,
//                       decoration: const InputDecoration(labelText: 'Hodim ismi'),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Ishchi ismini kiriting';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       controller: _mahsulotController,
//                       decoration: const InputDecoration(labelText: 'Mahsulot nomi'),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Mahsulot nomini kiriting';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       controller: _soniController,
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(labelText: 'Mahsulot soni'),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Mahsulot sonini kiriting';
//                         }
//                         if (int.tryParse(value) == null) {
//                           return 'Faqat son kiriting';
//                         }
//                         return null;
//                       },
//                       onChanged: (value) => _calculateTotalPrice(),
//                     ),
//                     TextFormField(
//                       controller: _narxiController,
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(labelText: 'Mahsulot narxi'),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Mahsulot narxini kiriting';
//                         }
//                         if (double.tryParse(value) == null) {
//                           return 'Faqat raqam kiriting';
//                         }
//                         return null;
//                       },
//                       onChanged: (value) => _calculateTotalPrice(),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       'Jami narx: $_jamiNarx so‘m',
//                       style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _saveData,
//                       child: const Text('Saqlash'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _ishchilar.length,
//                 itemBuilder: (context, index) {
//                   final ishchi = _ishchilar[index];
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 5),
//                     child: ListTile(
//                       title: Text('${ishchi['ishchi']} (${ishchi['kun']})'),
//                       subtitle: Text(
//                           'Mahsulot: ${ishchi['mahsulot']}, Soni: ${ishchi['soni']}, Narxi: ${ishchi['narxi']} so‘m'),
//                       trailing: Text('Jami: ${ishchi['jami']} so‘m'),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class HodimlarPage extends StatefulWidget {
//   const HodimlarPage({super.key});

//   @override
//   State<HodimlarPage> createState() => _HodimlarPageState();
// }

// class _HodimlarPageState extends State<HodimlarPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _ishchiController = TextEditingController();
//   final TextEditingController _mahsulotController = TextEditingController();
//   final TextEditingController _soniController = TextEditingController();
//   final TextEditingController _narxiController = TextEditingController();
//   double _jamiNarx = 0.0;

//   final List<Map<String, dynamic>> _ishchilar = [];
//   final String _currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

//   void _calculateTotalPrice() {
//     final int soni = int.tryParse(_soniController.text) ?? 0;
//     final double narxi = double.tryParse(_narxiController.text) ?? 0.0;
//     setState(() {
//       _jamiNarx = soni * narxi;
//     });
//   }

//   void _saveData() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _ishchilar.add({
//           'kun': _currentDate,
//           'ishchi': _ishchiController.text,
//           'mahsulot': _mahsulotController.text,
//           'soni': _soniController.text,
//           'narxi': _narxiController.text,
//           'jami': _jamiNarx,
//         });
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Ma\'lumot saqlandi!')),
//       );
//       _resetForm();
//     }
//   }

//   void _resetForm() {
//     _ishchiController.clear();
//     _mahsulotController.clear();
//     _soniController.clear();
//     _narxiController.clear();
//     setState(() {
//       _jamiNarx = 0.0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hodimlar ro‘yxati'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'Kun:',
//                         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         _currentDate,
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: _ishchiController,
//                     decoration: const InputDecoration(labelText: 'Hodim ismi'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Ishchi ismini kiriting';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _mahsulotController,
//                     decoration: const InputDecoration(labelText: 'Mahsulot nomi'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Mahsulot nomini kiriting';
//                       }
//                       return null;
//                     },
//                   ),
//                   TextFormField(
//                     controller: _soniController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(labelText: 'Mahsulot soni'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Mahsulot sonini kiriting';
//                       }
//                       if (int.tryParse(value) == null) {
//                         return 'Faqat son kiriting';
//                       }
//                       return null;
//                     },
//                     onChanged: (value) => _calculateTotalPrice(),
//                   ),
//                   TextFormField(
//                     controller: _narxiController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(labelText: 'Mahsulot narxi'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Mahsulot narxini kiriting';
//                       }
//                       if (double.tryParse(value) == null) {
//                         return 'Faqat raqam kiriting';
//                       }
//                       return null;
//                     },
//                     onChanged: (value) => _calculateTotalPrice(),
//                   ),
//                   const SizedBox(height: 20),
//                   Text(
//                     'Jami narx: $_jamiNarx so‘m',
//                     style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _saveData,
//                     child: const Text('Saqlash'),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             if (_ishchilar.isNotEmpty) ...[
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: _ishchilar.length,
//                   itemBuilder: (context, index) {
//                     final ishchi = _ishchilar[index];
//                     return Card(
//                       margin: const EdgeInsets.symmetric(vertical: 5),
//                       child: ListTile(
//                         title: Text('${ishchi['ishchi']} (${ishchi['kun']})'),
//                         subtitle: Text(
//                             'Mahsulot: ${ishchi['mahsulot']}, Soni: ${ishchi['soni']}, Narxi: ${ishchi['narxi']} so‘m'),
//                         trailing: Text('Jami: ${ishchi['jami']} so‘m'),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class HodimlarPage extends StatefulWidget {
//   const HodimlarPage({super.key});

//   @override
//   State<HodimlarPage> createState() => _HodimlarPageState();
// }

// class _HodimlarPageState extends State<HodimlarPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _ishchiController = TextEditingController();

//   final List<Map<String, dynamic>> _hodimlar = [];
//   final String _currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

//   void _addEntry() {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _hodimlar.add({
//           'kun': _currentDate,
//           'hodim': _ishchiController.text,
//         });
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Ma\'lumot saqlandi!')),
//       );
//       _resetForm();
//     }
//   }

//   void _resetForm() {
//     _ishchiController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hodimlar ro‘yxati'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Kun: $_currentDate',
//                     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: _ishchiController,
//                     decoration: const InputDecoration(labelText: 'Hodim ismi'),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Hodim ismini kiriting';
//                       }
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _addEntry,
//                     child: const Text('Saqlash'),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: _hodimlar.length,
//                 itemBuilder: (context, index) {
//                   final hodim = _hodimlar[index];
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 5),
//                     child: ListTile(
//                       title: Text(hodim['hodim']),
//                       subtitle: Text('Kun: ${hodim['kun']}'),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class HodimDetailPage extends StatelessWidget {
//   final Map<String, dynamic> hodim;

//   const HodimDetailPage({super.key, required this.hodim});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Hodim: ${hodim['hodim']}'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Kun: ${hodim['kun']}',
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text('Mahsulot: ${hodim['mahsulot']}'),
//             Text('Soni: ${hodim['son']}'),
//             Text('Narxi: ${hodim['narx']} so‘m'),
//             Text(
//               'Umumiy hisob: ${hodim['hisob']} so‘m',
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }\\


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
        text: _data[day]?['product'] ?? ''); // Saqlangan mahsulot nomi
    final quantityController = TextEditingController(
        text: _data[day]?['quantity'] ?? ''); // Saqlangan son
    final priceController = TextEditingController(
        text: _data[day]?['price'] ?? ''); // Saqlangan narx

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Kun $day: Maʼlumotni kiriting',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: productController,
                decoration: const InputDecoration(
                  labelText: 'Mahsulot nomi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Mahsulot soni',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Mahsulot narxi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Bekor qilish'),
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
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Saqlash'),
                  ),
                ],
              ),
            ],
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
