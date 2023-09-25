import 'package:flutter/material.dart';
import 'package:image_slider/image_slider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Image Slider Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({ Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  /// This pub allows you to make image_slider widget and also multiple other useful widgets like walkthrough etc.

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  late TabController tabController;

  static List<String> links = [
    "https://i.pinimg.com/originals/cc/18/8c/cc188c604e58cffd36e1d183c7198d21.jpg",
    "https://www.kyoceradocumentsolutions.be/blog/wp-content/uploads/2019/03/iStock-881331810.jpg",
    "https://resources.matcha-jp.com/resize/720x2000/2020/04/23-101958.jpeg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2)),
              child: ImageSlider(
                /// Shows the tab indicating circles at the bottom
                showTabIndicator: false,

                /// Cutomize tab's colors
                tabIndicatorColor: Colors.lightBlue,

                /// Customize selected tab's colors
                tabIndicatorSelectedColor: Color.fromARGB(255, 0, 0, 255),

                /// Height of the indicators from the bottom
                tabIndicatorHeight: 16,

                /// Size of the tab indicator circles
                tabIndicatorSize: 16,

                /// tabController for walkthrough or other implementations
                tabController: tabController,

                /// Animation curves of sliding
                curve: Curves.fastOutSlowIn,

                /// Width of the slider
                width: MediaQuery.of(context).size.width,

                /// Height of the slider
                height: 220,

                /// If automatic sliding is required
                autoSlide: false,

                /// Time for automatic sliding
                duration: new Duration(seconds: 6),

                /// If manual sliding is required
                allowManualSlide: true,

                /// Children in slideView to slide
                children: links.map((String link) {
                  return new ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        link,
                        width: MediaQuery.of(context).size.width,
                        height: 220,
                        fit: BoxFit.fill,
                      ));
                }).toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                tabController.index == 0
                    ? Container(
                        width: 0,
                        height: 0,
                      )
                    : RaisedButton(
                        onPressed: () {
                          tabController.animateTo(tabController.index - 1);
                          setState(() {});
                        },
                        child: Text("Previous"),
                      ),
                tabController.index == 2
                    ? Container(
                        width: 0,
                        height: 0,
                      )
                    : RaisedButton(
                        onPressed: () {
                          tabController.animateTo(2);
                          setState(() {});
                        },
                        child: Text("Skip"),
                      ),
                tabController.index == 2
                    ? Container(
                        width: 0,
                        height: 0,
                      )
                    : RaisedButton(
                        onPressed: () {
                          tabController.animateTo(tabController.index + 1);
                          setState(() {});
                        },
                        child: Text("Next"),
                      ),
              ],
            )
          ],
        ));
  }
}
