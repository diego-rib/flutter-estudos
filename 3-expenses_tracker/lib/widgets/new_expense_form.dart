import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expenses_tracker/models/expenses.dart';
import 'package:flutter/material.dart';

class NewExpenseForm extends StatefulWidget {
  const NewExpenseForm({super.key, required this.onAddExpense});

  final void Function(Expense item) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseFormState();
  }
}

class _NewExpenseFormState extends State<NewExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _expenseDate;
  Category _selectedCategory = Category.leisure;

  final CurrencyTextInputFormatter _amountFormatter =
      CurrencyTextInputFormatter.currency(
    locale: 'pt-Br',
    symbol: 'R\$ ',
  );

  void _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _expenseDate = pickedDate;
    });
  }

  void _submitExpense() {
    final amountIsValid = _amountFormatter.getUnformattedValue() > 0;

    if (_titleController.text.trim().isEmpty ||
        !amountIsValid ||
        _expenseDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    final payload = Expense(
      title: _titleController.text,
      amount: _amountFormatter.getUnformattedValue().toDouble(),
      date: _expenseDate!,
      category: _selectedCategory,
    );

    widget.onAddExpense(payload);
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  inputFormatters: [_amountFormatter],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(label: Text('Amount')),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  children: [
                    Text(
                      _expenseDate == null
                          ? 'Selected Date'
                          : dateFormatter.format(_expenseDate!),
                    ),
                    IconButton(
                      onPressed: _openDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _submitExpense,
                child: const Text('Save expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
