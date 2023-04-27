import 'package:flutter/material.dart';

class BrickView extends StatefulWidget {
  const BrickView({Key? key}) : super(key: key);

  @override
  State<BrickView> createState() => _BrickViewState();
}

class MyBrickviewBox extends StatelessWidget {
  final String blockText;
  final Image blockImage;

  const MyBrickviewBox(
      {super.key, required this.blockText, required this.blockImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
        //spacing between list objects
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          //rounding edges of list object
          borderRadius: BorderRadius.circular(20),
          child: Container(
            //the list object
            height: 380,
            child: Column(//the values inside the list object
                children: [
              blockImage,
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(blockText, style: const TextStyle(fontSize: 30.0)),
              )
            ]),
          ),
        ));
  }
}

class _BrickViewState extends State<BrickView> {
  //The text here is obviously hard coded in,
  //later the text will be gathered from saved
  //scan results from some array
  final List _block = [
    '1x1 Brick',
    '1x1 Plate',
    '1x1 Plate, Round',
    '1x2 Brick',
    '1x4 Plate',
    '2x1 Slope 45 Degree',
    '2x2 Brick',
    '2x2 Plate',
    '2x2 Slope 45 Degree',
    '2x3 Plate',
    '2x4 Brick',
    '2x4 Plate',
    '1x2 Tile',
    '1x2 Jumper',
    '1x6 Plate',
    '1x4 Brick',
    '1x3 Plate',
    '1x4 Tile',
    '1x2 Grill',
    '1x1 Brick, Round',
    '2x2 Tile',
  ];

  //The imnages here are obviously hard coded in,
  //later the images will be gather from saved
  //scan results from some array
  final List _image = [
    Image.asset(
      'assets/images/1x1Brick.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/1x1Plate.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/1x1PlateRound.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/1x2Brick.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/1x4Plate.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/2x1Slope45Degree.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/2x2Brick.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/2x2Plate.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/2x2Slope45Degree.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/2x3Plate.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/2x4Brick.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/2x4Plate.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/1x2Tile.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/1x2Jumper.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/1x6Plate.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/1x4Brick.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/1x3Plate.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/1x4Tile.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/1x2Grill.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/1x1BrickRound.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
    Image.asset(
      'assets/images/2x2Tile.jpg',
      width: 300.0,
      height: 300.0,
      fit: BoxFit.contain,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("LEGO\u00AE Brick View"),
      ),
      body: ListView.builder(
        itemCount: _block
            .length, //the ListView builder will make a number of list items equal to the number of elements in the _text object
        itemBuilder: ((context, index) {
          return MyBrickviewBox(
              blockText: _block[
                  index], //create a MyHistoryBox object with the text input as the _block with the current index
              blockImage: _image[index]);
        }),
      ),
    );
  }
}
