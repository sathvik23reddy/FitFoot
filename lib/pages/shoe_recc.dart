import 'package:flutter/material.dart';
import 'package:lazy_load_listview/lazy_load_listview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/shoe.dart';
import 'shoe_item.dart';

class shoeRecom extends StatefulWidget {
  const shoeRecom({super.key, required this.arch_type, required this.toe_type});
  final String arch_type, toe_type;
  @override
  State<shoeRecom> createState() => _shoeRecomState();
}

class _shoeRecomState extends State<shoeRecom> {
  List<shoe> shoes = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getShoes(widget.arch_type, widget.toe_type);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : LazyLoadListView(
              listItems: shoes,
              listItemType: LazyLoadListViewItemType.customListItemType,
              customListItemWidgetBuilder: (_context, _index) {
                final shoe = shoes[_index];
                return showItem(x: shoe);
              }),
    ));
  }

  Future<void> getShoes(String arch_type, String toe_type) async {
    setState(() {
      isLoading = true;
    });
    if (arch_type == "Flat Arch" && toe_type == "Wide Toe Box") {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('shoes')
          .where('arch', isEqualTo: "Flat")
          .where('toe', isEqualTo: "Wide")
          .get();
      for (var doc in querySnapshot.docs) {
        shoes.add(shoe(doc.get('name'), doc.get('buy'), doc.get('arch'),
            doc.get('toe'), doc.get('image')));
      }
    } else if (arch_type == "Flat Arch") {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('shoes')
          .where('arch', isEqualTo: "Flat")
          .where('toe', isEqualTo: "Narrow")
          .get();
      for (var doc in querySnapshot.docs) {
        shoes.add(shoe(doc.get('name'), doc.get('buy'), doc.get('arch'),
            doc.get('toe'), doc.get('image')));
      }
    } else if (toe_type == "Wide Toe Box") {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('shoes')
          .where('arch', isEqualTo: "Rest")
          .where('toe', isEqualTo: "Wide")
          .get();
      for (var doc in querySnapshot.docs) {
        shoes.add(shoe(doc.get('name'), doc.get('buy'), doc.get('arch'),
            doc.get('toe'), doc.get('image')));
      }
    } else {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('shoes')
          .where('arch', isEqualTo: "Rest")
          .where('toe', isEqualTo: "Narrow")
          .get();
      for (var doc in querySnapshot.docs) {
        shoes.add(shoe(doc.get('name'), doc.get('buy'), doc.get('arch'),
            doc.get('toe'), doc.get('image')));
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}
