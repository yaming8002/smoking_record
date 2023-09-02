import 'package:flutter/material.dart';

class CigaretteAmountWidget extends StatefulWidget {
  final int? initialAmount;
  final Function(int) onAmountChanged;

  const CigaretteAmountWidget(
      {Key? key, this.initialAmount, required this.onAmountChanged})
      : super(key: key);

  @override
  _CigaretteAmountWidget createState() => _CigaretteAmountWidget();
}

class _CigaretteAmountWidget extends State<CigaretteAmountWidget> {
  late TextEditingController amountController;
  int amount;

  _CigaretteAmountWidget() : amount = 1;

  @override
  void initState() {
    super.initState();
    amount = widget.initialAmount ?? 1;
    amountController = TextEditingController(text: amount.toString());

    amountController.addListener(() {
      int? newAmount = int.tryParse(amountController.text);
      if (newAmount != null) {
        amount = newAmount;
        widget
            .onAmountChanged(amount); // Notify the parent widget of the change
      }
    });
  }

  void increment() {
    setState(() {
      amount++;
      amountController.text = amount.toString();
      widget.onAmountChanged(amount); // Notify the parent widget of the change
    });
  }

  void decrement() {
    setState(() {
      if (amount > 1) {
        amount--;
        amountController.text = amount.toString();
        widget
            .onAmountChanged(amount); // Notify the parent widget of the change
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: decrement,
        ),
        Container(
          width: 50.0, // 指定的寬度
          child: TextField(
            keyboardType: TextInputType.number,
            controller: amountController,
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: increment,
        ),
      ],
    );
  }
}
