import 'package:eduvault/Components/Images(StartingPages).dart';
import 'package:eduvault/Components/Routes.dart';
import 'package:eduvault/Login/Login.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Startpage extends StatefulWidget {
  const Startpage({super.key});

  @override
  State<Startpage> createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {

  final List<Map<String,dynamic>> data = [
    {'photo' : 'Slide1','heading':'10+ Board Exam Question Papers & Solution','text':'Explore previous 10+ Board exam Question Papers with Solutions PDF, Paper patterns, etc','height':200.00,'width':200.00},
    {'photo' : 'Slide3','heading':'Chapter-wise Board exam solution & Paper pattern','text':'Check the board exam questions from each chapter with solution ans study as per paper pattern & question bank'},
    {'photo' : 'Slide2','heading':'1000+ tests, Smart notes & Formula ','text':'Test your learnings by taking test for every chapters \n Quickly revice concepts using smart notes','height':230.00,'width':230.00},
  ];

  PageController _controller = PageController();
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(toolbarHeight: 10),
        backgroundColor: Color(0xFFF7FAFF),
        body: Stack(
          children: [
            PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                children: data.map((item){
                  return Pages(photo: item['photo']!, heading: item['heading']!, text: item['text']!,height: item['height'],width: item['width']);
                }).toList()
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      // _controller.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isFirstTime', false);
                      Navigator.pushAndRemoveUntil(
                          context,
                          myRoute(Login()),(Route)=>false
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        'Skip',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ),
                  SmoothPageIndicator(controller: _controller, count: data.length,effect:WormEffect(dotWidth: 7,dotHeight: 7,dotColor: Colors.blue.shade200,activeDotColor: Colors.blue))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40,left: 20,right: 20),
              child: Container(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          minimumSize: Size(double.infinity, 50),
                        elevation: 5,
                      ),
                      onPressed: () async {
                          if (currentIndex < data.length - 1) {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                            );
                          } else {
                            // LAST PAGE → START
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('isFirstTime', false);
                            Navigator.pushAndRemoveUntil(
                              context,
                              myRoute(Login()),(Route)=>false
                            );
                          }
                        },
                      child: Text(
                        currentIndex == data.length - 1 ? 'Start' : 'Next',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
            )
              ),
            )
          ]
        )
    );
  }
}
