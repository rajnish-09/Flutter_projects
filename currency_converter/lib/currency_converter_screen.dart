import 'package:flutter/material.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  TextEditingController inputController = TextEditingController();
  List<String> items = ['NPR', 'INR', 'USD', 'AUD', 'YEN', 'WON'];
  String? selectedValue = 'NPR';
  String fromValue = 'NPR', toValue = 'NPR';

  Map<String, double> rates = {
    'NPR': 1,
    'INR': 1.6,
    'USD': 133,
    'AUD': 95,
    'YEN': 0.9,
    'WON': 0.10,
  };
  double convertedValue = 0;

  void convertCurrency() {
    if (inputController.text.isEmpty) {
      setState(() {
        convertedValue = 0;
      });
      return;
    } else {
      double amount = double.tryParse(inputController.text) ?? 0;
      double npr = amount * rates[fromValue]!;
      double res = npr * rates[toValue]!;
      setState(() {
        convertedValue = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Currency converter app",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                "To convert currency select the required from the following",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Dropdown(
                    items: items,
                    selectedValue: fromValue,
                    onChanged: (value) {
                      setState(() {
                        fromValue = value!;
                      });
                    },
                    inputController: inputController,
                  ),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: inputController,
                      decoration: InputDecoration(labelText: 'Enter amount'),
                      onChanged: (value) => convertCurrency(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Dropdown(
                    items: items,
                    selectedValue: toValue,
                    onChanged: (value) {
                      setState(() {
                        toValue = value!;
                      });
                      convertCurrency();
                    },
                    inputController: inputController,
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      convertedValue.toStringAsFixed(2),
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Dropdown extends StatefulWidget {
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String?> onChanged;
  final TextEditingController inputController;
  const Dropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.inputController,
  });

  @override
  State<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 100,
          child: DropdownButton<String>(
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            value: widget.selectedValue,
            onChanged: widget.onChanged,
          ),
        ),
      ],
    );
  }
}
