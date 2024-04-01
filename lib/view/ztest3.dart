import 'package:flutter/material.dart';
import 'package:fapjoymall/generated/assets.dart';
import 'package:fapjoymall/ztest.dart';

class ertyuio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Slot Machine Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 10,color: Colors.black26)
                ),
                child: Container(


                  child: Center(
                    child: SlotMachine(
                      rollItems:  [
                        RollItem(index: 0, child:  Image.asset(Assets.images1)),
                        RollItem(index: 1, child:  Image.asset(Assets.images4)),
                        RollItem(index: 2, child:  Image.asset(Assets.images5)),
                        RollItem(index: 3, child:  Image.asset(Assets.images6)),
                        RollItem(index: 4, child:  Image.asset(Assets.images7)),
                        RollItem(index: 5, child:  Image.asset(Assets.images2)),
                      ],
                      onCreated: (controller) {
                        // Do something when the slot machine is created
                      },
                      onFinished: (resultIndexes) {
                        // Do something when the slot machine stops
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}