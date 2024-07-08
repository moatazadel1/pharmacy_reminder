import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.all(10),
          child: Padding(
            padding: EdgeInsets.only(left: 60),
            child: Text("About Us",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                )),
          ),
        ),
        leading: const BackButton(color: Color(0xFF295c82)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Image(
              image: AssetImage("images/Date picker.png"),
              height: 200,
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                  child: Text(
                "Our application makes it easy for users & admins to schedule the pharmacy and remind them of product expiration dates.",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              )),
            ),
            const Divider(
              color: Color(0xFF295c82),
              thickness: 3,
            ),
            const Center(
              child: Text(
                "Our Team Members ",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 200),
              child: Text(
                "Flutter Team : ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    child: const Column(
                      children: [
                        Image(
                          image: AssetImage("images/osama.jpg"),
                          width: 150,
                        ),
                        Text(
                          "Osama Ebrahim",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Container(
                    child: const Column(
                      children: [
                        Image(
                          image: AssetImage("images/sama.jpg"),
                          width: 150,
                          height: 200,
                        ),
                        Text(
                          "Sama Wael",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Color(0xFF295c82),
              thickness: 3,
              endIndent: 40,
              indent: 40,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 200),
              child: Text(
                "Backend Team : ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    child: const Column(
                      children: [
                        Image(
                          image: AssetImage("images/ahmed.jpg"),
                          width: 150,
                        ),
                        Text(
                          "Ahmed Mahmoud",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    child: const Column(
                      children: [
                        Image(
                          image: AssetImage("images/mohamed.jpg"),
                          width: 150,
                          height: 200,
                        ),
                        Text(
                          "Mohamed Sadek",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Color(0xFF295c82),
              thickness: 3,
              endIndent: 40,
              indent: 40,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 70),
              child: Text(
                "Analysis & documentation Team : ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    child: const Column(
                      children: [
                        Image(
                          image: AssetImage("images/samaa.jpg"),
                          width: 150,
                          height: 200,
                        ),
                        Text(
                          "Samaa Adel",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Container(
                    child: const Column(
                      children: [
                        Image(
                          image: AssetImage("images/sandy.jpg"),
                          width: 150,
                          height: 200,
                        ),
                        Text(
                          "Sandy Hany",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              color: Color(0xFF295c82),
              thickness: 3,
              endIndent: 40,
              indent: 40,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 200),
              child: Text(
                "UI/UX designer : ",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Container(
                child: const Column(
                  children: [
                    Image(
                      image: AssetImage("images/farah.jpg"),
                      width: 150,
                      height: 200,
                    ),
                    Text(
                      "Farah Samir",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 150,
                width: 400,
                decoration: const BoxDecoration(color: Color(0xFF295c82)),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "If you need any help , you can contact us via",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 130, right: 20),
                          child: Icon(
                            Icons.mail_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Text(
                          "OR",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}