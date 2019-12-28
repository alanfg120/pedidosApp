import 'package:flutter/material.dart';

class NavigatorBar extends StatefulWidget {

  NavigatorBar({this.items,this.selectpage});

   final  List items;
   final  Function(int index) selectpage;

  @override
  _NavigatorBarState createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea (
        bottom: false,
        child: Container (
               child: BottomAppBar(
                      elevation   : 50.0,
                      shape       : CircularNotchedRectangle(),
                      notchMargin : 7.0,
                      child       :  Row(  
                                     mainAxisSize      : MainAxisSize.max,
                                     mainAxisAlignment : MainAxisAlignment.spaceBetween,
                                     children          : menuItem(widget.items)
                                    ),
               ),
        ),
    );
  }

  List<Widget> menuItem(List menuItems){
         return menuItems.map((item)=>
                FlatButton(
                shape     : CircleBorder(),
                padding   : EdgeInsets.symmetric(vertical: 9),
                child     : Column(
                            mainAxisSize : MainAxisSize.min,
                            children     : <Widget>[
                                             Icon(item[0],color:item[3],size: 30.0),
                                             Text(
                                             item[1],
                                             style:TextStyle(
                                                   fontSize : 11.0,
                                                   color    : item[3]
                                                   )
                                             )
                             ],
                            ),
                onPressed : (){
                                widget.selectpage(item[2]);
                                setState((){
                                            widget.items.forEach((itemmenu) {
                                             if(item[2]!=3)
                                             if(itemmenu[2]==item[2]){
                                                if(itemmenu[2]==0) itemmenu[3]= Colors.teal;
                                                if(itemmenu[2]==1) itemmenu[3]= Colors.pinkAccent;
                                                if(itemmenu[2]==2) itemmenu[3]= Colors.purple;

                                             }
                                                
                                            else itemmenu[3]= Colors.grey;
                                                  
                                            });
                                });
                               },
                )).toList();
  } 
}