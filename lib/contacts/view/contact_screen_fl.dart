import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactScreenFL extends StatelessWidget {
  static const String routeName = '/contact';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Stack(
          children:[
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150,
                  color: Color(0xff00966b),
                  child: Stack(
                    children:[
                      Positioned(
                        left: 35,
                        top: 104,
                        child: Container(
                          width: 312,
                          height: 36,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              Container(
                                width: 312,
                                height: 36,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.green,
                                ),
                                padding: const EdgeInsets.only(left: 6, right: 7, ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: FlutterLogo(size: 20),
                                    ),
                                    SizedBox(width: 9),
                                   /*
                                    Opacity(
                                      opacity: 0.50,
                                      child: Text(
                                        "Search by name...",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  */Container(
                                        color: Colors.green,
                                        child: SizedBox(
                                          width: 239,
                                          child: TextField(),
                                        ),
                                      ),

                                    SizedBox(width: 9),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5, ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children:[
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Color(0x7f7f3a44),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children:[
                                                Container(
                                                  width: 7.50,
                                                  height: 1.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 2.72),
                                                Container(
                                                  width: 15,
                                                  height: 1.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(90),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(height: 2.72),
                                                Container(
                                                  width: 7.50,
                                                  height: 1.45,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Contacts",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 41,
                        top: 69,
                        child: Container(
                          width: 20,
                          height: 20,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              Container(
                                width: 20,
                                height: 20,
                                child: Stack(
                                  children:[

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children:[
                  Positioned(
                    left: 35,
                    top: 255,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff1f2430), width: 0.75, ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 213,
                    child: Text(
                      "vuyanziglorious@gmail.com",
                      style: TextStyle(
                        color: Color(0xff4e4e4e),
                        fontSize: 12,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 194,
                    child: Text(
                      "Bill Gates",
                      style: TextStyle(
                        color: Color(0xff1f2430),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 181,
                    child: Text(
                      "bill.google",
                      style: TextStyle(
                        color: Color(0xff00966b),
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 229,
                    child: Text(
                      "18100 - 20100, Nakuru",
                      style: TextStyle(
                        color: Color(0xffafafaf),
                        fontSize: 10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.7,
                    top: 229,
                    child: Text(
                      "+254 713654608",
                      style: TextStyle(
                        color: Color(0xff4e4e4e),
                        fontSize: 10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.8,
                    top: 181,
                    child: Container(
                      width: 36,
                      height: 36,
                      child: Stack(
                        children:[Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0x3337c978),
                          ),
                        ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 16,
                                height: 16,
                                padding: const EdgeInsets.all(1),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Container(
                                      width: 13.33,
                                      height: 13.33,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xff14ab57),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 342,
                    child: Container(
                      width: 310.25,
                      height: 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff1f2430), width: 0.75, ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 300,
                    child: Text(
                      "vuyanziglorious@gmail.com",
                      style: TextStyle(
                        color: Color(0xff4e4e4e),
                        fontSize: 12,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 281,
                    child: Text(
                      "Bill Gates",
                      style: TextStyle(
                        color: Color(0xff1f2430),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 268,
                    child: Text(
                      "bill.google",
                      style: TextStyle(
                        color: Color(0xff00966b),
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 316,
                    child: Text(
                      "18100 - 20100, Nakuru",
                      style: TextStyle(
                        color: Color(0xffafafaf),
                        fontSize: 10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 269,
                    top: 316,
                    child: Text(
                      "+254 713654608",
                      style: TextStyle(
                        color: Color(0xff4e4e4e),
                        fontSize: 10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 310,
                    top: 268,
                    child: Container(
                      width: 36,
                      height: 36,
                      child: Stack(
                        children:[Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0x3337c978),
                          ),
                        ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 16,
                                height: 16,
                                padding: const EdgeInsets.all(1),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Container(
                                      width: 13.33,
                                      height: 13.33,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xff14ab57),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 429,
                    child: Container(
                      width: 310.25,
                      height: 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff1f2430), width: 0.75, ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 387,
                    child: Text(
                      "vuyanziglorious@gmail.com",
                      style: TextStyle(
                        color: Color(0xff4e4e4e),
                        fontSize: 12,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 368,
                    child: Text(
                      "Bill Gates",
                      style: TextStyle(
                        color: Color(0xff1f2430),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 355,
                    child: Text(
                      "bill.google",
                      style: TextStyle(
                        color: Color(0xff00966b),
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 403,
                    child: Text(
                      "18100 - 20100, Nakuru",
                      style: TextStyle(
                        color: Color(0xffafafaf),
                        fontSize: 10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 269,
                    top: 403,
                    child: Text(
                      "+254 713654608",
                      style: TextStyle(
                        color: Color(0xff4e4e4e),
                        fontSize: 10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 310,
                    top: 355,
                    child: Container(
                      width: 36,
                      height: 36,
                      child: Stack(
                        children:[Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0x3337c978),
                          ),
                        ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 16,
                                height: 16,
                                padding: const EdgeInsets.all(1),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Container(
                                      width: 13.33,
                                      height: 13.33,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xff14ab57),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 516,
                    child: Container(
                      width: 310.25,
                      height: 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff1f2430), width: 0.75, ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 429,
                    child: Container(
                      width: 310.25,
                      height: 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff1f2430), width: 0.75, ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 474,
                    child: Text(
                      "vuyanziglorious@gmail.com",
                      style: TextStyle(
                        color: Color(0xff4e4e4e),
                        fontSize: 12,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 455,
                    child: Text(
                      "Bill Gates",
                      style: TextStyle(
                        color: Color(0xff1f2430),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 442,
                    child: Text(
                      "bill.google",
                      style: TextStyle(
                        color: Color(0xff00966b),
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 490,
                    child: Text(
                      "18100 - 20100, Nakuru",
                      style: TextStyle(
                        color: Color(0xffafafaf),
                        fontSize: 10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 269,
                    top: 490,
                    child: Text(
                      "+254 713654608",
                      style: TextStyle(
                        color: Color(0xff4e4e4e),
                        fontSize: 10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 310,
                    top: 442,
                    child: Container(
                      width: 36,
                      height: 36,
                      child: Stack(
                        children:[Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0x3337c978),
                          ),
                        ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 16,
                                height: 16,
                                padding: const EdgeInsets.all(1),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Container(
                                      width: 13.33,
                                      height: 13.33,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xff14ab57),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 603,
                    child: Container(
                      width: 310.25,
                      height: 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff1f2430), width: 0.75, ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 561,
                    child: Text(
                      "vuyanziglorious@gmail.com",
                      style: TextStyle(
                        color: Color(0xff4e4e4e),
                        fontSize: 12,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 542,
                    child: Text(
                      "Bill Gates",
                      style: TextStyle(
                        color: Color(0xff1f2430),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 529,
                    child: Text(
                      "bill.google",
                      style: TextStyle(
                        color: Color(0xff00966b),
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 577,
                    child: Text(
                      "18100 - 20100, Nakuru",
                      style: TextStyle(
                        color: Color(0xffafafaf),
                        fontSize: 10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 269,
                    top: 577,
                    child: Text(
                      "+254 713654608",
                      style: TextStyle(
                        color: Color(0xff4e4e4e),
                        fontSize: 10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 310,
                    top: 529,
                    child: Container(
                      width: 36,
                      height: 36,
                      child: Stack(
                        children:[Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0x3337c978),
                          ),
                        ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 16,
                                height: 16,
                                padding: const EdgeInsets.all(1),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Container(
                                      width: 13.33,
                                      height: 13.33,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xff14ab57),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 690,
                    child: Container(
                      width: 310.25,
                      height: 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff1f2430), width: 0.75, ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 648,
                    child: Text(
                      "vuyanziglorious@gmail.com",
                      style: TextStyle(
                        color: Color(0xff4e4e4e),
                        fontSize: 12,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 629,
                    child: Text(
                      "Bill Gates",
                      style: TextStyle(
                        color: Color(0xff1f2430),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 616,
                    child: Text(
                      "bill.google",
                      style: TextStyle(
                        color: Color(0xff00966b),
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 664,
                    child: Text(
                      "18100 - 20100, Nakuru",
                      style: TextStyle(
                        color: Color(0xffafafaf),
                        fontSize: 10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 269,
                    top: 664,
                    child: Text(
                      "+254 713654608",
                      style: TextStyle(
                        color: Color(0xff4e4e4e),
                        fontSize: 10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 310,
                    top: 616,
                    child: Container(
                      width: 36,
                      height: 36,
                      child: Stack(
                        children:[Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0x3337c978),
                          ),
                        ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 16,
                                height: 16,
                                padding: const EdgeInsets.all(1),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Container(
                                      width: 13.33,
                                      height: 13.33,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xff14ab57),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 777,
                    child: Container(
                      width: 310.25,
                      height: 0.25,
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xff1f2430), width: 0.75, ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 735,
                    child: Text(
                      "vuyanziglorious@gmail.com",
                      style: TextStyle(
                        color: Color(0xff4e4e4e),
                        fontSize: 12,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 716,
                    child: Text(
                      "Bill Gates",
                      style: TextStyle(
                        color: Color(0xff1f2430),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 703,
                    child: Text(
                      "bill.google",
                      style: TextStyle(
                        color: Color(0xff00966b),
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 751,
                    child: Text(
                      "18100 - 20100, Nakuru",
                      style: TextStyle(
                        color: Color(0xffafafaf),
                        fontSize: 10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 269,
                    top: 751,
                    child: Text(
                      "+254 713654608",
                      style: TextStyle(
                        color: Color(0xff4e4e4e),
                        fontSize: 10,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 310,
                    top: 703,
                    child: Container(
                      width: 36,
                      height: 36,
                      child: Stack(
                        children:[Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0x3337c978),
                          ),
                        ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 16,
                                height: 16,
                                padding: const EdgeInsets.all(1),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Container(
                                      width: 13.33,
                                      height: 13.33,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Color(0xff14ab57),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 790,
                    child: Text(
                      "bill.google",
                      style: TextStyle(
                        color: Color(0xff00966b),
                        fontSize: 10,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 35,
              top: 864,
              child: Container(
                width: 310.25,
                height: 0.25,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff1f2430), width: 0.75, ),
                ),
              ),
            ),
            Positioned(
              left: 35,
              top: 822,
              child: Text(
                "vuyanziglorious@gmail.com",
                style: TextStyle(
                  color: Color(0xff4e4e4e),
                  fontSize: 12,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            Positioned(
              left: 35,
              top: 803,
              child: Text(
                "Bill Gates",
                style: TextStyle(
                  color: Color(0xff1f2430),
                  fontSize: 14,
                ),
              ),
            ),
            Positioned(
              left: 35,
              top: 838,
              child: Text(
                "18100 - 20100, Nakuru",
                style: TextStyle(
                  color: Color(0xffafafaf),
                  fontSize: 10,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              left: 269,
              top: 838,
              child: Text(
                "+254 713654608",
                style: TextStyle(
                  color: Color(0xff4e4e4e),
                  fontSize: 10,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
            Positioned(
              left: 310,
              top: 790,
              child: Container(
                width: 36,
                height: 36,
                child: Stack(
                  children:[Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0x3337c978),
                    ),
                  ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 16,
                          height: 16,
                          padding: const EdgeInsets.all(1),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:[
                              Container(
                                width: 13.33,
                                height: 13.33,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xff14ab57),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}