import 'package:chat_app/Model/CountryModel.dart';
import 'package:flutter/material.dart';

class CountryPage extends StatefulWidget {
  const CountryPage({Key? key,required this.setCountryData}) : super(key: key);
  final Function setCountryData;

  @override
  State<CountryPage> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  List<CountryModel> countries = [
    CountryModel(name: "India", code: "+91", flag: "🇮🇳"),
    CountryModel(name: "Pakistan", code: "+92", flag: "🇵🇰"),
    CountryModel(name: "United States", code: "+1", flag: "🇺🇸"),
    CountryModel(name: "South Africa", code: "+27", flag: "🇿🇦"),
    CountryModel(name: "Afghanistan", code: "+93", flag: "🇦🇫"),
    CountryModel(name: "United Kingdom", code: "+44", flag: "🇬🇧"),
    CountryModel(name: "Italy", code: "+39", flag: "🇮🇹"),
    CountryModel(name: "Canada", code: "+1", flag: "🇨🇦"),
    CountryModel(name: "Germany", code: "+49", flag: "🇩🇪"),
    CountryModel(name: "France", code: "+33", flag: "🇫🇷"),
    CountryModel(name: "Australia", code: "+61", flag: "🇦🇺"),
    CountryModel(name: "Brazil", code: "+55", flag: "🇧🇷"),
    CountryModel(name: "Japan", code: "+81", flag: "🇯🇵"),
    CountryModel(name: "China", code: "+86", flag: "🇨🇳"),
    CountryModel(name: "Mexico", code: "+52", flag: "🇲🇽"),
    CountryModel(name: "Russia", code: "+7", flag: "🇷🇺"),
    CountryModel(name: "South Korea", code: "+82", flag: "🇰🇷"),
    CountryModel(name: "Argentina", code: "+54", flag: "🇦🇷"),
    CountryModel(name: "Spain", code: "+34", flag: "🇪🇸"),
    CountryModel(name: "Nigeria", code: "+234", flag: "🇳🇬"),
    CountryModel(name: "Egypt", code: "+20", flag: "🇪🇬"),
    CountryModel(name: "Indonesia", code: "+62", flag: "🇮🇩"),
    CountryModel(name: "Saudi Arabia", code: "+966", flag: "🇸🇦"),
    CountryModel(name: "Malaysia", code: "+60", flag: "🇲🇾"),
    CountryModel(name: "Bangladesh", code: "+880", flag: "🇧🇩"),
    CountryModel(name: "Thailand", code: "+66", flag: "🇹🇭"),
    CountryModel(name: "Turkey", code: "+90", flag: "🇹🇷"),
    CountryModel(name: "Vietnam", code: "+84", flag: "🇻🇳"),
    CountryModel(name: "Philippines", code: "+63", flag: "🇵🇭"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.teal),
        ),
        title: const Text(
          "Choose a country",
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            wordSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.teal),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) => countryCard(countries[index]),
      ),
    );
  }

  Widget countryCard(CountryModel country) {
    return InkWell(
      onTap: () {
        widget.setCountryData(country);
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            children: [
              Text(country.flag),
              SizedBox(width: 15,),
              Text(country.name),
              Expanded(
                child: Container(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(country.code),
                    ],
                  )),
              ),
            ],
          )
        ),
      ),
    );
  }


}
