import 'package:flutter/material.dart';

class SlotPage extends StatefulWidget
{
  const SlotPage({super.key});

  @override
  SlotPageBody createState()
  {
    return SlotPageBody();
  }
}

class SlotPageBody extends State<SlotPage>
{
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> datePicker()async
  {
    DateTime? date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050)
    );

    setState(() {
      selectedDate = date!;
    });
  }

  String actualTime(TimeOfDay time)
  {
    if(time.period == DayPeriod.am)
    {
      return "${time.toString().substring(10,15)}am";
    }
    int hour = int.parse(time.toString().substring(10,12));

    if(hour == 12)
    {
      return "12:30pm";
    }
    return "${hour - 12}:30pm";
  }

  Color rgba(int r,int g,int b,double o)
  {
    return Color.fromRGBO(r, g, b, o);
  }

  Color adjustColorAccordingToDateTime(TimeOfDay time)
  {
    if(selectedDate.isAfter(DateTime.now()))
    {
      if(time == selectedTime)
      {
        return rgba(211, 165, 107, 1);
      }
      return rgba(72, 77, 117, 1);
    }
    else if(time.isBefore(TimeOfDay.now()))
    {
      return Colors.grey;
    }
    else if(time == selectedTime)
    {
      return rgba(211, 165, 107, 1);
    }

     return rgba(72, 77, 117, 1);
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Common Area1",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        centerTitle: true,
        elevation: 1,
        backgroundColor:  Color.fromRGBO(6, 40, 70, 0.85),
        shadowColor: Colors.white,
      ),

      backgroundColor: Color.fromRGBO(6, 40, 70, 0.85),

      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking Date",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 15,),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white,width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedDate.toString().substring(0,10),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                      onPressed: datePicker,
                      icon: Icon(Icons.calendar_month,color: Colors.white,)
                  ),
                ],
              ),
            ),

            SizedBox(height: 15,),

            Text(
              "Availability",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 15,),

            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  slotBox(TimeOfDay(hour: 10, minute: 30)),
                  SizedBox(width: 10,),
                  slotBox(TimeOfDay(hour: 11, minute: 30)),
                  SizedBox(width: 10,),
                  slotBox(TimeOfDay(hour: 12, minute: 30)),
                ],
              ),
            ),

            SizedBox(height: 15,),

            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  slotBox(TimeOfDay(hour: 13, minute: 30)),
                  SizedBox(width: 10,),
                  slotBox(TimeOfDay(hour: 14, minute: 30)),
                  SizedBox(width: 10,),
                  slotBox(TimeOfDay(hour: 15, minute: 30)),
                ],
              ),
            ),

            SizedBox(height: 15,),

            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  slotBox(TimeOfDay(hour: 16, minute: 30)),
                  SizedBox(width: 10,),
                  slotBox(TimeOfDay(hour: 17, minute: 30)),
                  SizedBox(width: 10,),
                  slotBox(TimeOfDay(hour: 18, minute: 30)),
                ],
              ),
            ),

            SizedBox(height: 15,),

            Expanded(child: Container()),

            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Confirm Booking",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget slotBox(TimeOfDay time)
  {
    return Flexible(
        child: Container(
            decoration: BoxDecoration(
              color: adjustColorAccordingToDateTime(time),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Radio(
                    activeColor: Colors.white,
                    value: time,
                    groupValue: selectedTime,
                    onChanged: (val){
                      setState(() {
                        if(selectedDate.isAfter(DateTime.now()) || time.isAfter(TimeOfDay.now()))
                        {
                          selectedTime = val!;
                        }
                      });
                    }
                ),),
                Flexible(
                  flex: 2,
                  child: Text(
                  actualTime(time),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),)
              ],
            )
        )
    );
  }
}