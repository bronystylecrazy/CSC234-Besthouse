import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInfo extends StatefulWidget {
  const TextInfo(
      {Key? key,
      required this.label,
      required this.value,
      required this.isEditable})
      : super(key: key);

  final String label;
  final String value;
  final bool isEditable;

  @override
  State<TextInfo> createState() => _TextInfoState();
}

class _TextInfoState extends State<TextInfo> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Column(
      children: [
        Stack(
          children: [
            Positioned(
              top: 8,
              child: Text(widget.label,
                  style: const TextStyle(
                    color: Colors.black26,
                    fontSize: 14,
                  )),
            ),
            Container(
              height: 65,
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black12),
                ),
              ),

              // padding: const EdgeInsets.symmetric(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.value != "" ? widget.value : "-",
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  widget.isEditable
                      ? GestureDetector(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          onTap: () {
                            controller.text = widget.value;
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15.0))),
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width,
                                  height: 180,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          "Editing ${widget.label}",
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                      TextField(
                                        autofocus: true,
                                        controller: controller,
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Confirm"))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Container()
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
