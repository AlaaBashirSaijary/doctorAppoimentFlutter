import 'package:doctorappoiment/Screen/HomeScreen/DoctorsListScreen.dart';
import 'package:get/get.dart';

import '../../Style/consts.dart';
import '../../Style/lists.dart';
import '../../widget_common/featcher_Button.dart';
import '../../widget_common/home_buttins.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  hintStyle: TextStyle(color: textfieldGrey),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: BrandList.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Image.asset(
                              BrandList[index],
                              fit: BoxFit.fill,
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(2, (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: HomeButton(
                          hight: MediaQuery.sizeOf(context).height * 0.15,
                          width: MediaQuery.sizeOf(context).width / 2.5,
                          icon: index == 0 ? icTodaysDeal : icFlashDeal,
                          title: index == 0 ? toDayDeal : flashsale,
                          onPressed: () {},
                        ),
                      )),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: BrandList.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Image.asset(
                              SecoundSliderList[index],
                              fit: BoxFit.fill,
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: redColor,
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'All Services',
                              style: TextStyle(
                                color: whiteColor,
                                fontFamily: bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Row(
                              children: List.generate(
                                8,
                                (index) {
                                  final doctorCards = [
                                    {'title': 'Eye Doctor', 'image': imgP1, 'price': '\$600'},
                                    {'title': 'Dental Specialist', 'image': imgP5, 'price': '\$500'},
                                    {'title': 'Internal Medicine', 'image': imgP6, 'price': '\$700'},
                                    {'title': 'Cardiologist', 'image': imgP7, 'price': '\$800'},
                                    {'title': 'Orthopedic', 'image': imgP5, 'price': '\$750'},
                                    {'title': 'Pediatrician', 'image': imgP6, 'price': '\$650'},
                                    {'title': 'Dermatologist', 'image': imgP7, 'price': '\$550'},
                                   {'title': 'Neurologist', 'image': imgP1, 'price': '\$900'},
                                  ];
                                  final doctor = doctorCards[index % doctorCards.length];
                                  return Container(
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    decoration: BoxDecoration(
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    width: MediaQuery.sizeOf(context).width * 0.5,
                                    height: MediaQuery.sizeOf(context).height * 0.3,
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'All Doctors',
                                          style: TextStyle(
                                            color: whiteColor,
                                            fontFamily: bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Image.asset(
                                          doctor['image']!,
                                          width: 150,
                                          fit: BoxFit.fill,
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          doctor['title']!,
                                          style: TextStyle(
                                            fontFamily: semibold,
                                            color: darkFontGrey,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          doctor['price']!,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: bold,
                                            color: redColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: BrandList.length,
                        itemBuilder: ((context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            clipBehavior: Clip.antiAlias,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Image.asset(
                              SecoundSliderList[index],
                              fit: BoxFit.fill,
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: 300,
                      ),
                      itemBuilder: (context, index) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: whiteColor,
                        ),
                        clipBehavior: Clip.antiAlias,
                        padding: EdgeInsets.all(12),
                        child: InkWell(
                           onTap: () {
        Get.to(() => const DoctorsListScreen());
      },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                imgP5,
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                              ),
                              Spacer(),
                              Text(
                                'Alaa',
                                style: TextStyle(
                                  fontFamily: semibold,
                                  color: darkFontGrey,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                '\$600',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: bold,
                                  color: redColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
