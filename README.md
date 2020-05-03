# stepo
A highly customisable Flutter package for animated unit stepper

## Supported Dart Versions
**Dart SDK version >= 2.1.0**

## Demo Gif
<img src="https://raw.githubusercontent.com/hd-motion/flutter_stepo/master/example/demo/stepo.gif" height="35%" width="35%"  alt="Stepo Demo"/>

## Installation
[![Pub](https://img.shields.io/badge/pub-1.0.0-blue)](https://pub.dev/packages/stepo)

Add the Package
```yaml
dependencies:
  stepo: ^1.0.0
```
## How to use

Import the package in your dart file

```dart
import 'package:stepo/stepo.dart';
```

##### Basic usage :

```dart
Stepo(
  key: UniqueKey(),
),
```

Note: For stepo to show instant changes on hot reload, you need to provide `UniqueKey()` so that the widget rebuilds every time.

##### Customisable usage :
```dart
Stepo(
  key: UniqueKey(),
  width: 200,                                         //Optional
  backgroundColor: Colors.deepPurple,                 //Optional
  style: Style.vertical,                              //Optional
  textColor: Colors.white,                            //Optional
  animationDuration: Duration(milliseconds: 500),     //Optional
  iconColor: Colors.white,                            //Optional
  fontSize: 20,                                       //Optional
  iconSize: 30,                                       //Optional 
  initialCounter: 25,                                 //Optional
  lowerBound: 10,                                     //Optional
  upperBound: 50,                                     //Optional
  onIncrementClicked: (counter) {                     //Optional
    print("Increment clicked");
  },
  onDecrementClicked: (counter) {                     //Optional
    print("Decrement clicked");
  },
),
```

### Customisable fields

| Attribute           | Type                | Default Value                 |
| -------------       | ------------------- | --------------                |
| width               | int                 | 160                           |
| backgroundColor     | color               | Colors.white                  |
| style               | vertical/horizontal | Style.horizontal              |
| textColor           | color               | Color(0xffEC645B)             |
| animationDuration   | int                 | Duration(milliseconds: 200)   |
| iconColor           | color               | Color(0xffEC645B)             |
| fontSize            | int                 | 32                            |
| iconSize            | int                 | 40                            |
| initialCounter      | int                 | 0                             |
| lowerBound          | int                 | 0                             |
| upperBound          | int                 | 100                           |
| onIncrementClicked  | function            | (counter) {}                  |
| onDecrementClicked  | function            | (counter) {}                  |

### Inspired by

[Oleg Frolov's Design](https://dribbble.com/shots/5687260-Stepper-XXII)

### Created & Maintained By

[Harpreet Singh](https://github.com/harpreetseera) 

[Damanpreet Singh](https://github.com/damanpreetsb) 

# License
```
Copyright 2020 Harpreet Singh & Damanpreet Singh

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

