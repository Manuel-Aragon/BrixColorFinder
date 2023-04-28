import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'package:provider/provider.dart'; // used to work with ChangeNotifiers, Consumers, and Producers to manage State

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => HistoryState();
}

// This class creates the UI for the Scan History results
class MyHistoryBox extends StatelessWidget {
  final String blockText;
  final File? blockImage;
  final String blockColor;

  // a history result MUST have a brick name, the image taken, and the brick's color
  const MyHistoryBox(
      {Key? key,
      required this.blockText,
      required this.blockImage,
      required this.blockColor})
      : super(key: key);

  @override
  //create the dynamic widget for the Scan History results
  Widget build(BuildContext context) {
    return Padding(
      //spacing between list objects
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        //rounding edges of list object
        borderRadius: BorderRadius.circular(20),
        child: Container(
          //the list object
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(223, 212, 89, 100),
              width: 6.0,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            //the values inside the list object
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                    //rounding edges of list object
                    borderRadius: BorderRadius.circular(10),
                    child: blockImage != null
                        ? Image.file(blockImage!,
                            width: 270.0, height: 270.0, fit: BoxFit.contain)
                        : const SizedBox(
                            width: 270.0,
                            height: 270.0,
                            child: Icon(Icons.image_outlined))),
              ),
              Text(blockText, style: const TextStyle(fontSize: 30.0)),
              Text(blockColor, style: const TextStyle(fontSize: 30.0)),
            ],
          ),
        ),
      ),
    );
  }
}

// Class for modifying the State of the Scan History dynamic list using the Provider package
class HistoryModel extends ChangeNotifier {
  // The private field backing [History]
  //late HistoryState _history;

  // internal private version of the History. Stores each list data for each item.
  final List<String> _brick = [];
  final List<String> _color = [];
  final List<File?> _image = [];

  // the unmodifiable view of the items in the Scan History Lists
  // UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // Used to round the accuracy
  double roundDouble(double val, int places) {
    double mod = pow(10.0, places).toDouble();
    return ((val * mod).round().toDouble() / mod);
  }

  // this function will tell the lists to update, then, when the History
  void addNewScan(String brick, String color, File? image) {
    // round the accuracy value, then turn in back into a string
    /*double d_Accuracy = double.parse(accuracy);
    d_Accuracy = roundDouble(d_Accuracy, 2);
    // check if the LEGO was not confidently found
    if (d_Accuracy < 0.8) {
      brick = "LEGO not Confident";
    }
    // make accuracy out of 100
    d_Accuracy *= 100;
    String acc = d_Accuracy.toString();*/

    // add the items to the Lists
    _brick.add(brick);
    _color.add(color);
    _image.add(image);
    debugPrint('brick: $_brick\naccuracy: $_color\nimage: $_image\n');
    notifyListeners(); // Tells the listeners that there has been a change to the history list
  }

  // clear all the items from the Lists
  void clearScans() {
    _brick.clear();
    _color.clear();
    _image.clear();
    debugPrint('brick: $_brick\naccuracy: $_color\nimage: $_image\n');
    notifyListeners(); // Tells the listeners that there has been a change to the history list
  }
}

// Class for tracking the STATE of the Scan History dynamic list
class HistoryState extends State<HistoryPage>
    with AutomaticKeepAliveClientMixin {
  File? _selectedImage;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<HistoryModel>(
      builder: (context, historyModel, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("LEGO\u00AE Scan History"),
        ),
        body: ListView.builder(
          itemCount: historyModel._brick.length,
          itemBuilder: ((context, index) {
            return MyHistoryBox(
              blockText: historyModel._brick[index],
              blockImage: _selectedImage != null &&
                      index == historyModel._brick.length - 1
                  ? _selectedImage
                  : historyModel._image[index],
              blockColor: historyModel._color[index],
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var historyModel = context.read<HistoryModel>();
            historyModel.clearScans();
          },
          child: const Icon(Icons.delete_forever_sharp),
        ),
      ),
    );
  }
}
