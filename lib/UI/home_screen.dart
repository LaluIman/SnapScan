import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("assets/images/pp.png"))),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hallo, Alamak 👋",
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Software Engineer/Funny guy",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("assets/images/home_banner.png"),
                          fit: BoxFit.cover)),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text("Features", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                    SizedBox(width: 30,),
                    SizedBox(
                      width: 250,
                      child: Divider()
                    )
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/scan');
                      },
                      child: Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/scan_button.png"),
                                  fit: BoxFit.cover)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/qrscanner_icon.png',
                                  width: 55,
                                  height: 55,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Scan QR Code",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/create');
                            },
                            child: Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade200),
                                child: Center(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/qrcreate.png',
                                      width: 35,
                                      height: 35,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Create QR Code",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ))),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade200),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/sendqr.png',
                                    width: 35,
                                    height: 35,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Send QR Code",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ))),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade200),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/print.png',
                                  width: 50,
                                  height: 50,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "Print QR Code",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      ),
                                )
                              ],
                            ),
                          )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
