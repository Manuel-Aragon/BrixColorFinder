// Copyright (c) 2022 Kodeco LLC

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended, or marketed for pedagogical
// or instructional purposes related to programming, coding,
// application development, or information technology.  Permission for such use,
// copying, modification, merger, publication, distribution, sublicensing,
// creation of derivative works, or sale is expressly withheld.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../classifier/classifier.dart';
import '../styles.dart';
import 'lego_photo_view.dart';
import '../history_page.dart';

const _labelsFileName = 'assets/labels.txt';
const _modelFileName = 'model_unquant.tflite';

class LegoBrickRecogniser extends StatefulWidget {
  //const LegoBrickRecogniser({super.key});
  const LegoBrickRecogniser({Key? key}) : super(key: key);

  @override
  State<LegoBrickRecogniser> createState() => _LegoBrickRecogniserState();
}

//enumerator function for setting the status of a scan result
//this is used when the result is or is not found, changing the print output
enum _ResultStatus {
  notStarted,
  notFound,
  found,
}

//This entire class is what is used to set up the LEGO scanning feature
//it contains the UI for the page, how the user selects the scan method,
//how the user's LEGO image is displayed and processed with the model.
class _LegoBrickRecogniserState extends State<LegoBrickRecogniser> {
  bool _isAnalyzing =
      false; //used to check if the image is in the process of being analyized by the model
  final picker =
      ImagePicker(); //initialize picker to use the image picker package for selecting images from the user's camera roll
  File?
      _selectedImageFile; //used for accessing the selected image from the image gallery

  // Result
  _ResultStatus _resultStatus =
      _ResultStatus.notStarted; //initialize result status to notStarted yet
  String _legoLabel =
      ''; //the string for printing the Model Label (the name of the LEGO brick)
  double _accuracy = 0.0; //initialize the accuracy variable to zero

  //initialize a classifier type, using the class from the classifier.dart file.
  //this is used
  late Classifier _classifier;

  //this initializes the 'state' of the application and calls the _loadClassifier funciton below
  @override
  void initState() {
    super.initState();
    _loadClassifier();
  }

  //
  Future<void> _loadClassifier() async {
    //print to the debug console the model being used and its labels
    debugPrint(
      'Start loading of Classifier with '
      'labels at $_labelsFileName, '
      'model at $_modelFileName',
    );

    //initialize classifier, by waiting for the Classifier class's loadWith() function
    //loads the classifier using the input model and labels and assigns them to mutable
    //variables.
    final classifier = await Classifier.loadWith(
      labelsFileName: _labelsFileName,
      modelFileName: _modelFileName,
    );

    //this generated classifier is then assigned to the earlier initialized classifier
    //the ! means that the 'classifier' is checked to not be null first.
    _classifier = classifier!;
  }

  //This is a build widget, which dynamically builds the structure of the UI of this page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("BrixColor Finder"),
        backgroundColor: kColorBrickRed,
      ),
      body: Container(
        color: kBgColor,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Spacer(),
            /*Padding(
              padding: const EdgeInsets.only(top: 20),
              child: _buildTitle(),
            ),*/
            const SizedBox(height: 0),
            _buildPhotolView(),
            const SizedBox(height: 10),
            _buildResultView(),
            const Spacer(flex: 5),
            _buildPickPhotoButton(
              title: 'Take a picture of a LEGO',
              source: ImageSource.camera,
            ),
            _buildPickPhotoButton(
              title: 'Pick a LEGO from gallery',
              source: ImageSource.gallery,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  // widget that creates the view of the taken image on the page
  Widget _buildPhotolView() {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        LegoPhotoView(file: _selectedImageFile),
        _buildAnalyzingText(),
      ],
    );
  }

  Widget _buildAnalyzingText() {
    if (!_isAnalyzing) {
      return const SizedBox.shrink();
    }
    return const Text('Scanning for LEGOs...', style: kAnalyzingTextStyle);
  }

  // Builds the title for the page (probably will get rid of this)
  /*Widget _buildTitle() {
    return const Text(
      'BrixColor Finder',
      style: kTitleTextStyle,
      textAlign: TextAlign.center,
    );
  }*/

  Widget _buildPickPhotoButton({
    required ImageSource source,
    required String title,
  }) {
    return TextButton(
      onPressed: () => _onPickPhoto(source),
      child: Container(
        width: 300,
        height: 50,
        color: kColorBrickRed,
        child: Center(
            child: Text(title,
                style: const TextStyle(
                  fontFamily: kButtonFont,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: kColorLightYellow,
                ))),
      ),
    );
  }

  void _setAnalyzing(bool flag) {
    setState(() {
      _isAnalyzing = flag;
    });
  }

  void _onPickPhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);
    setState(() {
      _selectedImageFile = imageFile;
    });

    _analyzeImage(imageFile);
  }

  void _analyzeImage(File image) {
    _setAnalyzing(true);

    final imageInput = img.decodeImage(image.readAsBytesSync())!;

    final resultCategory = _classifier.predict(imageInput);

    final result = resultCategory.score >= 0.8
        ? _ResultStatus.found
        : _ResultStatus.notFound;
    final legoLabel = resultCategory.label;
    final accuracy = resultCategory.score;

    _setAnalyzing(false);

    setState(() {
      _resultStatus = result;
      _legoLabel = legoLabel;
      _accuracy = accuracy;
      //HistoryState().updateHistoryFromOtherScreen(legoLabel, accuracy.toString(), image);
      var historyModel = context.read<HistoryModel>();
      historyModel.addNewScan(legoLabel, accuracy.toString(), image);
    });
  }

  Widget _buildResultView() {
    var title = ''; //initialize title to be blanck

    //This ifelse block is used for displaying the result text
    if (_resultStatus == _ResultStatus.notFound) {
      title = 'LEGO not detected';
    } else if (_resultStatus == _ResultStatus.found) {
      title = _legoLabel; //this prints the resulting label
    } else {
      title = '';
    }

    //This is were the accuracy result text is created
    var accuracyLabel = '';
    if (_resultStatus == _ResultStatus.found) {
      accuracyLabel =
          'LEGO brick confidence: ${(_accuracy * 100).toStringAsFixed(2)}%';
    }

    //This is the widget were the LEGO label and accuracy result is located
    return Column(
      children: [
        Text(title, style: kResultTextStyle),
        const SizedBox(height: 10),
        Text(accuracyLabel, style: kResultRatingTextStyle)
      ],
    );
  }
}
