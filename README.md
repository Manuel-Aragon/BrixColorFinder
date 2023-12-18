# SeniorCapstoneLucky13

Created by: Garrett Prestidge, Manuel Aragon, Shellie Pham, Shyam Nath, Katherine Aquilone, Miguel Hernandez, Muzhda Wahedi

BrixColor Finder is an innovative app that uses machine learning models to empower visually impaired individuals by accurately identifying the color and type of individual LEGO bricks. Developed for both iOS and Android devices, the app enhances the LEGO building experience for users with various visual impairments, promoting inclusivity and fostering social interactions.
While people with visual impairments can enjoy building with LEGOs, challenges in determining brick shape and color may arise due to their impairments. BrixColor Finder addresses these challenges with its unique focus on LEGO brick identification, combined with its use of image recognition technology and LEGO-specific databases. The app is also compatible with phone screen readers, providing a more comprehensive tool for users.
By bridging the accessibility gap in the world of LEGO, BrixColor Finder has the potential to benefit not only visually impaired individuals, but also educators, therapists, and parents working with them.

                      4902 Deployment Artifacts
Project: BrixColor Finder
Team: Lucky 13
Sponsor: Dr. Ludi
Members: Garrett Prestidge, Manuel Aragon, Miguel Hernandez, 
Shellie Pham, Katherine Aquilone, Muzhda Wahedi

Overview:

	This document contains important information on the data created in this project, as well as installation instructions for being able to run our application on an iOS or Android phone. The application is intended to be used with the built-in Text-to-Speech software of iOS and Android phones, assuming the user has significant visual impairment that would prevent them from otherwise using the app effectively.

	Our project is a LEGO brick identifier mobile application that is used by those with visual impairments. The user can take a picture with their phone’s camera, or select an image file from their phone’s gallery, and a TensorFlow Lite model is run in order to identify the name (brick shape) and the color of that LEGO brick. The device will print the results on the screen along with the image taken and read them out with its built in TTS. The device will save the results to a history page, so the user need not rescan the same brick several times.


Assumptions:
This application is designed to cater to users with visual impairments, and it requires an Android or iOS device with a minimum operating system of Android 12 or iOS 16. The user should be somewhat familiar with the device’s built-in Text-to-Speech feature, which they will be using in conjunction with the app. Additionally, the device must have at least one camera that can be accessed by the application.
For the quickest and most straightforward installation experience, we recommend installing our complete GitHub repository. We assume that you will follow this approach when installing the application.





Dependencies:

	After downloading our GitHub repository, and completing the installation of VSCode, Flutter, and the iOS/Android device setup, running the application should automatically initiate a Flutter pub get and verify our pubspec.yaml file. 

Our pubspec.yaml file includes all the package dependencies and external APIs (TFLite, Firebase, Image_picker, etc.) required for our application. Upon running Flutter pub get, all necessary versions will be fetched automatically. The app should also access data directly from our Firebase database, so there is no need to log in to our Firebase account. However, if you want to test this feature, you can register and login to do so, although it is not necessary.

Constraints:

	The production environment offers a great deal of flexibility, as VSCode and Flutter are powerful development environments that enable the creation of feature-rich applications with relatively little code. The application offers stable performance across multiple platforms, although we have not tested it on iOS or Android tablet devices as we have only tested it with phones and emulator devices. Other than that, we do not know of any specific constraints in the production environment.


Description of DAs:

	Our deployment artifacts are:
The raw image data (not contained in the project)
Saba has been sent this data, as it would be far too large to upload
The generated model files and their label files (.tflite and .txt files)
Images used for the Brick View page

	All the necessary components, including the model, label, and images used for the Brick View page, are located in the assets folder of the GitHub project. Additionally, the raw image data archives were uploaded to a Google Drive and downloaded by Saba, who should have all the required raw model data.

The Deployment Artifacts for Android are included in a .zip file, which we have submitted along with this document. However, we were unable to create the deployment artifact for iOS as it requires an Apple development account.


Data Creation:

	As the model is located locally in the assets of the GitHub project, none of the data should need initialization. Upon running the application, a Flutter pub get command will execute automatically, fetching all the necessary dependencies to run the project. However, it is important to note that all the data required to run the application is already contained within the project's assets folder.


Admin Credentials:

	The application should interact directly with our Firebase database, but you will not require any administrative privileges to use any of the app's features.


Deployment Process:

You will need to download the project files to be able to run it. You can see it here https://github.com/Manuel-Aragon/lucky13capstone on GitHub.
iOS: 

Downloading Flutter on a Mac:
https://docs.flutter.dev/get-started/install/macos

This document will guide you through the entire process of installing Flutter onto your Mac and getting your environment set up to run build the app using Xcode, as well as how to enable development mode on your iOS device. However, we personally used VSCode as our work environment which Xcode will run through. You can find a link to install VSCode in the Android install section below.

Once your environment is set up, and your iOS device is connected to your Mac device, run a Flutter pub get command to gather all the necessary packages and install them automatically. Then simply run without debugging in your chosen IDE, or run a Flutter run command to begin building the project on your iOS device!

Android:

Full Flutter Install Guide on a Windows PC: Windows install | Flutter
This document will guide you through the entire process of installing Flutter onto your PC and getting your environment set up to run build the app.

To run the project, you will need an integrated development environment (IDE) such as VSCode. Here are the steps to download and install it:
Visit https://code.visualstudio.com/docs/?dv=win to download VSCode for Windows.
Follow the setup wizard instructions to complete the installation process.

Next, you will need to install Flutter by following these steps:
Refer to https://docs.flutter.dev/get-started/install/windows for detailed instructions on downloading Flutter for Windows.
Follow the steps provided in the link to complete the installation process.

These steps should get you up and running with the necessary tools to run the project.


On the Android device:
Open ‘Settings’
Locate your build number: 
![unnamed](https://github.com/Manuel-Aragon/BrixColorFinder/assets/73243037/1dbd4be0-54ac-41a9-be3f-8f77c457f490)

Tap the build number seven times. Once done, you should see a message indicating that "Developer mode has been turned on."
Back out to the main settings page again.
Tap the search icon at the top of the screen
Search ‘Developer options’
Scroll down to the ‘Debugging’ section
Toggle the ‘USB debugging’ button
Press ‘OK’ when the prompt appears
Plug in the Android device to your PC with a USB.
If the device asks to trust the device, select ‘Yes’ or ‘Allow’
In VSCode, there should be a box at the bottom left of the editor that allows you to select your device to build the program on. Open the drop down list and select your device.
Run the program without debugging and VSCode should automatically run a Flutter pub get command to grab all dependencies of the project and install them.
If not, go to your terminal and run that command yourself.
Upon successful completion of the previous steps, the project should commence building the app. If everything has been done correctly, the app should install on your device and launch automatically.
If the project fails to build, then it is likely that a step was missed. Check the output errors to determine what you may have missed during the installation process.
In addition, you can run "Flutter doctor" in the terminal to ensure that your Flutter environment is fully set up, and all the necessary components are installed. If any of the required components are missing, follow the instructions provided to ensure that your Flutter environment is fully configured.









Citations:

In order to operate on our machine learning model that we generated using Teachable Machine, we used an open source Flutter tutorial project created by Kodeco LLC and integrated it into our project in order to run and print the results of the model with permission from Dr. Ludi. Here is the URL of the tutorial (source code requires a login to access): https://www.kodeco.com/37077010-tensorflow-lite-tutorial-for-flutter-image-classification
