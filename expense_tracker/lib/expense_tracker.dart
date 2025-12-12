import 'package:flutter/material.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
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
                          decoration: InputDecoration(
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
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
                          onPressed: () {},
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
    );
  }
}
