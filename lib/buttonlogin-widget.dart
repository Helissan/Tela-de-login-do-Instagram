import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
    
  final Function onTap;
  final bool animabutton;

  const ButtonWidget({this.onTap, this.animabutton}) : super();
    
  _textButton() {
    return Center(
      child: Text("Sign in", 
      style: TextStyle(color: Colors.white,),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        curve: Curves.bounceOut,
        width: animabutton ? 50 : 200,
        height: 50,
        decoration: BoxDecoration(
        //color: animabutton ? Colors.purple : Colors.blue,
        borderRadius: BorderRadius.circular(animabutton ? 40 : 20)
      ),

      duration: Duration(milliseconds: 500),
      child: AnimatedCrossFade(
        firstChild: Center(child: CircularProgressIndicator()), 
        secondChild: _textButton(), 
        crossFadeState: animabutton ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
        duration: Duration(milliseconds: 500)
        )
      )
    );
  }
}