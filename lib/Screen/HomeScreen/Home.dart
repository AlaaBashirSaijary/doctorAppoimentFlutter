

import '../../Style/consts.dart';
import '../../Style/lists.dart';
import '../../widget_common/featcher_Button.dart';
import '../../widget_common/home_buttins.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
     // padding:  EdgeInsets.all(12),
      color: lightGrey,
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: SafeArea(
          child: Column(
        children: [
          Container(
            height: 60,
            alignment: Alignment.center,
            color: lightGrey,
            child: TextFormField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: search,
                  hintStyle: TextStyle(color: textfieldGrey)),
            ),
          ),
          SizedBox(height: 10,),
         Expanded(
           child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
             child: Column(
              children: [ Container(
                width:  MediaQuery.sizeOf(context).width,
                height: 100,
                child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                    itemCount: BrandList.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        clipBehavior: Clip.antiAlias,
                margin:const EdgeInsets.symmetric(horizontal:8.0), 
                    child: Image.asset(BrandList[index],
                        fit: BoxFit.fill,),
                      );
                    }
                    )
                    ),
              ),
             const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:List.generate(2, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HomeButton(
                    hight:MediaQuery.sizeOf(context).height*0.15,width: MediaQuery.sizeOf(context).width /2.5,
                          icon:index==0? icTodaysDeal:icFlashDeal,
                          title: index==0?toDayDeal:flashsale,
                          onPressed: (){}),
                )),),
                 const SizedBox(height: 10,),
                   Container(
                width:  MediaQuery.sizeOf(context).width,
                height: 100,
                child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                    itemCount: BrandList.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        clipBehavior: Clip.antiAlias,
                margin:const EdgeInsets.symmetric(horizontal:8.0), 
                    child: Image.asset(SecoundSliderList[index],
                        fit: BoxFit.fill,),
                      );
                    }
                    )
                    ),
              ),
               const SizedBox(height: 10,),
               Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(3, (index) => Padding(padding: EdgeInsets.all(0.2),
                child: HomeButton(
                  hight:MediaQuery.sizeOf(context).height*0.15,width: MediaQuery.sizeOf(context).width /3.5,
                          icon:index==0? icTopCategories:index==1?icBrands:icTopSeller,
                          title: index==0?topcategory:index==1?brand:topSellers,
                          onPressed: (){}),
                ),
                )),
                 const SizedBox(height: 10,),
                const Align(
                  alignment: Alignment.centerLeft,
                   child: Text(
                    feautercategory,style: TextStyle(
                      color: darkFontGrey,
                      fontFamily: semibold,
                      fontSize: 18
                    ),
                   ),
                 ),
               const  SizedBox(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(children: List.generate(3, (index) => Column(
                  children: [
                    FeatureButton(title:feauterTitel1[index] ,icon: featurlist1[index]),
                    const SizedBox(height: 10,),
                    FeatureButton(title:feauterTitel2[index] ,icon: featurlist2[index]),
                  ],
                )).toList(),),
              ),
              const  SizedBox(height: 20,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: redColor
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   const Align(
                  alignment: Alignment.centerLeft,
                   child: Text(
                    feautercategory,style: TextStyle(
                      color: whiteColor,
                      fontFamily: bold,
                      fontSize: 18
                    ),
                   ),
                 ),
                 const  SizedBox(height: 10,),
                 SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                   child: Row(
                    children: List.generate(6, (index) => Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                    color: whiteColor,borderRadius: BorderRadius.circular(25)
                                 ),
                                 width: MediaQuery.sizeOf(context).width*0.5,
                                 height:  MediaQuery.sizeOf(context).height*0.3,
                                 clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(imgP1 ,width: 150,fit: BoxFit.fill,),
                        const  SizedBox(height: 10,),
                        Text('Laptop',style: TextStyle(
                          fontFamily: semibold,color: darkFontGrey
                        ),),
                        const  SizedBox(height: 10,),
                        Text('\$600',style: TextStyle(
                          fontSize: 16,
                          fontFamily: bold,color: redColor
                        ),),
                          ],
                      ),
                    )),
                   ),
                 )
                ]),
              ),
   const SizedBox(height: 20,),
                Container(
                width:  MediaQuery.sizeOf(context).width,
                height: 100,
                child: ListView.builder(
                   scrollDirection: Axis.horizontal,
                    itemCount: BrandList.length,
                    itemBuilder: ((context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        clipBehavior: Clip.antiAlias,
                margin:const EdgeInsets.symmetric(horizontal:8.0), 
                    child: Image.asset(SecoundSliderList[index],
                        fit: BoxFit.fill,),
                      );
                    }
                    )
                    ),
              ),
              const SizedBox(height: 20,),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 300), 
                itemBuilder: (context,index)=>Container(decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: whiteColor
                        ),
                        clipBehavior: Clip.antiAlias,
                        padding: EdgeInsets.all(12),
                        child: 
                            Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(imgP5 ,
                          height: 200,
                          width: 200,fit: BoxFit.fill,),
                       Spacer(),
                        Text('Laptop',style: TextStyle(
                          fontFamily: semibold,color: darkFontGrey
                        ),),
                        const  SizedBox(height: 10,),
                        Text('\$600',style: TextStyle(
                          fontSize: 16,
                          fontFamily: bold,color: redColor
                        ),),
                          ],
                      ),
                          
                        ),)
                 ],
             ),
           ),
         ),
        ],
      )),
    );
  }
}
