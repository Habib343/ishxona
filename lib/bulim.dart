import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Ischilar.dart';
import 'Mahsulot.dart';
import 'Sklad.dart';
import 'Seriyo.dart';
import 'Xarajatlar.dart';


class Bulim extends StatefulWidget {
  const Bulim({super.key});

  @override
  State<Bulim> createState() => _BulimState();
}

class _BulimState extends State<Bulim> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ishxona Bo'limlari"),
        backgroundColor: Colors.grey[100],
        automaticallyImplyLeading: false, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: List.generate(5, (index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => sahifa(index),
                  ),
                );
              },
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey[300]!,
                      Colors.grey[500]!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getIconForSection(index),
                        size: 40,
                        color: Colors.black,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getSectionName(index),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }


  Widget sahifa(int index) {
    switch (index) {
      case 0:
        return HodimlarPage();
      case 1:
        return MahsulotPage();
      case 2:
        return SkladPage();
      case 3:
        return XomAshyoPage();
      case 4:
        return UmumiyXarajatlarPage();
      default:
        return Scaffold(
          appBar: AppBar(
            title: const Text("Noma'lum bo'lim"),
          ),
          body: const Center(
            child: Text("Bunday bo'lim mavjud emas."),
          ),
        );
    }
  }


  IconData _getIconForSection(int index) {
    switch (index) {
      case 0:
        return CupertinoIcons.person_3;
      case 1:
        return CupertinoIcons.shopping_cart;
      case 2:
        return CupertinoIcons.archivebox;
      case 3:
        return CupertinoIcons.doc;
      case 4:
        return CupertinoIcons.money_dollar;
      default:
        return CupertinoIcons.info;
    }
  }


  String _getSectionName(int index) {
    switch (index) {
      case 0:
        return "Hodimlar ro'yxati";
      case 1:
        return "Mahsulot ro'yxati";
      case 2:
        return "Sklad ro'yxati";
      case 3:
        return "Xom ashyo ro'yxati";
      case 4:
        return "Umumiy xarajatlar";
      default:
        return "Bo'lim";
    }
  }
}
