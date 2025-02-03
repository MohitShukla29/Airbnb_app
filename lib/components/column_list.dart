import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColumnList extends StatelessWidget {
   ColumnList({super.key,required this.image,required this.title,required this.subtitle, required this.size});
final String title,subtitle,image;
final Size size;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Divider(color: Colors.black26,),
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(image),
                backgroundColor: Colors.white,
                radius: 29,
              ),
              SizedBox(width: size.width*.05,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),),
                    Text(subtitle,softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        fontSize: size.width * 0.0346,
                        color: Colors.grey.shade700,
                      ),),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
