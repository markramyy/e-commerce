import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/Screens/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ecommerce/database/DatabaseHelper.dart';

List<String>images=[
  'assets/Images/3.png',
  'assets/Images/3.png',
  'assets/Images/3.png',
  'assets/Images/3.png',
];
// ignore: must_be_immutable
class Details extends StatefulWidget {
  Product p;
   Details(this.p,{super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int current_index=0;
  bool isFavorite =false;
  final dbHelper =  DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Details',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),
        actions:[
          IconButton(
              onPressed: () async {
                // Toggle the favorite status
                setState(() {
                  isFavorite = !isFavorite;
                });

                final updatedProduct = Product(
                  id: widget.p.id,
                  title: widget.p.title,
                  description: widget.p.description,
                  price: widget.p.price,
                  discountPercentage: widget.p.discountPercentage,
                  rating: widget.p.rating,
                  stock: widget.p.stock,
                  brand: widget.p.brand,
                  category: widget.p.category,
                  thumbnail: widget.p.thumbnail,
                  images: widget.p.images,
                  isFavorite: isFavorite,
                );

                if (isFavorite) {
                  // Insert the product as a favorite in the database
                  await dbHelper.insertFavorite(updatedProduct);
                } else {
                  // Delete the productasync from favorites in the database
                  await dbHelper.deleteFavorite(updatedProduct.id);
                }
              },
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
            ),
        ]
      ),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child:CarouselSlider(
                  items:widget.p.images?.map((item) => Container(child: Center(
                    child: Image.network(item,fit: BoxFit.cover,width: 300,height:300,),
                  ),
                  ),
                  ).toList(),
                  options: CarouselOptions(
                    onPageChanged: (index,reason){
                      setState(() {
                        current_index=index;
                      });
                    },
                    height: 300,
                    enlargeCenterPage: true,
                    aspectRatio: 2,
                     autoPlay: true,
                    //reverse: true,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                  [
                for(int i=0;i<images.length;i++)
                  Container(
                    margin: const EdgeInsets.all(5),
                    height: 11,
                    width: 11,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: current_index==i?Colors.deepPurple:Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: Offset(2, 2)
                        ),
                      ]
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Padding(
                  padding: const  EdgeInsetsDirectional.only(start: 15),
                  child: Text('${widget.p.title}',style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),),
                ),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const  EdgeInsetsDirectional.only(start: 15),
                child: Center(
                  child: Text('${widget.p.brand}',style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
              const SizedBox(height: 5,),
              Padding(
                padding: const  EdgeInsetsDirectional.symmetric(horizontal: 15),
                child: Text('${widget.p.description}',style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const  EdgeInsetsDirectional.only(start: 15),
                child: Text('Total in stock: ${widget.p.stock}',style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),),
              ),
             // SizedBox(height: 10,),
              Container(
                width: double.infinity,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(left:30 ),
                  child: Row(
                    children: [
                      const Text("Rating",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: RatingBar.builder(
                          initialRating: widget.p.rating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text("Price",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                        Text("\$${widget.p.price} ",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 40,
                      width: 200,
                      child: TextButton.icon(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)){
                              return Colors.white;
                            }
                          }),
                        ),
                        onPressed: (){},
                        icon: const Icon(Icons.add_shopping_cart_rounded,color: Colors.white,),
                        label:
                        Container(
                            child: const Text("Add to Cart",style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),)),),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}