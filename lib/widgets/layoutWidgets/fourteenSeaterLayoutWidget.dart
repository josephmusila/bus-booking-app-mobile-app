import 'package:flutter/material.dart';

import '../../models/tripModel.dart';
import 'seatWidget.dart';


class FourteenSeaterLayoutWidget extends StatefulWidget {

  List<Seat> seats;


  FourteenSeaterLayoutWidget({required this.seats});

  @override
  State<FourteenSeaterLayoutWidget> createState() => _FourteenSeaterLayoutWidgetState();
}

class _FourteenSeaterLayoutWidgetState extends State<FourteenSeaterLayoutWidget> {

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
    return  Container(
      // height: 450,
      width: 170,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              customSeats[0],
              customSeats[1],
              // SeatWidget(
              //     onPressed: getSeats.getSelectedSeat,
              //     id: 2,
              //     canBeSelected: true,
              //     hasBeenSelected: false),
              const SizedBox(
                width: 20,
              ),
              // customSeats[2],
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
              customSeats[4],
            ],
          ),
          Row(
            children: [
              customSeats[5],
              const SizedBox(
                width: 20,
              ),
              customSeats[6],
              customSeats[7],
            ],
          ),
          Row(
            children: [
              customSeats[8],
              const SizedBox(
                width: 20,
              ),
              customSeats[9],
              customSeats[10],
            ],
          ),
          Row(
            children: [
              customSeats[11],
              customSeats[12],
              customSeats[13],
            ],
          ),
        ],
      ),
    );
  }
}




