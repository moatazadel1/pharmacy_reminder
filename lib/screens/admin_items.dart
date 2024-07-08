import 'package:flutter/material.dart';
import 'package:reminder_app/components/buttons.dart';
import 'package:reminder_app/screens/add_item.dart';
import 'package:reminder_app/screens/calender.dart';
import 'package:reminder_app/screens/create_admin.dart';
import 'package:reminder_app/screens/homepage.dart';
import 'package:reminder_app/screens/setting.dart';

class AdminItems extends StatefulWidget {
  const AdminItems({super.key});

  @override
  State<AdminItems> createState() => _AdminItemsState();
}

int index = 2;

class _AdminItemsState extends State<AdminItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 244, 243, 243),
          title: const Text(
            "Items",
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          leading: const BackButton(color: Color(0xFF295c82)),
        ),
        body: Column(
          children: [
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 20.0,
                  columns: const [
                    DataColumn(
                        label: Expanded(child: Center(child: Text('Name')))),
                    DataColumn(
                        label: Expanded(child: Center(child: Text('Image')))),
                    DataColumn(
                        label: Expanded(child: Center(child: Text('Price')))),
                    DataColumn(
                        label: Expanded(child: Center(child: Text('Type')))),
                    DataColumn(
                        label: Expanded(child: Center(child: Text('Delete')))),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('panadol')),
                      DataCell(Text('image')),
                      DataCell(Text('20 LE')),
                      DataCell(Text('Pills')),
                      DataCell(
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 24,
                        ),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Cogestal')),
                      DataCell(Text('image')),
                      DataCell(Text('45 LE')),
                      DataCell(Text('syrup')),
                      DataCell(
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 24,
                        ),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Cogestal')),
                      DataCell(Text('image')),
                      DataCell(Text('45 LE')),
                      DataCell(Text('syrup')),
                      DataCell(
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 24,
                        ),
                      ),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Cogestal')),
                      DataCell(Text('image')),
                      DataCell(Text('56 LE')),
                      DataCell(Text('Pills')),
                      DataCell(
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 24,
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: CustomButton(
                title: 'Add Item',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return const CreateAdmin();
                    }),
                  );
                },
              ),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
              if (index == 0) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const HomePage();
                }));
              } else if (index == 1) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const Calender();
                }));
              } else if (index == 2) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const Add();
                }));
              } else if (index == 3) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const Settings();
                }));
              }
            });
          },
          currentIndex: 2,
          unselectedFontSize: 15,
          unselectedItemColor: Colors.grey,
          selectedItemColor: const Color(0xFF295c82),
          selectedLabelStyle: const TextStyle(fontSize: 13),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Color.fromARGB(255, 230, 230, 230)),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: "Calender",
                backgroundColor: Color.fromARGB(255, 230, 230, 230)),
            BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: "Add",
                backgroundColor: Color.fromARGB(255, 230, 230, 230)),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
                backgroundColor: Color.fromARGB(255, 230, 230, 230)),
          ],
        ));
  }
}
