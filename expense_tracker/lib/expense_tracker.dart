import 'package:flutter/material.dart';

class Expense {
  String title;
  double amount;
  Expense({required this.title, required this.amount});
}

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  String? titleError, amountError;
  List<Expense> expenses = [];
  double total = 0;
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  void showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, bottomSetState) {
            return SizedBox(
              // height: 100,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        Text(
                          "Add your expense",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 15),
                        TextField(
                          controller: titleController,
                          onChanged: (_) {
                            bottomSetState(() {
                              titleError = null;
                            });
                          },
                          decoration: InputDecoration(
                            errorText: titleError,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.solid),
                            ),
                            hintText: 'Enter expense title',
                            prefixIcon: Icon(Icons.pending),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: amountController,
                          onChanged: (_) {
                            bottomSetState(() {
                              amountError = null;
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            errorText: amountError,
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(style: BorderStyle.solid),
                            ),
                            prefixIcon: Icon(Icons.monetization_on),
                            hintText: 'Enter amount',
                          ),
                        ),
                        SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {
                            if (titleController.text.isEmpty) {
                              bottomSetState(() {
                                titleError = 'Please enter expense title';
                              });
                              return;
                            } else if (amountController.text.isEmpty) {
                              bottomSetState(() {
                                amountError = 'Please enter amount';
                              });
                              return;
                            }
                            addToList(
                              titleController.text,
                              double.tryParse(amountController.text)!,
                            );
                            Navigator.pop(context);
                            titleController.text = '';
                            amountController.text = '';
                          },
                          child: Text("Add expense"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void addToList(String title, double amount) {
    setState(() {
      final data = Expense(title: title, amount: amount);
      expenses.add(data);
    });
    for (var e in expenses) {
      total += e.amount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Expense tracker")),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30, right: 30),
        child: FloatingActionButton(
          onPressed: () {
            showBottomSheet();
          },
          child: Icon(Icons.add),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total: $total",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: expenses.isEmpty
                  ? Text("No data found.")
                  : ListView.builder(
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(expenses[index].title),
                          subtitle: Text('${expenses[index].amount}'),
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
