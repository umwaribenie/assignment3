import 'package:flutter/material.dart';
import 'signin.dart';
import 'signup.dart';
import 'calculator.dart';

class Fabtabs extends StatefulWidget {
  int selectedIndex = 0;
  Fabtabs({required this.selectedIndex});

  @override
  State<Fabtabs> createState() => _FabtabsState();
}

class _FabtabsState extends State<Fabtabs> {
  int CurrentIndex = 0;

  void onItemTapped(int index){
    setState(() {
      widget.selectedIndex = index;
      CurrentIndex = widget.selectedIndex;

    });


  }


  @override
  void initState() {
    onItemTapped(widget.selectedIndex);
    // TODO: implement initState
    super.initState();
  }
  final List<Widget> pages = [
    Signin(),
    Signup(),
    Calculator(),



  ];
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    Widget currentScreen = CurrentIndex == 0 ? Signin() : CurrentIndex == 1 ? Signup():Calculator();
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 120,
                    onPressed: (){
                      setState(() {
                        currentScreen = Signin();
                        CurrentIndex = 0;
                      });
                    },
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.login,
                          color: CurrentIndex == 0 ? Colors.blueAccent : Colors.grey,

                        ),
                        Text(
                          "Sign in",
                          style: TextStyle(color: CurrentIndex == 0 ? Colors.blueAccent : Colors.grey),
                        ),
                      ],
                    ),
                  ),


                  MaterialButton(
                    minWidth: 130,
                    onPressed: (){
                      setState(() {
                        currentScreen = Signup();
                        CurrentIndex = 1;
                      });
                    },
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: CurrentIndex == 1 ? Colors.blueAccent : Colors.grey,

                        ),
                        Text(
                          "Sign up",
                          style: TextStyle(color: CurrentIndex == 1 ? Colors.blueAccent : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 100,
                    onPressed: (){
                      setState(() {
                        currentScreen = Calculator();
                        CurrentIndex = 2;
                      });
                    },
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calculate,
                          color: CurrentIndex == 2 ? Colors.blueAccent : Colors.grey,

                        ),
                        Text(
                          "Calculator",
                          style: TextStyle(color: CurrentIndex == 2 ? Colors.blueAccent : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],


              ),



            ],
          ),
        ),

      ),

    );


  }
}