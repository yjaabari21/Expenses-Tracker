import 'package:flutter/material.dart';

import "package:expenes_tracker/models/expense.dart";
import 'package:flutter/widgets.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAdd});

  final void Function(Expense expe) onAdd;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.other;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 10, now.month, now.day);
    //final lastDate = DateTime.fromMillisecondsSinceEpoch(1640979000000000);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenses() {
    final amount = double.tryParse(_amountController.text);
    final amountInvalid = amount == null || amount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Date & Amount , Title cant be null."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }
    widget.onAdd(
      Expense(
          title: _titleController.text,
          amount: amount,
          date: _selectedDate!,
          category: _selectedCategory),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final KeyPace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + KeyPace),
              child: Column(
                children: [
                  if (constraints.maxWidth >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _titleController,
                            maxLength: 50,
                            decoration: const InputDecoration(
                              label: Text('Title'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '\$ ',
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: _titleController,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        label: Text('Title'),
                      ),
                    ),
                  if (constraints.maxWidth >= 600)
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No date selected'
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(
                                  Icons.calendar_month,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '\$ ',
                              label: Text('Amount'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No date selected'
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: const Icon(
                                  Icons.calendar_month,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (constraints.maxWidth >= 600)
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _submitExpenses();
                          },
                          child: const Text('Save Expense'),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          value: _selectedCategory,
                          items: Category.values
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item.name.toUpperCase(),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _submitExpenses();
                          },
                          child: const Text('Save Expense'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}


// import 'package:expenes_tracker/models/expense.dart';
// import 'package:flutter/material.dart';

// class NewExpense extends StatefulWidget {
//   const NewExpense({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return _NewExpenseState();
//   }
// }

// class _NewExpenseState extends State<NewExpense> {
//   final _titleController = TextEditingController();
//   final _amountController = TextEditingController();

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _amountController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               maxLength: 50,
//               decoration: const InputDecoration(
//                 label: Text("Title"),
//               ),
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _amountController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       label: Text("Amount"),
//                       prefixText: '\$',
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 16,
//                 ),
//                 const Expanded(
//                   child: Row(
//                     children: [
//                       Text("Selected Date"),
//                       IconButton(
//                           onPressed: () {},
//                           icon: const Icon(Icons.calendar_month))
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     print(_titleController.text);
//                     print(_amountController.text);
//                   },
//                   child: const Text("Save Expenses"),
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Cancel...'),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }