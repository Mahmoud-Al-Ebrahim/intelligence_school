import 'package:flutter/material.dart';
import '../../../../../theme/colors.dart';

class HomeWorkCard extends StatelessWidget {
   HomeWorkCard({Key? key, required this.title, required this.description})
      : super(key: key);

  final String title;
  final String description;
  final ValueNotifier<bool> checked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: lightPink),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              checked.value = !checked.value;
            },
            child: ValueListenableBuilder<bool>(
              valueListenable: checked,
              builder: (context , check , _) {
                return Container(
                  padding: EdgeInsets.all(check ? 2 : 0) ,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: check ? primaryColor : Colors.white,
                      border:check ? null :  Border.all(width:  2)),
                  child: check
                      ? const Icon(
                          Icons.check,
                          size: 30.0,
                          color: Colors.white,
                        )
                      : const SizedBox(
                          width: 30,
                          height: 30,
                        ),
                );
              }
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,

                  ),
                ),
              ),
              Text(
                description,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
