import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_api/local_data/data.dart';
import 'package:cat_api/models/cat_model.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  static const String id = "/search_page";
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isLoading = false;
  TextEditingController controller = TextEditingController();

  late List<Cat> items;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {
    // connecting server

    items = list.map((cat) => Cat.fromJson(cat)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: Stack(
          children: [
            // #body
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // #search
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: double.infinity,
                      margin:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: TextField(
                        controller: controller,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                      ),
                    ),

                    // #gridview
                    // MasonryGridView.count(
                    //   padding: EdgeInsets.symmetric(horizontal: 20),
                    //   itemCount: items.length,
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   crossAxisCount: 2,
                    //   mainAxisSpacing: 5,
                    //   crossAxisSpacing: 5,
                    //   itemBuilder: (context, index) {
                    //     return itemOfCats(items[index]);
                    //   },
                    // ),
                  ],
                ),
              ),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: CachedNetworkImage(
          imageUrl: cat.url!,
          placeholder: (context, text) => Container(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
