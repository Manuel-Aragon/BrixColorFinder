import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => HistoryState();
}

// method for creating the Scan History List Elements format
class MyHistoryBox extends StatelessWidget {
  final String blockText;
  final File? blockImage;
  final String blockColor;

  const MyHistoryBox(
      {Key? key,
      required this.blockText,
      required this.blockImage,
      required this.blockColor})
      : super(key: key);

  @override
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
            child: Column(//the values inside the list object
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
            ]),
          ),
        ));
  }
}

class HistoryState extends State<HistoryPage>
    with AutomaticKeepAliveClientMixin {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  final List<String> block = [];
  final List<String> color = [];
  final List<File?> image = [];

  @override
  bool get wantKeepAlive => true;

  updateHistory(String blockData, String colorData, File? imageFile) {
    setState(() {
      block.add(blockData);
      color.add(colorData);
      image.add(imageFile);
      _selectedImage = null;
    });
  }

  updateHistoryFromOtherScreen(
      String blockData, String colorData, File? imageFile) {
    setState(() {
      block.add(blockData);
      color.add(colorData);
      image.add(imageFile);
    });
  }

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
      body: ListView.builder(
        itemCount: block.length,
        itemBuilder: ((context, index) {
          return MyHistoryBox(
            blockText: block[index],
            blockImage: _selectedImage != null && index == block.length - 1
                ? _selectedImage
                : image[index] != null
                    ? image[index]
                    : null,
            blockColor: color[index],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: launchCamera,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
