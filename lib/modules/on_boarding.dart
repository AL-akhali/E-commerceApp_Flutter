import 'package:ecommerce/modules/auth_screens/login.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:ecommerce/shared/network/local/cache_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body
});
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'عروض خياليه',
        image: 'assets/images/Shop 1.png',
        body: 'احصل على افضل تخفيض'
    ),
    BoardingModel(
        title: 'تسوق معانا',
        image: 'assets/images/Shop 2.jfif',
        body: ' ابحث عن افضل المنتجات'
    ),
    BoardingModel(
        title: 'data 3',
        image: 'assets/images/Shop 3.png',
        body: 'data 3'
    ),
  ];

  bool isLast = false;

  void submit()
  {
    CacheHelper.saveDate(key: 'onBoarding', value: true).then((value){
      if(value)
        {
          NavigateAndFinish(context,LoginScreen());
        }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: ()
          {
            submit();
          },
            child: Text('تجاوز',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.deepOrange,
            ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column (
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardController,
                onPageChanged: (int index){
                  if(index == boarding.length -1)
                    {
                      setState(() {
                        isLast = true;
                      });
                    }else
                      {
                        setState(() {
                          isLast = false;
                        });
                      }
                },
                physics: BouncingScrollPhysics(),
                itemBuilder: (context , index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                      activeDotColor: Colors.deepOrange,
                    ),
                    count: boarding.length
                ),
                Spacer(), // ياخذ المساحه الفاضيه
                FloatingActionButton(
                  backgroundColor: Colors.deepOrange,
                    onPressed: (){
                    if(isLast)
                      {
                        submit();
                      }
                    else
                      {
                        boardController.nextPage(duration: Duration(
                          microseconds: 750,
                        ),
                            curve: Curves.fastLinearToSlowEaseIn
                        );
                      }

                    },
                  child: Icon(Icons.arrow_forward_ios,),
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image: AssetImage('${model.image}'),
        ),
      ),
      Text('${model.title}',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30.0
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Text('${model.body}',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),
      ),
    ],
  );
}
