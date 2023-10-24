import 'package:bus/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/sacco/saccoCubits.dart';
import '../../models/tripModel.dart';

class SeatWidget extends StatefulWidget {
  Seat? seat;
  String id;
  bool canBeSelected = true;
  bool isBooked;
  double? lmargin;
  // final Function(Seat seat) onPressed;

  SeatWidget({
    required this.id,
    this.seat,
    required this.canBeSelected,
    required this.isBooked,
    this.lmargin
    // required this.onPressed
  });

  final globalKey = GlobalKey<_SeatWidgetState>();

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  Color seatColor = AppColors.selectableSeatColor;
  bool isSelected = false;
  @override
  void dispose() {
    // TODO: implement dispose
    // _listController.close();
    // BlocProvider.of<SaccoCubits>(context).seatStreamController.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<SaccoCubits>(context);
    return Expanded(
      child: Container(
        width: 40,
        height: 40,
        margin:  EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 0,
              child: Container(
                height: 30,
                width: 10,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  border: Border.all(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 0,
              child: Container(
                height: 30,
                width: 10,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  border: Border.all(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              // right: 0,
              child: Container(
                height: 15,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Colors.black,
                  border: Border.all(
                    color: Colors.black,
                    width: 5,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (widget.seat == null ) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Reserved Seat!, Cannot be Selected"),
                      backgroundColor: Colors.red,
                      dismissDirection: DismissDirection.horizontal,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else if(widget.seat!.isBooked){
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("This seat is already Booked"),
                      backgroundColor: Colors.red,
                      dismissDirection: DismissDirection.horizontal,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }

                else {
                  // BlocProvider.of<SaccoCubits>(context)
                      bloc.getSelectedSeat(widget.seat as Seat);
                  // widget.onPressed;
                  setState(() {
                    isSelected=!isSelected;
                  });
                }
              },
              child: Container(
                height: 60,
                width: 100,
                decoration: BoxDecoration(
                  color: widget.isBooked
                      ? AppColors.bookedSeatColor
                      : isSelected
                          ? AppColors.selectedSeatColor
                          : widget.canBeSelected?AppColors.selectableSeatColor:AppColors.reservedSeatColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      widget.id.toString(),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
