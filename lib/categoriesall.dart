import 'package:flutter/material.dart';
import 'package:shoppingapp/produt.dart';

class categoriesall extends StatelessWidget {
  const categoriesall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                IconButton(onPressed: () {
                  Navigator.pop(context);
                },
                    icon: Icon(Icons.arrow_back,
                      color: Colors.black45,
                    )
                ),
                Text("Categories",
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 39
                ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)
                => product(
                  name: 'all',
                )));
              },
              child: ListTile(
                title: Text("All"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)
                => product(
                  name: 'shirts',
                )));
              },
              child: ListTile(
                title: Text("Shirts"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)
                => product(
                  name: 'pants',
                )));
              },
              child: ListTile(
                title: Text("Pants"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)
                => product(
                  name: 'shoes',
                )));
              },
              child: ListTile(
                title: Text("Shoes"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)
                => product(
                  name: 'watches',
                )));
              },
              child: ListTile(
                title: Text("Watches"),
              ),
            ),
            GestureDetector(
              child: ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)
                  => product(
                    name: '',
                  )));
                },
                title: Text("Accessories"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
