import 'package:ecommerce/Screens/Widgets/details.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/Screens/product.dart';
import 'package:path/path.dart';


Widget ProductItem( List<Product>p ,int index,BuildContext context){
  Color color=Colors.deepPurple;
  return InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return Details(p[index]);
      }));
    },
    child: Container(
      height: 320,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color:  Colors.deepPurple[100]?.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Expanded(
        child: Column(
          children:
          [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: color ,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('-${p[index].discountPercentage}%',style:const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(10),
              child: Expanded(
                child: Image.network('${p[index].thumbnail}',width:150 ,height:150 ,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              margin: const EdgeInsets.only(left: 8),
              alignment: Alignment.centerLeft,
              child: Text('${p[index].title}',style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
                maxLines: 1,
                overflow:TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 8),
              alignment: Alignment.centerLeft,
              child: Text('${p[index].description}',style: const TextStyle(
                fontSize: 15,
              ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:
                  [
                    Text('\$${p[index].price}',style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                    IconButton(
                      onPressed:(){},
                      icon:const Icon(Icons.add_shopping_cart_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

List<String>products_appbar=
[
  'Laptops',
  'Smartphones',
  'Fragrances',
  'Skincare',
  'Groceries',
  'Home-Decoration',
  'All Products',
];

Widget Category_Products(List<Product>p ,int index)
{
  List<Product>products=[];
  for(int i=0;i<p.length;i++){
    if(index==0&&p[i].category=='laptops')
      products.add(p[i]);
    else if(index==1&&p[i].category=='smartphones')
      products.add(p[i]);
    else if(index==2&&p[i].category=='fragrances')
      products.add(p[i]);
    else if(index==3&&p[i].category=='skincare')
      products.add(p[i]);
    else if(index==4&&p[i].category=='groceries')
      products.add(p[i]);
    else if(index==5&&p[i].category=='home-decoration')
      products.add(p[i]);
    else if(index==6)
      products.add(p[i]);

  }
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.deepPurple,
      title: Text(products_appbar[index],style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),),
    ),
    body: Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 350,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder:(context,index)=>ProductItem(products,index,context),
      ),
    ),
  );
}