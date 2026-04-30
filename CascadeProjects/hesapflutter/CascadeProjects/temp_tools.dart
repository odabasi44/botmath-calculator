
// --- NEW TOOLS SCREENS ---

class AgeCalculatorScreen extends StatefulWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final bool isPremium;

  const AgeCalculatorScreen({super.key, required this.translations, required this.theme, required this.isPremium});

  @override
  State<AgeCalculatorScreen> createState() => _AgeCalculatorScreenState();
}

class _AgeCalculatorScreenState extends State<AgeCalculatorScreen> {
  DateTime? _birthDate;
  String _result = '';

  void _calculateAge() {
    if (_birthDate == null) return;
    final now = DateTime.now();
    int years = now.year - _birthDate!.year;
    int months = now.month - _birthDate!.month;
    int days = now.day - _birthDate!.day;

    if (days < 0) {
      months -= 1;
      days += DateTime(now.year, now.month, 0).day;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    setState(() {
      _result = '$years Yıl, $months Ay, $days Gün';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Yaş Hesaplama'), backgroundColor: widget.theme.scaffoldBackgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              title: Text(_birthDate == null ? 'Doğum Tarihi Seçin' : 'Doğum Tarihi: ${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}', style: TextStyle(color: widget.theme.displayTextColor)),
              trailing: Icon(Icons.calendar_today, color: widget.theme.operatorBackground),
              onTap: () async {
                final date = await showDatePicker(context: context, initialDate: DateTime(2000), firstDate: DateTime(1900), lastDate: DateTime.now());
                if (date != null) setState(() => _birthDate = date);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculateAge, style: ElevatedButton.styleFrom(backgroundColor: Colors.pink), child: const Text('Hesapla')),
            const SizedBox(height: 40),
            if (_result.isNotEmpty) Text(_result, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: widget.theme.displayTextColor)),
          ],
        ),
      ),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final bool isPremium;

  const BMICalculatorScreen({super.key, required this.translations, required this.theme, required this.isPremium});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String _result = '';
  String _status = '';

  void _calculateBMI() {
    final h = double.tryParse(_heightController.text);
    final w = double.tryParse(_weightController.text);
    if (h == null || w == null || h == 0) return;

    final bmi = w / ((h / 100) * (h / 100));
    String status = '';
    if (bmi < 18.5) status = 'Zayıf';
    else if (bmi < 25) status = 'Normal';
    else if (bmi < 30) status = 'Fazla Kilolu';
    else status = 'Obez';

    setState(() {
      _result = bmi.toStringAsFixed(1);
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('VKI Hesaplama'), backgroundColor: widget.theme.scaffoldBackgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _heightController, decoration: const InputDecoration(labelText: 'Boy (cm)'), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            TextField(controller: _weightController, decoration: const InputDecoration(labelText: 'Kilo (kg)'), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculateBMI, style: ElevatedButton.styleFrom(backgroundColor: Colors.teal), child: const Text('Hesapla')),
            const SizedBox(height: 40),
            if (_result.isNotEmpty) ...[
              Text('VKI: $_result', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: widget.theme.displayTextColor)),
              Text('Durum: $_status', style: TextStyle(fontSize: 18, color: Colors.blue)),
            ]
          ],
        ),
      ),
    );
  }
}

class DiscountCalculatorScreen extends StatefulWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final bool isPremium;

  const DiscountCalculatorScreen({super.key, required this.translations, required this.theme, required this.isPremium});

  @override
  State<DiscountCalculatorScreen> createState() => _DiscountCalculatorScreenState();
}

class _DiscountCalculatorScreenState extends State<DiscountCalculatorScreen> {
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();
  String _finalPrice = '';
  String _savings = '';

  void _calculate() {
    final price = double.tryParse(_priceController.text);
    final discount = double.tryParse(_discountController.text);
    if (price == null || discount == null) return;

    final savings = price * (discount / 100);
    final finalPrice = price - savings;

    setState(() {
      _finalPrice = finalPrice.toStringAsFixed(2);
      _savings = savings.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: widget.theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('İndirim Hesaplama'), backgroundColor: widget.theme.scaffoldBackgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Etiket Fiyatı'), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            TextField(controller: _discountController, decoration: const InputDecoration(labelText: 'İndirim Oranı (%)'), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent), child: const Text('Hesapla')),
            const SizedBox(height: 40),
            if (_finalPrice.isNotEmpty) ...[
              Text('Son Fiyat: $_finalPrice TL', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
              Text('Kazancınız: $_savings TL', style: TextStyle(fontSize: 18, color: widget.theme.displayTextColor)),
            ]
          ],
        ),
      ),
    );
  }
}

class TipCalculatorScreen extends StatefulWidget {
  final Map<String, String> translations;
  final CalculatorThemeData theme;
  final bool isPremium;

  const TipCalculatorScreen({super.key, required this.translations, required this.theme, required this.isPremium});

  @override
  State<TipCalculatorScreen> createState() => _TipCalculatorScreenState();
}

class _TipCalculatorScreenState extends State<TipCalculatorScreen> {
  final _billController = TextEditingController();
  final _tipController = TextEditingController();
  final _peopleController = TextEditingController();
  String _totalTip = '';
  String _perPerson = '';

  void _calculate() {
    final bill = double.tryParse(_billController.text);
    final tipPercent = double.tryParse(_tipController.text);
    final people = int.tryParse(_peopleController.text);
    if (bill == null || tipPercent == null || people == null || people == 0) return;

    final totalTip = bill * (tipPercent / 100);
    final totalBill = bill + totalTip;
    final perPerson = totalBill / people;

    setState(() {
      _totalTip = totalTip.toStringAsFixed(2);
      _perPerson = perPerson.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.scaffoldBackgroundColor,
      appBar: AppBar(title: const Text('Bahşiş Hesaplama'), backgroundColor: widget.theme.scaffoldBackgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _billController, decoration: const InputDecoration(labelText: 'Hesap Tutarı'), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            TextField(controller: _tipController, decoration: const InputDecoration(labelText: 'Bahşiş Oranı (%)'), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            TextField(controller: _peopleController, decoration: const InputDecoration(labelText: 'Kişi Sayısı'), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber), child: const Text('Hesapla')),
            const SizedBox(height: 40),
            if (_totalTip.isNotEmpty) ...[
              Text('Toplam Bahşiş: $_totalTip TL', style: TextStyle(fontSize: 18, color: widget.theme.displayTextColor)),
              Text('Kişi Başı Toplam: $_perPerson TL', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
            ]
          ],
        ),
      ),
    );
  }
}
