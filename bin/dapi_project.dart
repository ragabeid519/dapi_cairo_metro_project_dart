import 'dart:io';
import 'dart:mirrors';

/////////////////////////calculte ticker price/////////////////////
void ticketPriceCalculation(int numberOfStops) {
  // Function to calculate ticket price based on number of stops
  int ticketPrice = 0;
  if (numberOfStops >= 1 && numberOfStops <= 9) {
    ticketPrice = 8;
  } else if (numberOfStops >= 10 && numberOfStops <= 16) {
    ticketPrice = 10;
  } else if (numberOfStops >= 17 && numberOfStops <= 23) {
    ticketPrice = 15;
  } else if (numberOfStops >= 24) {
    ticketPrice = 20;
  }
  print("Ticket price: $ticketPrice pounds");
}

//////////////get route between stations/////////////////////
List<String> getRoute({
  required int startIndex,
  required int endIndex,
  required List<String> stations,
}) {
  if (endIndex > startIndex) {
    return stations.sublist(startIndex, endIndex + 1);
  } else {
    return stations.sublist(endIndex, startIndex + 1).reversed.toList();
  }
}

void main(List<String> arguments) {
  // Entry point for the dapi_project command-line application.
  print("Enter start platform");
  String startPlatform = stdin.readLineSync() ?? '';

  print("Enter end platform");
  String endPlatform = stdin.readLineSync() ?? '';

  ////////////////// 35 stations in line 1 /////////////////
  List<String> lineOneStations = [
    "New El Marg",
    "El-Marg",
    "Ezbet El-Nakhl",
    "Ain Shams",
    "El-Matareyya",
    "Helmeyet El-Zaitoun",
    "Hadayeq El-Zaitoun",
    "Saray El-Qobba",
    "Hammamat El-Qobba",
    "Kobri El-Qobba",
    "Manshiet El-Sadr",
    "El-Demerdash",
    "Ghamra",
    "Al-Shohadaa (Line 2)",
    "Orabi",
    "Nasser (Line 3)",
    "Sadat (Line 2)",
    "Saad Zaghloul",
    "Al-Sayeda Zeinab",
    "El-Malek El-Saleh",
    "Mar Girgis",
    "El-Zahraa",
    "Dar El-Salam",
    "Hadayeq El-Maadi",
    "Maadi",
    "Sakanat El-Maadi",
    "Tora El-Balad",
    "Kozika",
    "Tora El-Esmant",
    "Elmasraa",
    "Hadayek Helwan",
    "Wadi Hof",
    "Helwan University",
    "Ain Helwan",
    "Helwan",
  ];

  // print(line_one_stations.length);
  ////////////////// 20 stations in line 2 /////////////////

  List<String> lineTwoStations = [
    "Shubra El-Kheima",
    "Kolleyyet El-Zeraa",
    "Mezallat",
    "Khalafawy",
    "St. Teresa",
    "Road El-Farag",
    "Masarra",
    "Al-Shohadaa (Line 1)",
    "Attaba (Line 3)",
    "Mohamed Naguib",
    "Sadat (Line 1)",
    "Opera",
    "Dokki",
    "El Bohoth",
    "Cairo University (Line 3)",
    "Faisal",
    "Giza",
    "Omm El-Masryeen",
    "Sakiat Mekky",
    "El-Mounib",
  ];

  // print(line_two_stations.length);
  ////////////////// 34 stations in line 3 /////////////////

  List<String> lineThreeStations = [
    "Adly Mansour",
    "El Haykestep",
    "Omar Ibn El-Khattab",
    "Qobaa",
    "Hesham Barakat",
    "El Nozha",
    "Nadi El Shams",
    "Alf Maskan",
    "Heliopolis Square",
    "Haroun",
    "Al-Ahram",
    "Koleyet El Banat",
    "Stadium",
    "Fair Zone",
    "Abbassia",
    "Abdou Pasha",
    "El Geish",
    "Bab El Shaaria",
    "Attaba (Line 2)",
    "Nasser (Line 1)",
    "Maspero",
    "Safaa Hegazy",
    "Kit Kat",
  ];

  List<String> lineThreeImbabaDirction = [
    ...lineThreeStations,
    "Sudan",
    "Imbaba",
    "El Bohy",
    "Al Qawmeyya",
    "Ring Road",
    "Rod El Farag Corridor",
  ];

  List<String> lineThreeCairoUnversityDirction = [
    ...lineThreeStations,
    "Tawfikia",
    "Wadi El Nile",
    "Gamat El Dowal",
    "Boulak El Dakrour",
    "Cairo University (Line 2)",
  ];

  ////////////////change stations from line 1 "Al-Shohadaa (Line 2)" , "Nasser (Line 3)", "Sadat (Line 2)"/////////////////////////
  ////////////////change stations from line 2 "Al-Shohadaa (Line 1)" , "Attaba (Line 3)", "Sadat (Line 1)", "Cairo University (Line 3)"/////////////////////////
  ////////////////change stations from line 3 "Attaba (Line 2)" , "Nasser (Line 1)", "Cairo University (Line 2)"/////////////////////////
  ///
  ///////////////ticket price from 1 to 9 stations 8 pounds/////////////////////
  ///////////////ticket price from 10 to 16 stations 10 pounds/////////////////////
  ///////////////ticket price from 17 to 23 stations 15 pounds/////////////////////
  ///////////////ticket price from 24 to 39 stations 20 pounds/////////////////////

  // print(lineThreeStations.length);
  // print(line_three_stations.contains("Attaba (Line 2)"));
  // print(line_three_stations.contains("Nasser (Line 1)"));

  //------------------start metro trip planner---------------------//
  if (startPlatform.isEmpty || endPlatform.isEmpty) {
    print("Invalid input. Please enter valid station names.");
  } else if (!lineOneStations.contains(startPlatform) &&
      !lineTwoStations.contains(startPlatform) &&
      !lineThreeImbabaDirction.contains(startPlatform) &&
      !lineThreeCairoUnversityDirction.contains(startPlatform)) {
    print("Invalid start station. Please enter a valid station name.");
    print("Choose from the following stations:");
    print("Line 1 Stations: ${lineOneStations.join(', ')}");
    print("Line 2 Stations: ${lineTwoStations.join(', ')}");
    print(
      "Line 3 Imbaba Direction Stations: ${lineThreeImbabaDirction.join(', ')}",
    );
    print(
      "Line 3 Cairo University Direction Stations: ${lineThreeCairoUnversityDirction.join(', ')}",
    );
  } else if (!lineOneStations.contains(endPlatform) &&
      !lineTwoStations.contains(endPlatform) &&
      !lineThreeImbabaDirction.contains(endPlatform) &&
      !lineThreeCairoUnversityDirction.contains(endPlatform)) {
    print("Invalid end station. Please enter a valid station name.");
    print("Choose from the following stations:");
    print("Line 1 Stations: ${lineOneStations.join(', ')}");
    print("Line 2 Stations: ${lineTwoStations.join(', ')}");
    print(
      "Line 3 Imbaba Direction Stations: ${lineThreeImbabaDirction.join(', ')}",
    );
    print(
      "Line 3 Cairo University Direction Stations: ${lineThreeCairoUnversityDirction.join(', ')}",
    );
  } else if (startPlatform == endPlatform) {
    print("You are already at your destination.");
    /////////////////////////line one direction/////////////////////
  } else if (lineOneStations.contains(startPlatform) &&
      lineOneStations.contains(endPlatform)) {
    int startIndex = lineOneStations.indexOf(startPlatform);
    int endIndex = lineOneStations.indexOf(endPlatform);
    List<String> route = getRoute(
      startIndex: startIndex,
      endIndex: endIndex,
      stations: lineOneStations,
    );
    int numberOfStops = (endIndex - startIndex).abs();
    int time = numberOfStops * 2;
    String direction = (endIndex > startIndex)
        ? "Helwan direction"
        : "New El Marg direction";
    print("Number of stops: $numberOfStops");
    print("Estimated time to arrive: $time minutes");
    ticketPriceCalculation(numberOfStops);
    print("Direction: $direction");
    print("Route: ${route.join(' -> ')}");
    print("Thank you for using our metro trip planner!");
    ////////////////////////line two direction/////////////////////
  } else if (lineTwoStations.contains(startPlatform) &&
      lineTwoStations.contains(endPlatform)) {
    int startIndex = lineTwoStations.indexOf(startPlatform);
    int endIndex = lineTwoStations.indexOf(endPlatform);
    List<String> route = getRoute(
      startIndex: startIndex,
      endIndex: endIndex,
      stations: lineTwoStations,
    );
    int numberOfStops = (endIndex - startIndex).abs();
    int time = numberOfStops * 2;
    String direction = (endIndex > startIndex)
        ? "El-Mounib direction"
        : "Shubra El-Kheima direction";
    print("Number of stops: $numberOfStops");
    print("Estimated time to arrive: $time minutes");
    ticketPriceCalculation(numberOfStops);
    print("Direction: $direction");
    print("Route: ${route.join(' -> ')}");
    print("Thank you for using our metro trip planner!");
    ////////////////////////line three imbaba direction/////////////////////
  } else if (lineThreeImbabaDirction.contains(startPlatform) &&
      lineThreeImbabaDirction.contains(endPlatform)) {
    int startIndex = lineThreeImbabaDirction.indexOf(startPlatform);
    int endIndex = lineThreeImbabaDirction.indexOf(endPlatform);
    List<String> route = getRoute(
      startIndex: startIndex,
      endIndex: endIndex,
      stations: lineThreeImbabaDirction,
    );
    int numberOfStops = (endIndex - startIndex).abs();
    int time = numberOfStops * 2;
    String direction = (endIndex > startIndex)
        ? "Imbaba direction"
        : "Adly Mansour direction";
    print("Number of stops: $numberOfStops");
    print("Estimated time to arrive: $time minutes");
    ticketPriceCalculation(numberOfStops);
    print("Direction: $direction");
    print("Route: ${route.join(' -> ')}");
    print("Thank you for using our metro trip planner!");
    ////////////////////////line three cairo university direction/////////////////////
  } else if (lineThreeCairoUnversityDirction.contains(startPlatform) &&
      lineThreeCairoUnversityDirction.contains(endPlatform)) {
    int startIndex = lineThreeCairoUnversityDirction.indexOf(startPlatform);
    int endIndex = lineThreeCairoUnversityDirction.indexOf(endPlatform);
    List<String> route = getRoute(
      startIndex: startIndex,
      endIndex: endIndex,
      stations: lineThreeCairoUnversityDirction,
    );
    int numberOfStops = (endIndex - startIndex).abs();
    int time = numberOfStops * 2;
    String direction = (endIndex > startIndex)
        ? "Cairo University direction"
        : "Adly Mansour direction";
    print("Number of stops: $numberOfStops");
    print("Estimated time to arrive: $time minutes");
    ticketPriceCalculation(numberOfStops);
    print("Direction: $direction");
    print("Route: ${route.join(' -> ')}");
    print("Thank you for using our metro trip planner!");
    ////////////////////////line one to line two/////////////////////
  } else if (lineOneStations.contains(startPlatform) &&
      lineTwoStations.contains(endPlatform)) {
    int startIndex = lineOneStations.indexOf(startPlatform);
    int interChangeIndexLineOne = lineOneStations.indexOf(
      "Al-Shohadaa (Line 2)",
    );

    ////////////////////////bouns ///////////////////////////////
    int interChangeIndexLineOne2 = lineOneStations.indexOf("Sadat (Line 2)");
    String direction1 = (interChangeIndexLineOne > startIndex)
        ? "Helwan direction"
        : "New El Marg";
    List<String> routeToChange = getRoute(
      startIndex: startIndex,
      endIndex: interChangeIndexLineOne,
      stations: lineOneStations,
    );

    /////////////////////////bouns ///////////////////////////////
    List<String> routeToChange2 = getRoute(
      startIndex: startIndex,
      endIndex: interChangeIndexLineOne2,
      stations: lineOneStations,
    );
    int endIndex = lineTwoStations.indexOf(endPlatform);
    int interChangeIndexLineTwo = lineTwoStations.indexOf(
      "Al-Shohadaa (Line 1)",
    );

    /////////////////////bouns ///////////////////////////////
    int interChangeIndexLineTwo2 = lineTwoStations.indexOf("Sadat (Line 1)");
    String direction2 = (endIndex > interChangeIndexLineTwo)
        ? "El-Mounib direction"
        : "Shubra El-Kheima";
    List<String> routeFromChange = getRoute(
      startIndex: interChangeIndexLineTwo,
      endIndex: endIndex,
      stations: lineTwoStations,
    );

    /////////////////////bouns ///////////////////////////////
    List<String> routeFromChange2 = getRoute(
      startIndex: interChangeIndexLineTwo2,
      endIndex: endIndex,
      stations: lineTwoStations,
    );
    int numberOfStops =
        (interChangeIndexLineOne - startIndex).abs() +
        (endIndex - interChangeIndexLineTwo).abs();

    //////////////////////bouns ///////////////////////////////
    int numberOfStops2 =
        (interChangeIndexLineOne2 - startIndex).abs() +
        (endIndex - interChangeIndexLineTwo2).abs();
    int time = numberOfStops * 2;

    /////////////////////bouns ///////////////////////////////
    int time2 = numberOfStops2 * 2;
    print("Number of stops: $numberOfStops");
    print("Estimated time to arrive: $time minutes");
    ticketPriceCalculation(numberOfStops);
    print(
      "From $startPlatform take line 1 towards $direction1 to Al-Shohadaa (Line 2) then change to line 2 towards $direction2 to $endPlatform.",
    );
    print("Route: ${routeToChange.join(' -> ')}");
    print("         Change at Al-Shohadaa (Line 2)        ");
    print("Route: ${routeFromChange.join(' -> ')}");

    /////////////////////bouns ///////////////////////////////
    print("-----OR-----");
    print("-----OR-----");
    print("Number of stops: $numberOfStops2");
    print("Estimated time to arrive: $time2 minutes");
    ticketPriceCalculation(numberOfStops2);
    print(
      "From $startPlatform take line 1 towards $direction1 to Sadat (Line 2) then change to line 2 towards $direction2 to $endPlatform.",
    );
    print("Route: ${routeToChange2.join(' -> ')}");
    print("         Change at Sadat (Line 2)        ");
    print("Route: ${routeFromChange2.join(' -> ')}");
    print("Thank you for using our metro trip planner!");
    ////////////////////////line one to line three Imbaba/////////////////////
    ///////////////////////No Bouns here ///////////////////////
  } else if (lineOneStations.contains(startPlatform) &&
      lineThreeImbabaDirction.contains(endPlatform)) {
    int startIndex = lineOneStations.indexOf(startPlatform);
    int interChangeIndexLineOne = lineOneStations.indexOf("Nasser (Line 3)");
    String direction1 = (interChangeIndexLineOne > startIndex)
        ? "Helwan direction"
        : "New El Marg";
    List<String> routeToChange = getRoute(
      startIndex: startIndex,
      endIndex: interChangeIndexLineOne,
      stations: lineOneStations,
    );
    int endIndex = lineThreeImbabaDirction.indexOf(endPlatform);
    int interChangeIndexLineThree = lineThreeImbabaDirction.indexOf(
      "Nasser (Line 1)",
    );
    String direction2 = (endIndex > interChangeIndexLineThree)
        ? "Imbaba direction"
        : "Adly Mansour direction";
    List<String> routeFromChange = getRoute(
      startIndex: interChangeIndexLineThree,
      endIndex: endIndex,
      stations: lineThreeImbabaDirction,
    );
    int numberOfStops =
        (interChangeIndexLineOne - startIndex).abs() +
        (endIndex - interChangeIndexLineThree).abs();
    int time = numberOfStops * 2;
    print("Number of stops: $numberOfStops");
    print("Estimated time to arrive: $time minutes");
    ticketPriceCalculation(numberOfStops);
    print(
      "From $startPlatform take line 1 towards $direction1 to Nasser (Line 3) then change to line 3 towards $direction2 to $endPlatform.",
    );
    print("Route: ${routeToChange.join(' -> ')}");
    print("         Change at Nasser (Line 3)        ");
    print("Route: ${routeFromChange.join(' -> ')}");
    print("Thank you for using our metro trip planner!");
    ///////////////////////line one to line three Cairo University/////////////////////
    ///////////////////////No Bouns here ///////////////////////
  } else if (lineOneStations.contains(startPlatform) &&
      lineThreeCairoUnversityDirction.contains(endPlatform)) {
    int startIndex = lineOneStations.indexOf(startPlatform);
    int interChangeIndexLineOne = lineOneStations.indexOf("Nasser (Line 3)");
    String direction1 = (interChangeIndexLineOne > startIndex)
        ? "Helwan direction"
        : "New El Marg";
    List<String> routeToChange = getRoute(
      startIndex: startIndex,
      endIndex: interChangeIndexLineOne,
      stations: lineOneStations,
    );
    int endIndex = lineThreeCairoUnversityDirction.indexOf(endPlatform);
    int interChangeIndexLineThree = lineThreeCairoUnversityDirction.indexOf(
      "Nasser (Line 1)",
    );
    String direction2 = (endIndex > interChangeIndexLineThree)
        ? "Cairo University direction"
        : "Adly Mansour direction";
    List<String> routeFromChange = getRoute(
      startIndex: interChangeIndexLineThree,
      endIndex: endIndex,
      stations: lineThreeCairoUnversityDirction,
    );
    int numberOfStops =
        (interChangeIndexLineOne - startIndex).abs() +
        (endIndex - interChangeIndexLineThree).abs();
    int time = numberOfStops * 2;
    print("Number of stops: $numberOfStops");
    print("Estimated time to arrive: $time minutes");
    ticketPriceCalculation(numberOfStops);
    print(
      "From $startPlatform take line 1 towards $direction1 to Nasser (Line 3) then change to line 3 towards $direction2 to $endPlatform.",
    );
    print("Route: ${routeToChange.join(' -> ')}");
    print("         Change at Nasser (Line 3)        ");
    print("Route: ${routeFromChange.join(' -> ')}");
    print("Thank you for using our metro trip planner!");
    ///////////////////////line two to line three Imbaba/////////////////////
    ///////////////////////my be have a problem fro cairo to imbaba   note kit kat is not changable station ///////////////////////////////
  } else if (lineTwoStations.contains(startPlatform) &&
      lineThreeImbabaDirction.contains(endPlatform)) {
    int startIndex = lineTwoStations.indexOf(startPlatform);
    int interChangeIndexLineTwo = lineTwoStations.indexOf("Attaba (Line 3)");

    // //////////////////////bouns ///////////////////////////////
    // int interChangeIndexLineTwo2 = lineTwoStations.indexOf(
    //   "Cairo University (Line 1)",
    // );
    String direction1 = (interChangeIndexLineTwo > startIndex)
        ? "El-Mounib direction"
        : "Shubra El-Kheima direction";
    List<String> routeToChange = getRoute(
      startIndex: startIndex,
      endIndex: interChangeIndexLineTwo,
      stations: lineTwoStations,
    );

    // /////////////////////bouns ///////////////////////////////
    // List<String> routeToChange2 = getRoute(
    //   startIndex: startIndex,
    //   endIndex: interChangeIndexLineTwo2,
    //   stations: lineTwoStations,
    // );
    int endIndex = lineThreeImbabaDirction.indexOf(endPlatform);
    int interChangeIndexLineThree = lineThreeImbabaDirction.indexOf(
      "Attaba (Line 2)",
    );

    // /////////////////////bouns ///////////////////////////////
    // int interChangeIndexLineThree2 = lineThreeImbabaDirction.indexOf(
    //   "Cairo University (Line 2)",
    // );
    String direction2 = (endIndex > interChangeIndexLineThree)
        ? "Imbaba direction"
        : "Adly Mansour direction";
    List<String> routeFromChange = getRoute(
      startIndex: interChangeIndexLineThree,
      endIndex: endIndex,
      stations: lineThreeImbabaDirction,
    );

    // /////////////////////bouns ///////////////////////////////
    // List<String> routeFromChange2 = getRoute(
    //   startIndex: interChangeIndexLineThree2,
    //   endIndex: endIndex,
    //   stations: lineThreeImbabaDirction,
    // );
    int numberOfStops =
        (interChangeIndexLineTwo - startIndex).abs() +
        (endIndex - interChangeIndexLineThree).abs();

    //         //////////////////////bouns ///////////////////////////////
    // int numberOfStops2 =
    //         (interChangeIndexLineTwo2 - startIndex).abs() +
    //         (endIndex - interChangeIndexLineThree2).abs();
    int time = numberOfStops * 2;

    // /////////////////////bouns ///////////////////////////////
    // int time2 = numberOfStops2 * 2;
    print("Number of stops: $numberOfStops");
    print("Estimated time to arrive: $time minutes");
    ticketPriceCalculation(numberOfStops);
    print(
      "From $startPlatform take line 2 towards $direction1 to Attaba (Line 3) then change to line 3 towards $direction2 to $endPlatform.",
    );
    print("Route: ${routeToChange.join(' -> ')}");
    print("         Change at Attaba (Line 3)        ");
    print("Route: ${routeFromChange.join(' -> ')}");

    // /////////////////////bouns ///////////////////////////////
    // print("-----OR-----");
    // print("-----OR-----");
    // print("Number of stops: $numberOfStops2");
    // print("Estimated time to arrive: $time2 minutes");
    // ticketPriceCalculation(numberOfStops2);
    // print(
    //   "From $startPlatform take line 2 towards $direction1 to Cairo University (Line 1) then change to line 3 towards $direction2 to $endPlatform.",
    // );
    // print("Route: ${routeToChange2.join(' -> ')}");
    // print("         Change at Cairo University (Line 1)        ");
    // print("Route: ${routeFromChange2.join(' -> ')}");
    print("Thank you for using our metro trip planner!");
    //////////////////////line two to line three Cairo University/////////////////////
  } else if (lineTwoStations.contains(startPlatform) &&
      lineThreeCairoUnversityDirction.contains(endPlatform)) {
    int startIndex = lineTwoStations.indexOf(startPlatform);
    int interChangeIndexLineTwo = lineTwoStations.indexOf("Attaba (Line 3)");

    // //////////////////////bouns ///////////////////////////////
    int interChangeIndexLineTwo2 = lineTwoStations.indexOf(
      "Cairo University (Line 3)",
    );
    String direction1 = (interChangeIndexLineTwo > startIndex)
        ? "El-Mounib direction"
        : "Shubra El-Kheima direction";
    List<String> routeToChange = getRoute(
      startIndex: startIndex,
      endIndex: interChangeIndexLineTwo,
      stations: lineTwoStations,
    );

    // /////////////////////bouns ///////////////////////////////
    List<String> routeToChange2 = getRoute(
      startIndex: startIndex,
      endIndex: interChangeIndexLineTwo2,
      stations: lineTwoStations,
    );
    int endIndex = lineThreeCairoUnversityDirction.indexOf(endPlatform);
    int interChangeIndexLineThree = lineThreeCairoUnversityDirction.indexOf(
      "Attaba (Line 2)",
    );
    // /////////////////////bouns ///////////////////////////////
    int interChangeIndexLineThree2 = lineThreeCairoUnversityDirction.indexOf(
      "Cairo University (Line 2)",
    );
    String direction2 = (endIndex > interChangeIndexLineThree)
        ? "Cairo University direction"
        : "Adly Mansour direction";
    List<String> routeFromChange = getRoute(
      startIndex: interChangeIndexLineThree,
      endIndex: endIndex,
      stations: lineThreeCairoUnversityDirction,
    );

    // /////////////////////bouns ///////////////////////////////
    List<String> routeFromChange2 = getRoute(
      startIndex: interChangeIndexLineThree2,
      endIndex: endIndex,
      stations: lineThreeCairoUnversityDirction,
    );
    int numberOfStops =
        (interChangeIndexLineTwo - startIndex).abs() +
        (endIndex - interChangeIndexLineThree).abs();

    //////////////////////bouns ///////////////////////////////
    int numberOfStops2 =
        (interChangeIndexLineTwo2 - startIndex).abs() +
        (endIndex - interChangeIndexLineThree2).abs();
    int time = numberOfStops * 2;

    /////////////////////bouns ///////////////////////////////
    int time2 = numberOfStops2 * 2;
    print("Number of stops: $numberOfStops");
    print("Estimated time to arrive: $time minutes");
    ticketPriceCalculation(numberOfStops);
    print(
      "From $startPlatform take line 2 towards $direction1 to Attaba (Line 3) then change to line 3 towards $direction2 to $endPlatform.",
    );
    print("Route: ${routeToChange.join(' -> ')}");
    print("         Change at Attaba (Line 3)        ");
    print("Route: ${routeFromChange.join(' -> ')}");

    /////////////////////bouns ///////////////////////////////
    print("-----OR-----");
    print("-----OR-----");
    print("Number of stops: $numberOfStops2");
    print("Estimated time to arrive: $time2 minutes");
    ticketPriceCalculation(numberOfStops2);
    print(
      "From $startPlatform take line 2 towards $direction1 to Cairo University (Line 3) then change to line 3 towards $direction2 to $endPlatform.",
    );
    print("Route: ${routeToChange2.join(' -> ')}");
    print("         Change at Cairo University (Line 3)        ");
    print("Route: ${routeFromChange2.join(' -> ')}");
    print("Thank you for using our metro trip planner!");
    //////////////////////line two to line one/////////////////////
  } else if (lineTwoStations.contains(startPlatform) &&
      lineOneStations.contains(endPlatform)) {
    int startIndex = lineTwoStations.indexOf(startPlatform);
    int interChangeIndexLineTwo = lineTwoStations.indexOf(
      "Al-Shohadaa (Line 1)",
    );

    // //////////////////////bouns ///////////////////////////////
    int interChangeIndexLineTwo2 = lineTwoStations.indexOf("Sadat (Line 1)");
    String direction1 = (interChangeIndexLineTwo > startIndex)
        ? "El-Mounib direction"
        : "Shubra El-Kheima direction";
    List<String> routeToChange = getRoute(
      startIndex: startIndex,
      endIndex: interChangeIndexLineTwo,
      stations: lineTwoStations,
    );

    // /////////////////////bouns ///////////////////////////////
    List<String> routeToChange2 = getRoute(
      startIndex: startIndex,
      endIndex: interChangeIndexLineTwo2,
      stations: lineTwoStations,
    );
    int endIndex = lineOneStations.indexOf(endPlatform);
    int interChangeIndexLineOne = lineOneStations.indexOf(
      "Al-Shohadaa (Line 2)",
    );

    // /////////////////////bouns ///////////////////////////////
    int interChangeIndexLineOne2 = lineOneStations.indexOf("Sadat (Line 2)");
    String direction2 = (endIndex > interChangeIndexLineOne)
        ? "Helwan direction"
        : "New El Marg direction";
    List<String> routeFromChange = getRoute(
      startIndex: interChangeIndexLineOne,
      endIndex: endIndex,
      stations: lineOneStations,
    );

    // /////////////////////bouns ///////////////////////////////
    List<String> routeFromChange2 = getRoute(
      startIndex: interChangeIndexLineOne2,
      endIndex: endIndex,
      stations: lineOneStations,
    );
    int numberOfStops =
        (interChangeIndexLineTwo - startIndex).abs() +
        (endIndex - interChangeIndexLineOne).abs();

    //////////////////////bouns ///////////////////////////////
    int numberOfStops2 =
        (interChangeIndexLineTwo2 - startIndex).abs() +
        (endIndex - interChangeIndexLineOne2).abs();
    int time = numberOfStops * 2;

    /////////////////////bouns ///////////////////////////////
    int time2 = numberOfStops2 * 2;
    print("Number of stops: $numberOfStops");
    print("Estimated time to arrive: $time minutes");
    ticketPriceCalculation(numberOfStops);
    print(
      "From $startPlatform take line 2 towards $direction1 to Al-Shohadaa (Line 1) then change to line 1 towards $direction2 to $endPlatform.",
    );
    print("Route: ${routeToChange.join(' -> ')}");
    print("         Change at Al-Shohadaa (Line 1)        ");
    print("Route: ${routeFromChange.join(' -> ')}");

    /////////////////////bouns ///////////////////////////////
    print("-----OR-----");
    print("-----OR-----");
    print("Number of stops: $numberOfStops2");
    print("Estimated time to arrive: $time2 minutes");
    ticketPriceCalculation(numberOfStops2);
    print(
      "From $startPlatform take line 2 towards $direction1 to Sadat (Line 1) then change to line 1 towards $direction2 to $endPlatform.",
    );
    print("Route: ${routeToChange2.join(' -> ')}");
    print("         Change at Sadat (Line 1)        ");
    print("Route: ${routeFromChange2.join(' -> ')}");
    print("Thank you for using our metro trip planner!");
    /////////////////////////////كمل تعديل في الباقي ابداء من بعد الخطوه دي /////////////////////////
    ///////////////////////line three Imbaba to line one/////////////////////
    ////////////////////////No Bouns here ///////////////////////
  } else if (lineThreeImbabaDirction.contains(startPlatform) &&
      lineOneStations.contains(endPlatform)) {
    int startIndex = lineThreeImbabaDirction.indexOf(startPlatform);
    int interChangeIndexLineThree = lineThreeImbabaDirction.indexOf(
      "Nasser (Line 1)",
    );
    String direction1 = (interChangeIndexLineThree > startIndex)
        ? "Imbaba direction"
        : "Adly Mansour direction";
    List<String> routeToChange = getRoute(
      startIndex: startIndex,
      endIndex: interChangeIndexLineThree,
      stations: lineThreeImbabaDirction,
    );
    int endIndex = lineOneStations.indexOf(endPlatform);
    int interChangeIndexLineOne = lineOneStations.indexOf("Nasser (Line 3)");
    String direction2 = (endIndex > interChangeIndexLineOne)
        ? "Helwan direction"
        : "New El Marg direction";
    List<String> routeFromChange = getRoute(
      startIndex: interChangeIndexLineOne,
      endIndex: endIndex,
      stations: lineOneStations,
    );
    int numberOfStops =
        (interChangeIndexLineThree - startIndex).abs() +
        (endIndex - interChangeIndexLineOne).abs();
    int time = numberOfStops * 2;
    print("Number of stops: $numberOfStops");
    print("Estimated time to arrive: $time minutes");
    ticketPriceCalculation(numberOfStops);
    print(
      "From $startPlatform take line 3 towards $direction1 to Nasser (Line 1) then change to line 1 towards $direction2 to $endPlatform.",
    );
    print("Route: ${routeToChange.join(' -> ')}");
    print("         Change at Nasser (Line 1)        ");
    print("Route: ${routeFromChange.join(' -> ')}");
    print("Thank you for using our metro trip planner!");
    //////////////////////line three Cairo University to line one/////////////////////
    ///////////////////No Bouns here ///////////////////////
  } else if (lineThreeCairoUnversityDirction.contains(startPlatform) &&
      lineOneStations.contains(endPlatform)) {
    int startIndex = lineThreeCairoUnversityDirction.indexOf(startPlatform);
    int interChangeIndexLineThree = lineThreeCairoUnversityDirction.indexOf(
      "Nasser (Line 1)",
    );
    String direction1 = (interChangeIndexLineThree > startIndex)
        ? "Cairo University direction"
        : "Adly Mansour direction";
    List<String> routeToChange = getRoute(
      startIndex: startIndex,
      endIndex: interChangeIndexLineThree,
      stations: lineThreeCairoUnversityDirction,
    );
    int endIndex = lineOneStations.indexOf(endPlatform);
    int interChangeIndexLineOne = lineOneStations.indexOf("Nasser (Line 3)");
    String direction2 = (endIndex > interChangeIndexLineOne)
        ? "Helwan direction"
        : "New El Marg direction";
    List<String> routeFromChange = getRoute(
      startIndex: interChangeIndexLineOne,
      endIndex: endIndex,
      stations: lineOneStations,
    );
    int numberOfStops =
        (interChangeIndexLineThree - startIndex).abs() +
        (endIndex - interChangeIndexLineOne).abs();
    int time = numberOfStops * 2;
    print("Number of stops: $numberOfStops");
    print("Estimated time to arrive: $time minutes");
    ticketPriceCalculation(numberOfStops);
    print(
      "From $startPlatform take line 3 towards $direction1 to Nasser (Line 1) then change to line 1 towards $direction2 to $endPlatform.",
    );
    print("Route: ${routeToChange.join(' -> ')}");
    print("         Change at Nasser (Line 1)        ");
    print("Route: ${routeFromChange.join(' -> ')}");
    print("Thank you for using our metro trip planner!");
    //////////////////////line three Imbaba to line two/////////////////////
    ///////////////////the same error or problem apove   ///////////////////////
  } else if (lineThreeImbabaDirction.contains(startPlatform) &&
      lineTwoStations.contains(endPlatform)) {
    int startIndex = lineThreeImbabaDirction.indexOf(startPlatform);
    int interChangeIndexLineThree = lineThreeImbabaDirction.indexOf(
      "Attaba (Line 2)",
    );
    String direction1 = (interChangeIndexLineThree > startIndex)
        ? "Imbaba direction"
        : "Adly Mansour direction";
    List<String> routeToChange = getRoute(
      startIndex: startIndex,
      endIndex: interChangeIndexLineThree,
      stations: lineThreeImbabaDirction,
    );
    int endIndex = lineTwoStations.indexOf(endPlatform);
    int interChangeIndexLineTwo = lineTwoStations.indexOf("Attaba (Line 3)");
    String direction2 = (endIndex > interChangeIndexLineTwo)
        ? "El-Mounib direction"
        : "Shubra El-Kheima direction";
    List<String> routeFromChange = getRoute(
      startIndex: interChangeIndexLineTwo,
      endIndex: endIndex,
      stations: lineTwoStations,
    );
    int numberOfStops =
        (interChangeIndexLineThree - startIndex).abs() +
        (endIndex - interChangeIndexLineTwo).abs();
    int time = numberOfStops * 2;
    print("Number of stops: $numberOfStops");
    print("Estimated time to arrive: $time minutes");
    ticketPriceCalculation(numberOfStops);
    print(
      "From $startPlatform take line 3 towards $direction1 to Attaba (Line 2) then change to line 2 towards $direction2 to $endPlatform.",
    );
    print("Route: ${routeToChange.join(' -> ')}");
    print("         Change at Attaba (Line 2)        ");
    print("Route: ${routeFromChange.join(' -> ')}");
    print("Thank you for using our metro trip planner!");
    //////////////////////line three Cairo University to line two/////////////////////
  } else if (lineThreeCairoUnversityDirction.contains(startPlatform) &&
      lineTwoStations.contains(endPlatform)) {
    int startIndex = lineThreeCairoUnversityDirction.indexOf(startPlatform);
    int interChangeIndexLineThree = lineThreeCairoUnversityDirction.indexOf(
      "Attaba (Line 2)",
    );

    // //////////////////////bouns ///////////////////////////////
    int interChangeIndexLineThree2 = lineThreeCairoUnversityDirction.indexOf(
      "Cairo University (Line 2)",
    );
    String direction1 = (interChangeIndexLineThree > startIndex)
        ? "Cairo University direction"
        : "Adly Mansour direction";
    List<String> routeToChange = getRoute(
      startIndex: startIndex,
      endIndex: interChangeIndexLineThree,
      stations: lineThreeCairoUnversityDirction,
    );

    // /////////////////////bouns ///////////////////////////////
    List<String> routeToChange2 = getRoute(
      startIndex: startIndex,
      endIndex: interChangeIndexLineThree2,
      stations: lineThreeCairoUnversityDirction,
    );
    int endIndex = lineTwoStations.indexOf(endPlatform);
    int interChangeIndexLineTwo = lineTwoStations.indexOf("Attaba (Line 3)");

    // /////////////////////bouns ///////////////////////////////
    int interChangeIndexLineTwo2 = lineTwoStations.indexOf(
      "Cairo University (Line 3)",
    );
    String direction2 = (endIndex > interChangeIndexLineTwo)
        ? "El-Mounib direction"
        : "Shubra El-Kheima direction";
    List<String> routeFromChange = getRoute(
      startIndex: interChangeIndexLineTwo,
      endIndex: endIndex,
      stations: lineTwoStations,
    );

    // /////////////////////bouns ///////////////////////////////
    List<String> routeFromChange2 = getRoute(
      startIndex: interChangeIndexLineTwo2,
      endIndex: endIndex,
      stations: lineTwoStations,
    );
    int numberOfStops =
        (interChangeIndexLineThree - startIndex).abs() +
        (endIndex - interChangeIndexLineTwo).abs();

    //////////////////////bouns ///////////////////////////////
    int numberOfStops2 =
        (interChangeIndexLineThree2 - startIndex).abs() +
        (endIndex - interChangeIndexLineTwo2).abs();
    int time = numberOfStops * 2;

    /////////////////////bouns ///////////////////////////////
    int time2 = numberOfStops2 * 2;
    print("Number of stops: $numberOfStops");
    print("Estimated time to arrive: $time minutes");
    ticketPriceCalculation(numberOfStops);
    print(
      "From $startPlatform take line 3 towards $direction1 to Attaba (Line 2) then change to line 2 towards $direction2 to $endPlatform.",
    );
    print("Route: ${routeToChange.join(' -> ')}");
    print("         Change at Attaba (Line 2)        ");
    print("Route: ${routeFromChange.join(' -> ')}");

    /////////////////////bouns ///////////////////////////////
    print("-----OR-----");
    print("-----OR-----");
    print("Number of stops: $numberOfStops2");
    print("Estimated time to arrive: $time2 minutes");
    ticketPriceCalculation(numberOfStops2);
    print(
      "From $startPlatform take line 3 towards $direction1 to Cairo University (Line 2) then change to line 2 towards $direction2 to $endPlatform.",
    );
    print("Route: ${routeToChange2.join(' -> ')}");
    print("         Change at Cairo University (Line 2)        ");
    print("Route: ${routeFromChange2.join(' -> ')}");
    print("Thank you for using our metro trip planner!");
  } else {
    print("No direct route available between $startPlatform and $endPlatform.");
    print("Please consider alternative routes or stations.");
  }
}
