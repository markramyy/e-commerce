import 'package:ecommerce/Screens/constants.dart';
import 'package:ecommerce/Screens/product.dart';
import 'package:ecommerce/data_provider/remote_data/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/Screens/Widgets/products.dart';
import 'package:ecommerce/data_provider/remote_data/dio_helper.dart';
import 'package:flutter/foundation.dart';


class category{
  late final String? image_url;
  late final String text;

  category({required this.image_url,required this.text});

}


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<category> categories=[
    category(image_url: 'assets/Images/Laptop (2).png', text: 'Laptop'),
    category(image_url: 'assets/Images/mobile.png', text: 'Smartphone'),
    category(image_url: 'assets/Images/perfume.png', text: 'Fragrance'),
    category(image_url: 'assets/Images/Skincare (2).png', text: 'Skincare'),
    category(image_url: 'assets/Images/groceries.png', text: 'Groceries'),
    category(image_url: 'assets/Images/home-.png', text: 'Home-Decoration'),

  ];

  List<Product> products = [];



  void initState() {
    getData();
    super.initState();

  }
  @override

  Future<void> getData() async {
    List productlist = await DioHelper().getProduct(path: ApiConstants.baseUrl);
    for(var prod in productlist){
      products.add(Product.fromJson(prod));
    }
    setState(() {
    });
  }
  Color color=Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: products.length == 0
    ? const Center(
    child: CircularProgressIndicator(
      color: Colors.deepPurple,
    ),
    )
        : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 310,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search_sharp,color: color,size:30),
                        hintText: 'Search',
                        hintStyle: TextStyle(fontSize: 20,color: Colors.grey[600]),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30),),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: CircleAvatar(
                      backgroundColor: color,
                      radius: 25,
                      child: Icon( Icons.keyboard_control_rounded,),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.deepPurple[100]?.withOpacity(0.4),
                ),
                child:Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children:
                    [
                      Container(
                        width: 140,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            Text('New Collection',style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text('Discount 50% for the first transaction',style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 40,
                              width: 110,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: color,
                              ),
                              child: TextButton(
                                onPressed:(){
                                  print(products[0].title);
                                },
                                child: Text('Shop Now',style:
                                TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(child: Image.asset('assets/Images/cart4.png',width:150,height:150 ,)),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                [
                  Text('Categories',style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)
                      {
                        return Category_Products(products,6);
                      }));
                    },
                    child: Text(
                      "See All",style: TextStyle(
                      color: color,
                      fontSize: 12,
                    ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder:(context,index)=>SizedBox(width: 20,),
                  itemBuilder:(context,index)
                  => GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context)
                        {
                          return Category_Products(products,index);
                        }
                        ));
                      },
                      child: Category(categories[index])),
                  itemCount: categories.length,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0,
              ),
              child: Text('Best Selling',style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              ),
            ),
            SizedBox(
              height:10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 350,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder:(context,index)=>ProductItem(products,index,context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget Category(category Category) {
  return Container(
    width:80 ,
    height: 100,
    child: Column(
      children:
      [
        CircleAvatar(child: Image.asset('${Category.image_url}',height: 100,width: 100,
          fit: BoxFit.cover,
        ),
          backgroundColor: Colors.deepPurple[100]?.withOpacity(0.4),
          radius: 35,
        ),
        SizedBox(
          height: 7,
        ),
        Text('${Category.text}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
