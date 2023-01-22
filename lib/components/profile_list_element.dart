import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geteat/components/simple_text.dart';

class ProfileListElement extends StatefulWidget {
  const ProfileListElement({
    Key? key,
    
    this.title ,
    this.description ,
    @required this.action,
  }) : super(key: key);
  
  final String? title;
  final String? description;
  final Function()? action;
  @override
  State<ProfileListElement> createState() => _ProfileListElementState();
}

class _ProfileListElementState extends State<ProfileListElement> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
                  onTap:widget.action,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                              
                                
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SimpleText(text: widget.title ?? '', color: 1,),
                                    SimpleText(text: widget.description ?? '', thick: 8,),
                                    
                                  ],
                                )
                              ]
                            ),
                            Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColorLight, size: 13,),
                          ]
                        ),
                        Divider(color: Theme.of(context).primaryColorLight, thickness: 1,)
                      ],
                    ),
                  ),
                );
  }
}