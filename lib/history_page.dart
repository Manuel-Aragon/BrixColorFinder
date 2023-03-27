import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
          //onPressed:
          height: 300,
          color: Colors.grey,
          child: Column(
            //the values inside the list object
            children: [
              blockImage != null
                  ? Image.file(blockImage!,
                      width: 200.0, height: 200.0, fit: BoxFit.contain)
                  : SizedBox(
                      width: 200.0,
                      height: 200.0,
                      child: Icon(Icons.image_outlined)),
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
  final List<String> _accuracy = [];
  final List<File?> _image = [];

  // the unmodifiable view of the items in the Scan History Lists
  //UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  // this function will tell the lists to update, then, when the History
  void addNewScan(String brick, String accuracy, File? image) {
    _brick.add(brick);
    _accuracy.add(accuracy);
    _image.add(image);
    notifyListeners();
  }
}

// Class for tracking the STATE of the Scan History dynamic list
class HistoryState extends State<HistoryPage>
    with AutomaticKeepAliveClientMixin {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  final List<String> block = [];
  final List<String> color = [];
  final List<File?> image = [];

  @override
  bool get wantKeepAlive => true;

  // Call this function to add a result to the history list
  updateHistory(String blockData, String colorData, File? imageFile) {
    setState(() {
      block.add(blockData);
      color.add(colorData);
      image.add(imageFile);
      _selectedImage = null;
    });
  }

  // Call this function to add a result to the history list from another page
  updateHistoryFromOtherScreen(
      String blockData, String colorData, File? imageFile) {
    setState(() {
      block.add(blockData);
      color.add(colorData);
      image.add(imageFile);
    });
  }

  // This function is called by pressing the button on the scan history page, for testing
  Future<void> launchCamera() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      updateHistory('New Block', 'New Color', _selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("LEGO Scan History"),
        backgroundColor: Colors.black,
      ),
      body: Consumer<HistoryModel>(
          builder: (context, historyModel, child) => ListView.builder(
                itemCount: historyModel._brick.length,
                itemBuilder: ((context, index) {
                  return MyHistoryBox(
                    blockText: historyModel._brick[index],
                    blockImage: _selectedImage != null &&
                            index == historyModel._brick.length - 1
                        ? _selectedImage
                        : historyModel._image[index] != null
                            ? historyModel._image[index]
                            : null,
                    blockColor: historyModel._accuracy[index],
                  );
                }),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: launchCamera,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
