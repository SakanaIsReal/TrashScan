import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrashInformationModel {
  int id;
  String name;
  List<String> tags;
  RichText description;
  RichText longDescription; // New property for detailed content
  String imagePath;
  int total;
  Color color;
  IconData icon;
  String markerPath;
  List<LatLng>? trashLoc;

  TrashInformationModel({
    required this.id,
    required this.name,
    required this.tags,
    required this.description,
    required this.longDescription, // Added to constructor
    required this.imagePath,
    required this.total,
    required this.color,
    required this.icon,
    required this.markerPath,
    this.trashLoc = const [
      LatLng(13.792049, 100.320260),
      LatLng(13.792027, 100.320150)
    ],
  });

  static List<TrashInformationModel> getCategories() {
    List<TrashInformationModel> categories = [];

    categories.add(TrashInformationModel(
      id: 1,
      name: 'Plastics',
      tags: ['Recyclable', 'PET', 'HDPE'],
      description: RichText(
        text: TextSpan(
          text: 'Plastics can be recycled into new products. ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Learn more',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      longDescription: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
              text: 'How to Sort Plastic Waste\n\n',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            TextSpan(
                text:
                    '1. Check the Resin Identification Code (usually found at the bottom of containers):\n'),
            TextSpan(text: '   - ♳ PET (1): Water bottles, food containers\n'),
            TextSpan(text: '   - ♴ HDPE (2): Milk jugs, shampoo bottles\n'),
            TextSpan(text: '   - ♵ PVC (3): Pipes, credit cards\n'),
            TextSpan(
                text: '   - ♶ LDPE (4): Plastic bags, squeeze bottles\n\n'),
            TextSpan(text: '2. Clean containers: Rinse out food residue\n'),
            TextSpan(
                text:
                    '3. Remove non-plastic parts: Caps, labels (unless same material)\n'),
            TextSpan(text: '4. Flatten containers to save space\n\n'),
            TextSpan(text: 'What NOT to recycle:\n'),
            TextSpan(text: '• Plastic bags (return to grocery stores)\n'),
            TextSpan(text: '• Styrofoam\n'),
            TextSpan(text: '• Plastic utensils\n'),
            TextSpan(text: '• Biodegradable plastics\n\n'),
            TextSpan(
              text: 'Recycling Process:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text:
                    ' Collected → Sorted → Shredded → Washed → Melted → Pelletized → Made into new products'),
          ],
        ),
      ),
      imagePath: 'assets/images/plastics.jpg',
      total: 120,
      color: Color(0xff76CAFF),
      icon: Icons.local_drink,
      markerPath: 'assets/images/marker_plastic.png',
      trashLoc: [LatLng(13.792141, 100.319698), LatLng(13.792003, 100.319754)],
    ));

    categories.add(TrashInformationModel(
      id: 2,
      name: 'Paper',
      tags: ['Recyclable', 'Cardboard', 'Newspaper'],
      description: RichText(
        text: TextSpan(
          text: 'Paper products can be recycled 5-7 times. ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Learn more',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      longDescription: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
              text: 'Proper Paper Recycling Guide\n\n',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            TextSpan(text: 'Accepted Materials:\n'),
            TextSpan(
                text:
                    '• Office paper\n• Newspapers\n• Magazines\n• Cardboard (flattened)\n• Paper bags\n• Paperboard (cereal boxes)\n\n'),
            TextSpan(text: 'Preparation Steps:\n'),
            TextSpan(text: '1. Remove any plastic windows from envelopes\n'),
            TextSpan(text: '2. Take out staples and paper clips\n'),
            TextSpan(text: '3. Flatten cardboard boxes\n'),
            TextSpan(text: '4. Keep paper dry and clean\n\n'),
            TextSpan(text: 'What NOT to include:\n'),
            TextSpan(
                text:
                    '• Waxed paper\n• Thermal receipts\n• Used paper towels\n• Pizza boxes with grease stains\n• Laminated paper\n\n'),
            TextSpan(
              text: 'Recycling Benefits:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text:
                    ' Saves trees (1 ton = 17 trees), uses 40% less energy than making new paper, reduces water pollution by 35%'),
          ],
        ),
      ),
      imagePath: 'assets/images/papers.jpg',
      total: 200,
      color: Color(0xff3CB75D),
      icon: Icons.receipt_long,
      markerPath: 'assets/images/marker_paper.png',
      trashLoc: [LatLng(13.792056, 100.319036), LatLng(13.792981, 100.318814)],
    ));

    categories.add(TrashInformationModel(
      id: 3,
      name: 'E-waste',
      tags: ['Hazardous', 'Electronics', 'Recyclable'],
      description: RichText(
        text: TextSpan(
          text: 'E-waste requires special recycling. ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Learn more',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      longDescription: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
              text: 'Electronic Waste Recycling\n\n',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            TextSpan(text: 'Common E-waste Items:\n'),
            TextSpan(
                text:
                    '• Computers and laptops\n• TVs and monitors\n• Cell phones\n• Printers\n• Batteries\n• Small appliances\n\n'),
            TextSpan(text: 'Why Recycle E-waste?\n'),
            TextSpan(
                text:
                    'Electronics contain valuable metals (gold, silver, copper) and hazardous materials (lead, mercury) that should be properly handled.\n\n'),
            TextSpan(text: 'Recycling Steps:\n'),
            TextSpan(text: '1. Delete all personal data from devices\n'),
            TextSpan(
                text: '2. Remove batteries if possible (recycle separately)\n'),
            TextSpan(text: '3. Find certified e-waste recycler\n'),
            TextSpan(text: '4. Check for manufacturer take-back programs\n\n'),
            TextSpan(text: 'What NOT to do:\n'),
            TextSpan(
                text:
                    '• Throw in regular trash\n• Burn electronics\n• Dismantle at home (risk of exposure to toxins)'),
          ],
        ),
      ),
      imagePath: 'assets/images/ewaste.jpg',
      total: 25,
      color: Color(0xffFFC65C),
      icon: Icons.computer,
      markerPath: 'assets/images/marker_ewaste.png',
      trashLoc: [LatLng(13.792910, 100.319621), LatLng(13.793183, 100.320301)],
    ));

    categories.add(TrashInformationModel(
      id: 4,
      name: 'Glass',
      tags: ['Recyclable', 'Bottles', 'Jars'],
      description: RichText(
        text: TextSpan(
          text: 'Glass can be recycled endlessly. ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Learn more',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      longDescription: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
              text: 'Glass Recycling Guide\n\n',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            TextSpan(text: 'Accepted Glass Items:\n'),
            TextSpan(
                text:
                    '• Clear, green, and brown glass bottles\n• Glass jars (food, cosmetics)\n• Beer and wine bottles\n\n'),
            TextSpan(text: 'Preparation:\n'),
            TextSpan(text: '1. Rinse containers (no need to remove labels)\n'),
            TextSpan(text: '2. Remove metal lids (recycle separately)\n'),
            TextSpan(text: '3. Sort by color if required in your area\n\n'),
            TextSpan(text: 'What NOT to recycle:\n'),
            TextSpan(
                text:
                    '• Window glass\n• Mirrors\n• Light bulbs\n• Ceramics\n• Pyrex\n• Drinking glasses\n\n'),
            TextSpan(
              text: 'Recycling Process:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text:
                    ' Glass is crushed into cullet → Mixed with raw materials → Melted → Molded into new containers. Recycled glass melts at lower temperature, saving energy.'),
          ],
        ),
      ),
      imagePath: 'assets/images/glass.png',
      total: 65,
      color: Color(0xff949494),
      icon: Icons.liquor,
      markerPath: 'assets/images/marker_glass.png',
      trashLoc: [LatLng(13.793404, 100.320103), LatLng(13.793558, 100.319809)],
    ));

    categories.add(TrashInformationModel(
      id: 5,
      name: 'Organic Waste',
      tags: ['Compostable', 'Food', 'Yard'],
      description: RichText(
        text: TextSpan(
          text: 'Organic waste can be composted. ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Learn more',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      longDescription: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
              text: 'Composting Organic Waste\n\n',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            TextSpan(text: 'What to Compost:\n'),
            TextSpan(
                text:
                    '• Fruit and vegetable scraps\n• Eggshells\n• Coffee grounds and filters\n• Tea bags\n• Yard trimmings\n• Leaves\n• Small amounts of paper\n\n'),
            TextSpan(text: 'What NOT to Compost:\n'),
            TextSpan(
                text:
                    '• Meat and dairy products\n• Fats and oils\n• Diseased plants\n• Pet wastes\n• Coal or charcoal ash\n\n'),
            TextSpan(text: 'Composting Methods:\n'),
            TextSpan(
                text:
                    '1. Backyard composting: Layer greens (nitrogen) and browns (carbon)\n'),
            TextSpan(
                text:
                    '2. Vermicomposting: Using worms to break down food waste\n'),
            TextSpan(
                text:
                    '3. Municipal composting: Check local collection programs\n\n'),
            TextSpan(
              text: 'Benefits:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text:
                    ' Reduces landfill methane, creates nutrient-rich soil amendment, reduces need for chemical fertilizers'),
          ],
        ),
      ),
      imagePath: 'assets/images/organic.jpg',
      total: 150,
      color: Color(0xffF3833D),
      icon: Icons.compost,
      markerPath: 'assets/images/marker_organic.png',
      trashLoc: [LatLng(13.793521, 100.319318), LatLng(13.793644, 100.318778)],
    ));

    categories.add(TrashInformationModel(
      id: 6,
      name: 'Hazardous',
      tags: ['Dangerous', 'Chemicals', 'Batteries'],
      description: RichText(
        text: TextSpan(
          text: 'Handle hazardous waste with care. ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Learn more',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      longDescription: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
              text: 'Hazardous Waste Disposal Guide\n\n',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            TextSpan(text: 'Common Hazardous Waste:\n'),
            TextSpan(
                text:
                    '• Batteries (all types)\n• Paint and solvents\n• Pesticides\n• Cleaning chemicals\n• Fluorescent bulbs\n• Motor oil\n• Medications\n\n'),
            TextSpan(text: 'Safe Disposal Methods:\n'),
            TextSpan(text: '1. Never pour down drain or throw in trash\n'),
            TextSpan(text: '2. Check for local collection events\n'),
            TextSpan(text: '3. Use designated drop-off facilities\n'),
            TextSpan(text: '4. Keep in original containers when possible\n'),
            TextSpan(text: '5. Never mix different chemicals\n\n'),
            TextSpan(text: 'Special Handling:\n'),
            TextSpan(text: '• Batteries: Tape terminals before disposal\n'),
            TextSpan(text: '• Paint: Dry out latex paint before disposal\n'),
            TextSpan(text: '• Needles: Use sharps containers\n\n'),
            TextSpan(
              text: 'Why Proper Disposal Matters:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text:
                    ' Prevents contamination of water supplies, reduces fire risk, protects sanitation workers'),
          ],
        ),
      ),
      imagePath: 'assets/images/hazardous.jpg',
      total: 15,
      color: Color(0xffFF4F4F),
      icon: Icons.dangerous,
      markerPath: 'assets/images/marker_hazardous.png',
      trashLoc: [LatLng(13.793449, 100.320687), LatLng(13.792875, 100.320679)],
    ));

    categories.add(TrashInformationModel(
      id: 7,
      name: 'Metal',
      tags: ['Recyclable', 'Aluminum', 'Steel'],
      description: RichText(
        text: TextSpan(
          text: 'Metal items like cans can be recycled. ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Learn more',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
      longDescription: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 16),
          children: [
            TextSpan(
              text: 'Metal Recycling Guide\n\n',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            TextSpan(text: 'Common recyclable metals:\n'),
            TextSpan(
                text:
                    '• Aluminum cans (soda, beer)\n• Steel food cans\n• Foil (clean only)\n• Small metal objects\n\n'),
            TextSpan(text: 'Preparation:\n'),
            TextSpan(text: '1. Rinse containers to remove food residue\n'),
            TextSpan(text: '2. Flatten if possible\n'),
            TextSpan(
                text:
                    '3. Separate aluminum from steel (if required by local program)\n\n'),
            TextSpan(
              text: 'Benefits:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text:
                    ' Saves energy, reduces mining, infinitely recyclable without quality loss'),
          ],
        ),
      ),
      imagePath: 'assets/images/metal.jpg',
      total: 50,
      color: Color(0xff505050),
      icon: Icons.fire_extinguisher, // หรือเลือก icon ที่เกี่ยวกับโลหะ
      markerPath: 'assets/images/marker_metal.png',
      trashLoc: [LatLng(13.793900, 100.319999), LatLng(13.794000, 100.320200)],
    ));

    return categories;
  }

  static TrashInformationModel? getCategoryById(int id) {
    try {
      return getCategories().firstWhere((category) => category.id == id);
    } catch (e) {
      return null; // Return null if no category matches the id
    }
  }
}
