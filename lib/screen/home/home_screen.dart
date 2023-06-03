import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture/model/company.dart';
import 'package:furniture/values/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0, left: 12, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      radius: 32, // Image radius
                      backgroundImage:
                          AssetImage('assets/images/splashLogo.png'),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/images/message.svg',
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'assets/images/notification.svg',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 15, top: 25),
                  child: Text('Hello,',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                  padding: EdgeInsets.only(left: 15, top: 15),
                  child: Text('William Jones',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.64,
          child: ListView.builder(
            itemCount: companies.length,
            itemBuilder: (context, index) {
              final company = companies[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Card(
                    elevation: 3,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.transparent,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset('assets/images/splashLogo.png'),
                          ),
                        ),
                      ),
                      title: Text(company.name),
                      subtitle: Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.yellow,
                          ),
                          SizedBox(width: 4),
                          Text(company.starRating.toString()),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_circle_right_outlined,
                        size: 30,
                      ),
                      onTap: () {
                        // Handle the tap on the list item
                        // You can navigate to the detail screen or perform any other action
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    )));
  }
}
