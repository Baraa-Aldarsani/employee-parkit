import 'package:employee_parking/helper/constant.dart';
import 'package:flutter/material.dart';

import '../helper/clipper.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreen,
      body: Stack(
        children: [
          Container(
            height: 300,
            child: ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                color:darkblue,
                height: 200,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10,top: 60),

            child: Column(
              children: [
                Card(
                  color: lightgreen,
                  child: GestureDetector(
                    onTap: (){
                    },
                    child: ListTile(
                      leading: Icon(Icons.person,color: darkblue,size: 30,),
                      title: Text('Account',style: TextStyle(color: deepdarkblue,fontSize: 30),),
                      subtitle: const Text('Your name'),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                // Settings section
                Card(
                  color: lightgreen,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: (){},
                        child: ListTile(
                          leading: Icon(Icons.language,color: darkblue,size: 30),
                          title: Text('Language',style: TextStyle(color: deepdarkblue,fontSize: 30)),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){},
                        child: ListTile(
                          leading: Icon(Icons.dark_mode,color: darkblue,size: 30),
                          title: Text('Theme',style: TextStyle(color: deepdarkblue,fontSize: 30)),
                        ),
                      ),
                      const SizedBox(height: 10,),

                      GestureDetector(
                        onTap: (){},
                        child: ListTile(
                          leading: Icon(Icons.logout,color: darkblue,size: 30),
                          title: Text('Logout',style: TextStyle(color: deepdarkblue,fontSize: 30)),
                        ),
                      ),
                      const SizedBox(height: 10,),

                      GestureDetector(
                        onTap: (){},
                        child: ListTile(
                          leading: Icon(Icons.delete_forever,color: darkblue,size: 30),
                          title: Text('Delete account',style: TextStyle(color: deepdarkblue,fontSize: 30)),
                        ),
                      ),
                      const SizedBox(height: 10,),

                      GestureDetector(
                        onTap: (){},
                        child: ListTile(
                          leading: Icon(Icons.help,color: darkblue,size: 30),
                          title: Text('Help',style: TextStyle(color: deepdarkblue,fontSize: 30)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}