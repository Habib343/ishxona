
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ishxona_uchun_ilova/bulim.dart';

class UmumiyXarajatlarPage extends StatefulWidget {
  const UmumiyXarajatlarPage({super.key});

  @override
  State<UmumiyXarajatlarPage> createState() => _UmumiyXarajatlarPageState();
}

class _UmumiyXarajatlarPageState extends State<UmumiyXarajatlarPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mahsulotController = TextEditingController();
  final TextEditingController _soniController = TextEditingController();
  final TextEditingController _narxiController = TextEditingController();
  final TextEditingController _hodimIsmiController = TextEditingController();
  final TextEditingController _lavozimiController = TextEditingController();
  final TextEditingController _oyligiController = TextEditingController();
  final TextEditingController _xomashyoController = TextEditingController();
  final TextEditingController _xomashyoMiqdoriController = TextEditingController();
  final TextEditingController _xomashyoNarxiController = TextEditingController();
  final TextEditingController _skladMahsulotController = TextEditingController();
  final TextEditingController _skladMiqdoriController = TextEditingController();

  final List<Map<String, dynamic>> _xarajatlar = [];
  final List<Map<String, dynamic>> _hodimlar = [];
  final List<Map<String, dynamic>> _xomashyolar = [];
  final List<Map<String, dynamic>> _sklad = [];
  final String _currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _mahsulotController.dispose();
    _soniController.dispose();
    _narxiController.dispose();
    _hodimIsmiController.dispose();
    _lavozimiController.dispose();
    _oyligiController.dispose();
    _xomashyoController.dispose();
    _xomashyoMiqdoriController.dispose();
    _xomashyoNarxiController.dispose();
    _skladMahsulotController.dispose();
    _skladMiqdoriController.dispose();
    super.dispose();
  }

  void _saveMahsulotData() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _xarajatlar.add({
          'kun': _currentDate,
          'mahsulot': _mahsulotController.text,
          'soni': _soniController.text,
          'narxi': _narxiController.text,
          'jami': int.parse(_soniController.text) * double.parse(_narxiController.text),
        });
      });
      _resetForm();
    }
  }

  void _saveHodimData() {
    setState(() {
      _hodimlar.add({
        'ismi': _hodimIsmiController.text,
        'lavozimi': _lavozimiController.text,
        'oyligi': double.parse(_oyligiController.text),
      });
    });
    _resetHodimForm();
  }

  void _saveXomashyoData() {
    setState(() {
      _xomashyolar.add({
        'xomashyo': _xomashyoController.text,
        'miqdori': _xomashyoMiqdoriController.text,
        'narxi': _xomashyoNarxiController.text,
        'jami': int.parse(_xomashyoMiqdoriController.text) * double.parse(_xomashyoNarxiController.text),
      });
    });
    _resetXomashyoForm();
  }

  void _saveSkladData() {
    setState(() {
      _sklad.add({
        'mahsulot': _skladMahsulotController.text,
        'miqdori': int.parse(_skladMiqdoriController.text),
      });
    });
    _resetSkladForm();
  }

  void _resetForm() {
    _mahsulotController.clear();
    _soniController.clear();
    _narxiController.clear();
  }

  void _resetHodimForm() {
    _hodimIsmiController.clear();
    _lavozimiController.clear();
    _oyligiController.clear();
  }

  void _resetXomashyoForm() {
    _xomashyoController.clear();
    _xomashyoMiqdoriController.clear();
    _xomashyoNarxiController.clear();
  }

  void _resetSkladForm() {
    _skladMahsulotController.clear();
    _skladMiqdoriController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Umumiy Hisobotlar'),
                leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Bulim(),),);}, icon: Icon(Icons.arrow_back_ios)),

        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Mahsulotlar'),
            Tab(text: 'Hodimlar'),
            Tab(text: 'Xomashyo'),
            Tab(text: 'Sklad'),
            Tab(text: 'Hisobotlar'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMahsulotlarTab(),
          _buildHodimlarTab(),
          _buildXomashyoTab(),
          _buildSkladTab(),
          _buildHisobotlarTab(),
        ],
      ),
    );
  }

  Widget _buildMahsulotlarTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _mahsulotController,
                  decoration: const InputDecoration(labelText: 'Mahsulot nomi'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mahsulot nomini kiriting';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _soniController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Mahsulot soni'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mahsulot sonini kiriting';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _narxiController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Mahsulot narxi'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mahsulot narxini kiriting';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveMahsulotData,
                  child: const Text('Mahsulotni saqlash'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _xarajatlar.length,
              itemBuilder: (context, index) {
                final xarajat = _xarajatlar[index];
                return ListTile(
                  title: Text('${xarajat['mahsulot']} (${xarajat['kun']})'),
                  subtitle: Text('Soni: ${xarajat['soni']}, Narxi: ${xarajat['narxi']} so‘m'),
                  trailing: Text('Jami: ${xarajat['jami']} so‘m'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHodimlarTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: _hodimIsmiController,
            decoration: const InputDecoration(labelText: 'Hodim ismi'),
          ),
          TextFormField(
            controller: _lavozimiController,
            decoration: const InputDecoration(labelText: 'Lavozimi'),
          ),
          TextFormField(
            controller: _oyligiController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Oyligi (so‘m)'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveHodimData,
            child: const Text('Hodimni saqlash'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _hodimlar.length,
              itemBuilder: (context, index) {
                final hodim = _hodimlar[index];
                return ListTile(
                  title: Text('${hodim['ismi']} (${hodim['lavozimi']})'),
                  trailing: Text('${hodim['oyligi']} so‘m'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXomashyoTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: _xomashyoController,
            decoration: const InputDecoration(labelText: 'Xomashyo nomi'),
          ),
          TextFormField(
            controller: _xomashyoMiqdoriController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Miqdori'),
          ),
          TextFormField(
            controller: _xomashyoNarxiController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Narxi (so‘m)'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveXomashyoData,
            child: const Text('Xomashyoni saqlash'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _xomashyolar.length,
              itemBuilder: (context, index) {
                final xomashyo = _xomashyolar[index];
                return ListTile(
                  title: Text('${xomashyo['xomashyo']}'),
                  subtitle: Text('Miqdori: ${xomashyo['miqdori']}, Narxi: ${xomashyo['narxi']} so‘m'),
                  trailing: Text('Jami: ${xomashyo['jami']} so‘m'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkladTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            controller: _skladMahsulotController,
            decoration: const InputDecoration(labelText: 'Mahsulot nomi'),
          ),
          TextFormField(
            controller: _skladMiqdoriController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Miqdori'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveSkladData,
            child: const Text('Skladga saqlash'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _sklad.length,
              itemBuilder: (context, index) {
                final sklad = _sklad[index];
                return ListTile(
                  title: Text('${sklad['mahsulot']}'),
                  trailing: Text('Miqdori: ${sklad['miqdori']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHisobotlarTab() {
    double jamiMahsulotXarajatlari = _xarajatlar.fold(0, (sum, item) => sum + item['jami']);
    double jamiHodimlarOyliklari = _hodimlar.fold(0, (sum, item) => sum + item['oyligi']);
    double jamiXomashyoXarajatlari = _xomashyolar.fold(0, (sum, item) => sum + item['jami']);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildHisobotRow('Jami Mahsulot xarajatlari', jamiMahsulotXarajatlari),
          _buildHisobotRow('Jami Hodimlar oyliklari', jamiHodimlarOyliklari),
          _buildHisobotRow('Jami Xomashyo xarajatlari', jamiXomashyoXarajatlari),
          _buildHisobotRow(
              'Umumiy xarajatlar',
              jamiMahsulotXarajatlari + jamiHodimlarOyliklari + jamiXomashyoXarajatlari),
        ],
      ),
    );
  }

  Widget _buildHisobotRow(String title, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text('${value.toStringAsFixed(2)} so‘m', style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
