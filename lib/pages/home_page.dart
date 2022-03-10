import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_api/local_data/data.dart';
import 'package:cat_api/models/cat_model.dart';
import 'package:cat_api/pages/detail_page.dart';
import 'package:cat_api/services/http_service.dart';
import 'package:cat_api/services/util_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  static const String id = "home_page";

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  bool isLoading = false;
  late TabController controller;
  ScrollController scrollController = ScrollController();
  List<Cat> items = [];
  List<Cat> myCats = [];
  int pageNumber = 1;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
    scrollController.addListener(loadingMore);
    getData();
  }

  void loadingMore() {
    if (scrollController.position.maxScrollExtent == scrollController.position.pixels) {
      getData();
    }
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    // connecting server
    await Network.GET(Network.API_LIST, Network.paramsPage(pageNumber++)).then(parseData);
    setState(() {
      isLoading = false;
    });
  }

  void parseData(String? response) {
    if(response != null) {
      setState(() {
        items.addAll(Network.parseResponse(response));
      });
    } else {
      Utils.fireSnackBar("Please try again later", context);
    }
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: 10,
          bottom: TabBar(
            controller: controller,
            tabs: const [
              Tab(
                child: Text(
                  "All",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  "My Cat",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            // #body
            TabBarView(
              controller: controller,
              children: [
                // #all
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        // #gridview
                        MasonryGridView.count(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: items.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          itemBuilder: (context, index) {
                            return itemOfCats(items[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // #my_cat
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // #gridview
                        MasonryGridView.count(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          itemCount: items.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          itemBuilder: (context, index) {
                            return itemOfCats(items[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // #indicator
            isLoading
                ? Center(child: CircularProgressIndicator())
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ),
          ],
        ),
      ),
    );
  }

  Widget itemOfCats(Cat cat) {
    return AspectRatio(
      aspectRatio: cat.width! / cat.height!,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(seconds: 1),
              pageBuilder: (context, _, animation) => DetailPage(
                imageId: cat.id,
                url: cat.url,
              ),
            ),
          );
        },
        child: Hero(
          tag: cat.id!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: cat.url!,
              placeholder: (context, text) => Container(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
