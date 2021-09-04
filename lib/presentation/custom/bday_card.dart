import 'package:flutter/material.dart';

class BdayCard extends StatelessWidget {
  final String name;

  const BdayCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
      color: Theme
          .of(context)
          .colorScheme
          .primary,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
      ),
      child: Container(

        padding: const EdgeInsets.only(left: 20.0,right:20.0,top: 20.0,bottom: 50.0),


        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Image(
                  image: AssetImage('assets/party.png'), height: 40, width: 40,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("HAPPY",style: Theme.of(context).textTheme.headline4,),
                    Text("BIRTHDAY",style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.75,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 0.5
                        ..color = Colors.white,
                    )),
                  ],
                ),

              ],
            ),
            SizedBox(height: 20,),
            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(name,style: Theme.of(context).textTheme.headline1,),
              ],
            ),
          ],
        ),
      ),
    );
  }

}