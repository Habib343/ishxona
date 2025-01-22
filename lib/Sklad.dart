// import 'package:flutter/material.dart';

// class SkladPage extends StatefulWidget {
//   const SkladPage({super.key});

//   @override
//   State<SkladPage> createState() => _SkladPageState();
// }

// class _SkladPageState extends State<SkladPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

// import 'package:flutter/material.dart';

// class SkladPage extends StatefulWidget {
//   const SkladPage({super.key});

//   @override
//   State<SkladPage> createState() => _SkladPageState();
// }

// class _SkladPageState extends State<SkladPage> {
//   final TextEditingController nomiController = TextEditingController();
//   final TextEditingController soniController = TextEditingController();
//   final TextEditingController narxiController = TextEditingController();
//   final TextEditingController qidiruvController = TextEditingController();

//   List<Map<String, String>> mahsulotlar = [];
//   List<Map<String, String>> filteredMahsulotlar = [];

//   @override
//   void initState() {
//     super.initState();
//     filteredMahsulotlar = mahsulotlar;
//   }

//   void mahsulotQoshish() {
//     if (nomiController.text.isNotEmpty &&
//         soniController.text.isNotEmpty &&
//         narxiController.text.isNotEmpty &&
//         int.tryParse(soniController.text) != null &&
//         double.tryParse(narxiController.text) != null) {
//       setState(() {
//         mahsulotlar.add({
//           "nomi": nomiController.text,
//           "soni": soniController.text,
//           "narxi": narxiController.text,
//         });
//         filteredMahsulotlar = mahsulotlar;
//         nomiController.clear();
//         soniController.clear();
//         narxiController.clear();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Iltimos, barcha maydonlarni to'g'ri to'ldiring!")),
//       );
//     }
//   }

//   void mahsulotlarniTozalash() {
//     setState(() {
//       mahsulotlar.clear();
//       filteredMahsulotlar = mahsulotlar;
//     });
//   }

//   double hisoblaUmumiyNarx() {
//     double umumiyNarx = 0.0;
//     for (var mahsulot in filteredMahsulotlar) {
//       double narxi = double.tryParse(mahsulot["narxi"] ?? "0") ?? 0.0;
//       int soni = int.tryParse(mahsulot["soni"] ?? "0") ?? 0;
//       umumiyNarx += narxi * soni;
//     }
//     return umumiyNarx;
//   }

//   void mahsulotlarniQidirish(String qidiruvMatni) {
//     setState(() {
//       if (qidiruvMatni.isEmpty) {
//         filteredMahsulotlar = mahsulotlar;
//       } else {
//         filteredMahsulotlar = mahsulotlar.where((mahsulot) {
//           return mahsulot["nomi"]!.toLowerCase().contains(qidiruvMatni.toLowerCase());
//         }).toList();
//       }
//     });
//   }

//   void mahsulotTahrirlash(int index, Map<String, String> yangilanganMahsulot) {
//     setState(() {
//       mahsulotlar[index] = yangilanganMahsulot;
//       filteredMahsulotlar = mahsulotlar;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Ombor"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: nomiController,
//               decoration: InputDecoration(
//                 labelText: "Mahsulot nomi",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: soniController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Mahsulot soni",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: narxiController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Mahsulot narxi",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: mahsulotQoshish,
//               child: Text("Mahsulotni qo'shish"),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: qidiruvController,
//               onChanged: mahsulotlarniQidirish,
//               decoration: InputDecoration(
//                 labelText: "Mahsulotni qidirish",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "Umumiy narx: ${hisoblaUmumiyNarx()} so'm",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: mahsulotlarniTozalash,
//               child: Text("Barcha mahsulotlarni o'chirish"),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredMahsulotlar.length,
//                 itemBuilder: (context, index) {
//                   final mahsulot = filteredMahsulotlar[index];
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 5),
//                     child: ListTile(
//                       title: Text("Mahsulot: ${mahsulot["nomi"]}"),
//                       subtitle: Text(
//                           "Soni: ${mahsulot["soni"]}, Narxi: ${mahsulot["narxi"]} so'm"),
//                       trailing: IconButton(
//                         icon: Icon(Icons.edit),
//                         onPressed: () {
//                           nomiController.text = mahsulot["nomi"]!;
//                           soniController.text = mahsulot["soni"]!;
//                           narxiController.text = mahsulot["narxi"]!;
//                           showDialog(
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 title: Text("Mahsulotni tahrirlash"),
//                                 content: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     TextField(
//                                       controller: nomiController,
//                                       decoration: InputDecoration(labelText: "Mahsulot nomi"),
//                                     ),
//                                     TextField(
//                                       controller: soniController,
//                                       keyboardType: TextInputType.number,
//                                       decoration: InputDecoration(labelText: "Mahsulot soni"),
//                                     ),
//                                     TextField(
//                                       controller: narxiController,
//                                       keyboardType: TextInputType.number,
//                                       decoration: InputDecoration(labelText: "Mahsulot narxi"),
//                                     ),
//                                   ],
//                                 ),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Text("Bekor qilish"),
//                                   ),
//                                   TextButton(
//                                     onPressed: () {
//                                       mahsulotTahrirlash(index, {
//                                         "nomi": nomiController.text,
//                                         "soni": soniController.text,
//                                         "narxi": narxiController.text,
//                                       });
//                                       nomiController.clear();
//                                       soniController.clear();
//                                       narxiController.clear();
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: Text("Saqlash"),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                       ),
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

// class SkladPage extends StatefulWidget {
//   const SkladPage({super.key});

//   @override
//   State<SkladPage> createState() => _SkladPageState();
// }

// class _SkladPageState extends State<SkladPage> {
//   final TextEditingController nomiController = TextEditingController();
//   final TextEditingController soniController = TextEditingController();
//   final TextEditingController narxiController = TextEditingController();

//   List<Map<String, String>> skladItems = [];

//   void addSkladItem() {
//     if (nomiController.text.isNotEmpty &&
//         soniController.text.isNotEmpty &&
//         narxiController.text.isNotEmpty &&
//         int.tryParse(soniController.text) != null &&
//         double.tryParse(narxiController.text) != null) {
//       setState(() {
//         skladItems.add({
//           "nomi": nomiController.text,
//           "soni": soniController.text,
//           "narxi": narxiController.text,
//         });
//         nomiController.clear();
//         soniController.clear();
//         narxiController.clear();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Iltimos, barcha maydonlarni to'g'ri to'ldiring!")),
//       );
//     }
//   }

//   void removeSkladItem(int index) {
//     setState(() {
//       skladItems.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sklad boshqaruvi"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: nomiController,
//               decoration: InputDecoration(
//                 labelText: "Mahsulot nomi",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: soniController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Mahsulot soni",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: narxiController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Mahsulot narxi",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: addSkladItem,
//               child: Text("Mahsulot qo'shish"),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: skladItems.length,
//                 itemBuilder: (context, index) {
//                   final item = skladItems[index];
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 5),
//                     child: ListTile(
//                       title: Text("Mahsulot: ${item["nomi"]}"),
//                       subtitle: Text("Soni: ${item["soni"]}, Narxi: ${item["narxi"]} so'm"),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete),
//                         onPressed: () => removeSkladItem(index),
//                       ),
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

// class SkladPage extends StatefulWidget {
//   const SkladPage({super.key});

//   @override
//   State<SkladPage> createState() => _SkladPageState();
// }

// class _SkladPageState extends State<SkladPage> {
//   final TextEditingController nomiController = TextEditingController();
//   final TextEditingController soniController = TextEditingController();
//   final TextEditingController narxiController = TextEditingController();

//   List<Map<String, String>> skladItems = [];

//   void addSkladItem() {
//     if (nomiController.text.isNotEmpty &&
//         soniController.text.isNotEmpty &&
//         narxiController.text.isNotEmpty &&
//         int.tryParse(soniController.text) != null &&
//         double.tryParse(narxiController.text) != null) {
//       setState(() {
//         skladItems.add({
//           "nomi": nomiController.text,
//           "soni": soniController.text,
//           "narxi": narxiController.text,
//         });
//         nomiController.clear();
//         soniController.clear();
//         narxiController.clear();
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Iltimos, barcha maydonlarni to'g'ri to'ldiring!")),
//       );
//     }
//   }

//   void removeSkladItem(int index) {
//     setState(() {
//       skladItems.removeAt(index);
//     });
//   }

//   double getTotalValue() {
//     double totalValue = 0;
//     for (var item in skladItems) {
//       totalValue += (int.parse(item["soni"]!) * double.parse(item["narxi"]!));
//     }
//     return totalValue;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sklad boshqaruvi"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: nomiController,
//               decoration: InputDecoration(
//                 labelText: "Mahsulot nomi",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: soniController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Mahsulot soni",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             TextField(
//               controller: narxiController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Mahsulot narxi",
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: addSkladItem,
//                   child: Text("Mahsulot qo'shish"),
//                 ),
//                 SizedBox(width: 10),
//                 ElevatedButton(
//                   onPressed: () {
//                     nomiController.clear();
//                     soniController.clear();
//                     narxiController.clear();
//                   },
//                   child: Text("Clear"),
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Text(
//               "Jami narx: ${getTotalValue().toStringAsFixed(2)} so'm",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: skladItems.length,
//                 itemBuilder: (context, index) {
//                   final item = skladItems[index];
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 5),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     elevation: 5,
//                     child: ListTile(
//                       contentPadding: EdgeInsets.all(15),
//                       title: Text(
//                         "Mahsulot: ${item["nomi"]}",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Soni: ${item["soni"]}", style: TextStyle(fontSize: 16)),
//                           Text("Narxi: ${item["narxi"]} so'm", style: TextStyle(fontSize: 16)),
//                         ],
//                       ),
//                       trailing: IconButton(
//                         icon: Icon(Icons.delete, color: Colors.red),
//                         onPressed: () => removeSkladItem(index),
//                       ),
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



import 'package:flutter/material.dart';
import 'package:ishxona_uchun_ilova/Mahsulot.dart';


class SkladPage extends StatefulWidget {
  const SkladPage({super.key});

  @override
  State<SkladPage> createState() => _SkladPageState();
}

class _SkladPageState extends State<SkladPage> {
  final TextEditingController nomiController = TextEditingController();
  final TextEditingController soniController = TextEditingController();
  final TextEditingController narxiController = TextEditingController();

  List<Map<String, String>> skladItems = [];

  void addSkladItem() {
    if (nomiController.text.isNotEmpty &&
        soniController.text.isNotEmpty &&
        narxiController.text.isNotEmpty &&
        int.tryParse(soniController.text) != null &&
        double.tryParse(narxiController.text) != null) {
      setState(() {
        skladItems.add({
          "nomi": nomiController.text,
          "soni": soniController.text,
          "narxi": narxiController.text,
        });
        nomiController.clear();
        soniController.clear();
        narxiController.clear();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Iltimos, barcha maydonlarni to'g'ri to'ldiring!")),
      );
    }
  }

  void removeSkladItem(int index) {
    setState(() {
      skladItems.removeAt(index);
    });
  }

  double getTotalValue() {
    double totalValue = 0;
    for (var item in skladItems) {
      totalValue += (int.parse(item["soni"]!) * double.parse(item["narxi"]!));
    }
    return totalValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sklad boshqaruvi"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Text input fields for product details
            TextField(
              controller: nomiController,
              decoration: InputDecoration(
                labelText: "Mahsulot nomi",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: soniController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Mahsulot soni",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: narxiController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Mahsulot narxi",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 10),
            // Add product and Clear buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: addSkladItem,
                    child: Text("Mahsulot qo'shish"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      nomiController.clear();
                      soniController.clear();
                      narxiController.clear();
                    },
                    child: Text("Clear"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Display the total price
            Text(
              "Jami narx: ${getTotalValue().toStringAsFixed(2)} so'm",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            SizedBox(height: 20),
            // Navigate to summary page
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MahsulotlarListPage(mahsulotlar: mahsulotlar)
                //   ),
                // );
              },
              child: Text("Malumotlarni ko'rish"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
            SizedBox(height: 20),
            // Product list
            Expanded(
              child: ListView.builder(
                itemCount: skladItems.length,
                itemBuilder: (context, index) {
                  final item = skladItems[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(15),
                      title: Text(
                        "Mahsulot: ${item["nomi"]}",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Soni: ${item["soni"]}", style: TextStyle(fontSize: 16)),
                          Text("Narxi: ${item["narxi"]} so'm", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeSkladItem(index),
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
