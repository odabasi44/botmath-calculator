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

    final isTR = widget.translations['power'] == 'Üs';
    setState(() {
      _result = '$years ${isTR ? 'Yıl' : 'Years'}, $months ${isTR ? 'Ay' : 'Months'}, $days ${isTR ? 'Gün' : 'Days'}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.scaffoldBackgroundColor,
      appBar: AppBar(title: Text(widget.translations['age_calc'] ?? 'Age Calculator'), backgroundColor: widget.theme.scaffoldBackgroundColor, iconTheme: IconThemeData(color: widget.theme.displayTextColor)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              title: Text(_birthDate == null ? widget.translations['select_birth_date']! : '${widget.translations['birth_date']!}: ${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}', style: TextStyle(color: widget.theme.displayTextColor)),
              trailing: Icon(Icons.calendar_today, color: widget.theme.operatorBackground),
              onTap: () async {
                final date = await showDatePicker(context: context, initialDate: DateTime(2000), firstDate: DateTime(1900), lastDate: DateTime.now());
                if (date != null) setState(() => _birthDate = date);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculateAge, style: ElevatedButton.styleFrom(backgroundColor: Colors.pink, foregroundColor: Colors.white), child: Text(widget.translations['calculate_btn']!)),
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
    final isTR = widget.translations['power'] == 'Üs';
    if (bmi < 18.5) status = isTR ? 'Zayıf' : 'Underweight';
    else if (bmi < 25) status = isTR ? 'Normal' : 'Normal';
    else if (bmi < 30) status = isTR ? 'Kilolu' : 'Overweight';
    else status = isTR ? 'Obez' : 'Obese';

    setState(() {
      _result = bmi.toStringAsFixed(1);
      _status = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.theme.scaffoldBackgroundColor,
      appBar: AppBar(title: Text(widget.translations['bmi_calc']!), backgroundColor: widget.theme.scaffoldBackgroundColor, iconTheme: IconThemeData(color: widget.theme.displayTextColor)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _heightController, decoration: InputDecoration(labelText: widget.translations['height_cm'], labelStyle: TextStyle(color: widget.theme.displayTextColor.withOpacity(0.5))), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            TextField(controller: _weightController, decoration: InputDecoration(labelText: widget.translations['weight_kg'], labelStyle: TextStyle(color: widget.theme.displayTextColor.withOpacity(0.5))), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculateBMI, style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white), child: Text(widget.translations['calculate_btn']!)),
            const SizedBox(height: 40),
            if (_result.isNotEmpty) ...[
              Text('${widget.translations['bmi_label']}: $_result', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: widget.theme.displayTextColor)),
              Text('${widget.translations['status_label']}: $_status', style: TextStyle(fontSize: 18, color: Colors.blue)),
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
      appBar: AppBar(title: Text(widget.translations['discount_calc']!), backgroundColor: widget.theme.scaffoldBackgroundColor, iconTheme: IconThemeData(color: widget.theme.displayTextColor)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _priceController, decoration: InputDecoration(labelText: widget.translations['price_label'], labelStyle: TextStyle(color: widget.theme.displayTextColor.withOpacity(0.5))), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            TextField(controller: _discountController, decoration: InputDecoration(labelText: widget.translations['discount_percent'], labelStyle: TextStyle(color: widget.theme.displayTextColor.withOpacity(0.5))), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, foregroundColor: Colors.white), child: Text(widget.translations['calculate_btn']!)),
            const SizedBox(height: 40),
            if (_finalPrice.isNotEmpty) ...[
              Text('${widget.translations['final_price']}: $_finalPrice TL', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
              Text('${widget.translations['savings_label']}: $_savings TL', style: TextStyle(fontSize: 18, color: widget.theme.displayTextColor)),
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
      appBar: AppBar(title: Text(widget.translations['tip_calc']!), backgroundColor: widget.theme.scaffoldBackgroundColor, iconTheme: IconThemeData(color: widget.theme.displayTextColor)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _billController, decoration: InputDecoration(labelText: widget.translations['bill_amount'], labelStyle: TextStyle(color: widget.theme.displayTextColor.withOpacity(0.5))), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            TextField(controller: _tipController, decoration: InputDecoration(labelText: widget.translations['tip_percent'], labelStyle: TextStyle(color: widget.theme.displayTextColor.withOpacity(0.5))), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            TextField(controller: _peopleController, decoration: InputDecoration(labelText: widget.translations['people_count'], labelStyle: TextStyle(color: widget.theme.displayTextColor.withOpacity(0.5))), keyboardType: TextInputType.number, style: TextStyle(color: widget.theme.displayTextColor)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculate, style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.white), child: Text(widget.translations['calculate_btn']!)),
            const SizedBox(height: 40),
            if (_totalTip.isNotEmpty) ...[
              Text('${widget.translations['total_tip']}: $_totalTip TL', style: TextStyle(fontSize: 18, color: widget.theme.displayTextColor)),
              Text('${widget.translations['per_person']}: $_perPerson TL', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
            ]
          ],
        ),
      ),
    );
  }
}
