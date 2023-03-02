import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => HistoryState();
}

// method for creating the Scan History List Elements format
class MyHistoryBox extends StatelessWidget {
  final String blockText;
  final Image blockImage;
  final String blockColor;

  const MyHistoryBox(
      {super.key,
      required this.blockText,
      required this.blockImage,
      required this.blockColor});

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
              blockImage,
              Text(blockText, style: const TextStyle(fontSize: 30.0)),
              Text(blockColor, style: const TextStyle(fontSize: 30.0)),
            ]),
          ),
        ));
  }
}

class HistoryState extends State<HistoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  //The text here is obviously hard coded in,
  //later the text will be gathered from saved
  //scan results from some array
  final List block = [
    '2x2 Brick',
    '2x4 Plate',
    '2x4 Slope',
    'Stud',
    '1x1 Brick',
    '1x2 Plate',
  ];

  //The text here is obviously hard coded in,
  //later the text will be gathered from saved
  //scan results from some array
  final List color = [
    'Red',
    'Blue',
    'Black',
    'White',
    'Yellow',
    'Green',
  ];

  //The images here are obviously hard coded in,
  //later the images will be gather from saved
  //scan results from some array
  final List image = [
    Image.asset(
      'assets/images/2x2BrickRed.PNG',
      width: 200.0,
      height: 200.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/2x4PlateBlue.PNG',
      width: 200.0,
      height: 200.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/2x4SlopeBlack.PNG',
      width: 200.0,
      height: 200.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/StudWhite.PNG',
      width: 200.0,
      height: 200.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/1x1BrickYellow.PNG',
      width: 200.0,
      height: 200.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/1x2PlateGreen.PNG',
      width: 200.0,
      height: 200.0,
      fit: BoxFit.contain,
    ),
  ];

  //this function is supposed to be called in scan page after taking a picture to save
  //the resulting data by adding the data here
  //the setState() function here causes an exception. Something to do with an initial state needing to be created...

  updateHistory(String blockData, String colorData, String imagePath) {
    setState(() {
      block.add(blockData);
      color.add(colorData);
      image.add(Image.asset(
        imagePath,
        width: 200.0,
        height: 200.0,
        fit: BoxFit.contain,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); //may need to be removed?
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("LEGO Scan History"),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: block
            .length, //the ListView builder will make a number of list items equal to the number of elements in the _text object
        itemBuilder: ((context, index) {
          return MyHistoryBox(
            blockText: block[
                index], //create a MyHistoryBox object with the text input as the _block with the current index
            blockImage: image[index],
            blockColor: color[index],
          );
        }),
      ),
    );
  }
}
