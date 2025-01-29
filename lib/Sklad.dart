import 'package:flutter/material.dart';
import 'package:ishxona_uchun_ilova/Mahsulot.dart';
import 'package:ishxona_uchun_ilova/bulim.dart';

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
        SnackBar(
            content: Text("Iltimos, barcha maydonlarni to'g'ri to'ldiring!")),
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
          children: [
            // Text input fields for product details
            TextField(
              controller: nomiController,
              decoration: InputDecoration(
                labelText: "Mahsulot nomi",
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    nomiController.clear();
                  },
                ),
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
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    soniController.clear();
                  },
                ),
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
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    narxiController.clear();
                  },
                ),
              ),
            ),

            SizedBox(height: 10),
            // Add product and Clear buttons
            Row(
              children: [
                Container(
                  height: 40,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: addSkladItem,
                    child: Text(
                      "Mahsulot qo'shish",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
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
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 20),
            // Navigate to summary page
           ElevatedButton(
  onPressed: () {
    // Correct way to navigate to MahsulotlarListPage
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Mahsulotnomi(mahsulotlar: [],),
      ),
    );
  },
  child: Text(
    "Ma'lumotlarni ko'rish",
    style: TextStyle(color: Colors.black),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey,
    padding: EdgeInsets.symmetric(vertical: 17),
  ),
),



            SizedBox(height: 20),

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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Soni: ${item["soni"]}",
                              style: TextStyle(fontSize: 16)),
                          Text("Narxi: ${item["narxi"]} so'm",
                              style: TextStyle(fontSize: 16)),
                        ],
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
