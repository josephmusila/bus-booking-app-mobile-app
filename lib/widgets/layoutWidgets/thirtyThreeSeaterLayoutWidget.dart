import 'package:flutter/material.dart';

import '../../config/colors.dart';
import '../../models/tripModel.dart';
import 'seatWidget.dart';
import '../appCustomWidgets/textWidget.dart';

class ThirtyThreeSeaterLayoutWidget extends StatefulWidget {
  List<Seat> seats;

  ThirtyThreeSeaterLayoutWidget({super.key, required this.seats});

  @override
  State<ThirtyThreeSeaterLayoutWidget> createState() =>
      _ThirtyThreeSeaterLayoutWidget();
}

class _ThirtyThreeSeaterLayoutWidget
    extends State<ThirtyThreeSeaterLayoutWidget> {
  List<Widget> customSeats = [];

  void setSeatsData() {
    List<Seat> seatsData = widget.seats;
    for (var element in seatsData) {
      customSeats.add(
        SeatWidget(
          seat: element,
          id: element.seatNumber.toString(),
          canBeSelected: true,

          isBooked: element.isBooked,
          // onPressed: BlocProvider.of<SaccoCubits>(context).getSelectedSeat,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    setSeatsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225,
      decoration: BoxDecoration(
          color: Colors.black26,
          border: Border.all(
            width: 2,
            color: AppColors.whiteColor1
          )),
      child: Column(
        children: [
          Row(
            children: [
              customSeats[0],
              customSeats[1],
              const SizedBox(
                width: 70,
              ),
              SeatWidget(
                  // onPressed: getSeats.getSelectedSeat,
                  id: "Dr",
                  canBeSelected: false,
                  isBooked: false),
            ],
          ),
          const Divider(color: Colors.white, thickness: 3),
          Row(
            children: [
              customSeats[2],
              customSeats[3],
              const SizedBox(
                width: 20,
              ),
              customSeats[4],
              customSeats[5],
            ],
          ),

          Row(
            children: [
              // Container( height: 60, width: 100,),
              Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor1,
                  border: Border.all(
                    color: AppColors.whiteColor,
                    width: 2,
                  ),
                ),
                width: 80,
                // child: MediumTextWidget(
                //     data: "Entrance", color: AppColors.appTextColor1),
              ),
              const SizedBox(
                width: 40,
              ),
              customSeats[6],
              customSeats[7],
            ],
          ),
          Row(
            children: [
              customSeats[8],
              customSeats[9],
              const SizedBox(
                width: 20,
              ),
              customSeats[10],
              customSeats[11],
            ],
          ),
          Row(
            children: [
              customSeats[12],
              customSeats[13],
              const SizedBox(
                width: 20,
              ),
              customSeats[14],
              customSeats[15],
            ],
          ),
          Row(
            children: [
              customSeats[16],
              customSeats[17],
              const SizedBox(
                width: 20,
              ),
              customSeats[18],
              customSeats[19],
            ],
          ),
          Row(
            children: [
              customSeats[20],
              customSeats[21],
              const SizedBox(
                width: 20,
              ),
              customSeats[22],
              customSeats[23],
            ],
          ),
          Row(
            children: [
              customSeats[24],
              customSeats[25],
              const SizedBox(
                width: 20,
              ),
              customSeats[26],
              customSeats[27],
            ],
          ),
          
          Row(
            children: [
              customSeats[28],
              customSeats[29],
              customSeats[30],
              customSeats[31],
              customSeats[32],

            ],
          ),
        ],
      ),
    );
  }
}
