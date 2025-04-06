import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController controller = TextEditingController();
  bool? isChecked = false;
  bool isSwitched = false;
  double sliderVal = 0.0;
  String? menuItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //elevated button
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text('Snack Bar'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade200,
                    foregroundColor: Colors.white60,
                  ),
                  child: Text('Open SnackBar'),
                ),
              ),

              Divider(
                color: Colors.white60,
                thickness: 1.5,
              ),

              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('Alert Content'),
                          title: Text('Alert Title'),
                          actions: [
                            FilledButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Close'),
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.white60,
                                foregroundColor: Colors.black54,
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade500,
                    foregroundColor: Colors.white60,
                  ),
                  child: Text('Show Alert'),
                ),
              ),


              //dropdown
              DropdownButton(
                value: menuItem,
                hint: Text('Select an Item'),
                items: [
                  DropdownMenuItem(
                    value: 'e1',
                    child: Text('Element 1'),
                  ),
                  DropdownMenuItem(
                    value: 'e2',
                    child: Text('Element 2'),
                  ),
                  DropdownMenuItem(
                    value: 'e3',
                    child: Text('Element 3'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    menuItem = value;
                  });
                },
              ),

              //textfield
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onEditingComplete: () => setState(() {}),
              ),
              // Text(controller.text),

              //checkbox
              Checkbox(
                tristate: true,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),

              CheckboxListTile(
                tristate: true,
                title: Text(controller.text),
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value;
                  });
                },
              ),

              //switch
              Switch(
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),

              SwitchListTile(
                title: Text('Are you Ok'),
                value: isSwitched,
                onChanged: (bool value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),

              //slider
              Slider(
                max: 100.0,
                divisions: 20,
                value: sliderVal,
                onChanged: (double value) {
                  setState(() {
                    sliderVal = value;
                  });
                },
              ),

              //gesture detector for image tap
              GestureDetector(
                onTap: () {
                  print('Clicked');
                },
                child: Image.asset('assets/landscape.jpg'),
              ),

              SizedBox(
                height: 20.0,
              ),

              //inkwell for splash effect on div
              InkWell(
                onTap: () {
                  print('Clicked 2');
                },
                splashColor: Colors.white24,
                child: Container(
                  height: 200.0,
                  width: double.infinity,
                  color: Colors.white12,
                ),
              ),

              SizedBox(
                height: 20.0,
              ),

              // FilledButton(onPressed: () {}, child: Text('Click Me')),

              // OutlinedButton(
              //   onPressed: () {},
              //   child: Text('Hey'),
              // ),
              //
              // BackButton(),
              // CloseButton(),
            ],
          ),
        ),
      ),
    );
  }
}
