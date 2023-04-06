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

import 'package:flutter/material.dart';

const kMainFont = 'Roboto';
const kButtonFont = 'Roboto';
const kDisplayFont = 'SquadaOne';

const kColorDarkGrey = Color.fromARGB(255, 79, 76, 76);
const kColorBrickRed = Color.fromARGB(255, 206, 99, 128);
const kColorLightYellow = Color.fromARGB(255, 248, 241, 201);
const kColorPinkishRed = Color.fromARGB(255, 232, 57, 118);
const kColorOffWhite = Color.fromARGB(255, 236, 236, 236);
const kBgColor = kColorDarkGrey;

const kTitleTextStyle = TextStyle(
  fontFamily: kDisplayFont,
  fontSize: 30.0,
  color: kColorPinkishRed,
  decoration: TextDecoration.none,
);

const kAnalyzingTextStyle = TextStyle(
    fontFamily: kMainFont,
    fontSize: 40.0,
    color: kColorOffWhite,
    decoration: TextDecoration.none);

const kResultTextStyle = TextStyle(
    fontFamily: kDisplayFont,
    fontSize: 25.0,
    color: kColorLightYellow,
    decoration: TextDecoration.none);

const kResultRatingTextStyle = TextStyle(
    fontFamily: kMainFont,
    fontSize: 20.0,
    color: Colors.white,
    decoration: TextDecoration.none);
