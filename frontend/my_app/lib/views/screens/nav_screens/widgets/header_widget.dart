import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Stack(
        children: [
          Image.asset(
            'assets/icons/searchBanner.jpeg', // Adjust the path if needed.
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 48,
            top: 68,
            child: SizedBox(
              width: 250,
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter text',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff7f7f7f),
                  ),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/icons/searc1.png"),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/icons/cam.png"),
                  ),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 311,
            top: 78,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                child: Ink(
                  width: 31,
                  height: 31,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/bell.png"),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 354,
            top: 78,
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                child: Ink(
                  width: 31,
                  height: 31,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/message.png"),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
