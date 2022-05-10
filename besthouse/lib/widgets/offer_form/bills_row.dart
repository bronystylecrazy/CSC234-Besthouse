import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// widgets
import 'text_label.dart';

class BillsRow extends StatelessWidget {
  const BillsRow({
    this.electricFee = 0.0,
    this.waterFee = 0.0,
    required this.changeHandler,
    required this.decimalRegex,
    Key? key,
  }) : super(key: key);

  final double electricFee;
  final double waterFee;
  final Function changeHandler;
  final RegExp decimalRegex;

  @override
  Widget build(BuildContext context) {
    const OutlineInputBorder border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(16),
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.43,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextLabel("Electric bill", subLabel: "(฿/Unit)"),
              TextFormField(
                initialValue: electricFee.toString(),
                onChanged: (String value) =>
                    changeHandler('electricFee', double.parse(value)),
                validator: (value) {
                  if (value == null || double.parse(value) == 0) {
                    return 'Please enter electric bill';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(decimalRegex)
                ],
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  filled: true,
                  border: border,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.43,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextLabel("Water bill", subLabel: "(฿/Unit)"),
              TextFormField(
                initialValue: waterFee.toString(),
                onChanged: (String value) =>
                    changeHandler('waterFee', double.parse(value)),
                validator: (value) {
                  if (value == null || double.parse(value) == 0) {
                    return 'Please enter water bill';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(decimalRegex)
                ],
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.tertiary,
                  filled: true,
                  border: border,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
