// import 'dart:ui';
// import 'package:flutter/material.dart';

// class SampleAnimation extends StatefulWidget {
//   SampleAnimation();

//   @override
//   State<StatefulWidget> createState() {
//     return SampleAnimationState();
//   }
// }

// class SampleAnimationState extends State<SampleAnimation>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation _animation;
//   late Path _path;

//   @override
//   void initState() {
//     _controller = AnimationController(
//         vsync: this, duration: Duration(milliseconds: 5000));
//     super.initState();
//     _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
//       ..addListener(() {
//         setState(() {});
//       });
//     _controller.forward();
//     _path = drawPath();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Positioned(
//             top: 0,
//             child: CustomPaint(
//               painter: PathPainter(_path),
//             ),
//           ),
//           Positioned(
//             top: calculate(_animation.value).dy,
//             left: calculate(_animation.value).dx,
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.blueAccent,
//                   borderRadius: BorderRadius.circular(10)),
//               width: 10,
//               height: 10,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   Path drawPath() {
//     Size size = Size(300, 300);
//     Path path = Path();
//     path.moveTo(0, size.height / 2);
//     path.quadraticBezierTo(
//         size.width / 2, size.height, size.width, size.height / 2);
//     return path;
//   }

//   Offset calculate(value) {
//     PathMetrics pathMetrics = _path.computeMetrics();
//     PathMetric pathMetric = pathMetrics.elementAt(0);
//     value = pathMetric.length * value;
//     Tangent? pos = pathMetric.getTangentForOffset(value);
//     return pos!.position;
//   }
// }

// class PathPainter extends CustomPainter {
//   Path path;

//   PathPainter(this.path);

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.redAccent.withOpacity(0.3)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3.0;

//     canvas.drawPath(this.path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }

///////////
//////
///
// import 'package:flutter/material.dart';

// //void main() => runApp(MyApp());

// class SampleAnimation extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage>
//     with SingleTickerProviderStateMixin {
//   AnimationController? controller;
//   Animation? colorAnimation;
//   Animation? sizeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Defining controller with animation duration of two seconds
//     controller =
//         AnimationController(vsync: this, duration: Duration(seconds: 2));

//     // Defining both color and size animations
//     colorAnimation =
//         ColorTween(begin: Colors.blue, end: Colors.yellow).animate(controller!);
//     sizeAnimation =
//         Tween<double>(begin: 100.0, end: 200.0).animate(controller!);

//     // Rebuilding the screen when animation goes ahead
//     controller!.addListener(() {
//       setState(() {});
//     });

//     // Repeat the animation after finish
//     //controller!.repeat();

//     //For single time
//     //controller.forward()

//     //Reverses the animation instead of starting it again and repeats
//     controller!.repeat(reverse: true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Animation Demo"),
//       ),
//       body: Center(
//         child: Container(
//           height: sizeAnimation!.value,
//           width: sizeAnimation!.value,
//           color: colorAnimation!.value,
//         ),
//       ),
//     );
//   }
// }

//////
///
///
import 'dart:ui';
import 'package:flutter/material.dart';

class SampleAnimation extends StatefulWidget {
  SampleAnimation();

  @override
  State<StatefulWidget> createState() {
    return SampleAnimationState();
  }
}

class SampleAnimationState extends State<SampleAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;
  Path? _path;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));
    super.initState();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
    _controller!.forward();
    _path = drawPath();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            child: CustomPaint(
              painter: PathPainter(_path!),
            ),
          ),
          Positioned(
            top: calculate(_animation!.value).dy,
            left: calculate(_animation!.value).dx,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)),
              width: 10,
              height: 10,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Path drawPath() {
    Size size = Size(300, 300);
    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height / 2);
    return path;
  }

  Offset calculate(value) {
    PathMetrics pathMetrics = _path!.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent? pos = pathMetric.getTangentForOffset(value);
    return pos!.position;
  }
}

class PathPainter extends CustomPainter {
  Path path;

  PathPainter(this.path);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    canvas.drawPath(this.path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
