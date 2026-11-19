import '../../core/constants/app_assets.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

/// Mock catalogue (no backend yet). Change a name, price or picture here and
/// every screen that shows the product follows. Downloaded product photos
/// are credited in `assets/CREDITS.md`.
abstract final class ProductData {
  // ---- Vegetables ----
  static const cauliflower = ProductModel(
    id: 'cauliflower',
    name: 'Cauliflower Form The Garden',
    unit: '1 Kg',
    price: 13,
    image: AppAssets.cauliflower,
    category: CategoryType.vegetables,
  );
  static const potato = ProductModel(
    id: 'potato',
    name: 'Potato',
    unit: '1 Kg',
    price: 12,
    image: AppAssets.potato,
    category: CategoryType.vegetables,
  );
  static const tomato = ProductModel(
    id: 'tomato',
    name: 'Fresh Tomato',
    unit: '1 Kg',
    price: 12,
    image: AppAssets.tomato,
    category: CategoryType.vegetables,
  );
  static const broccoli = ProductModel(
    id: 'broccoli',
    name: 'Cauliflower Bangladeshi',
    unit: '5kg',
    price: 20,
    oldPrice: 30,
    weightKg: 5,
    image: AppAssets.broccoli,
    category: CategoryType.vegetables,
  );
  static const carrot = ProductModel(
    id: 'carrot',
    name: 'Carrot Form The Garden',
    unit: '1 Kg',
    price: 13,
    image: AppAssets.carrot,
    category: CategoryType.vegetables,
  );
  static const papaya = ProductModel(
    id: 'papaya',
    name: 'Papaya',
    unit: '1 Kg',
    price: 17,
    image: AppAssets.papaya,
    category: CategoryType.vegetables,
  );
  static const cabbage = ProductModel(
    id: 'cabbage',
    name: 'Cabbage Form The Garden',
    unit: '1 Kg',
    price: 16,
    image: AppAssets.cabbage,
    category: CategoryType.vegetables,
  );

  // ---- Meat & Fish ----
  static const meat = ProductModel(
    id: 'meat',
    name: 'Meat',
    unit: '1 Kg',
    price: 15,
    image: AppAssets.meat,
    category: CategoryType.meatFish,
  );
  static const tunaFish = ProductModel(
    id: 'tuna_fish',
    name: 'Fresh Sea Tuna Fish',
    unit: '1 Kg',
    price: 14,
    image: AppAssets.tunaFish,
    category: CategoryType.meatFish,
  );
  static const chicken = ProductModel(
    id: 'chicken',
    name: 'Fresh Whole Chicken',
    unit: '1.5 Kg',
    price: 11,
    weightKg: 1.5,
    image: AppAssets.chicken,
    category: CategoryType.meatFish,
  );
  static const shrimp = ProductModel(
    id: 'shrimp',
    name: 'Tiger Shrimp',
    unit: '500 Gm',
    price: 19,
    oldPrice: 22,
    weightKg: 0.5,
    image: AppAssets.shrimp,
    category: CategoryType.meatFish,
  );

  // ---- Medicine ----
  static const painRelief = ProductModel(
    id: 'pain_relief',
    name: 'Pain Relief Tablets',
    unit: '10 Tablets',
    price: 2,
    weightKg: 0.02,
    image: AppAssets.painRelief,
    category: CategoryType.medicine,
    description:
        'Fast relief from headache, toothache and body pain. Read the leaflet '
        'and follow the dose on the pack.',
  );
  static const vitaminC = ProductModel(
    id: 'vitamin_c',
    name: 'Vitamin C 1000 mg',
    unit: '60 Tablets',
    price: 9,
    weightKg: 0.15,
    image: AppAssets.vitaminC,
    category: CategoryType.medicine,
  );
  static const coughSyrup = ProductModel(
    id: 'cough_syrup',
    name: 'Honey Cough Syrup',
    unit: '100 Ml',
    price: 5,
    weightKg: 0.15,
    image: AppAssets.coughSyrup,
    category: CategoryType.medicine,
  );
  static const firstAid = ProductModel(
    id: 'first_aid',
    name: 'First Aid Kit',
    unit: '1 Box',
    price: 18,
    oldPrice: 24,
    weightKg: 0.6,
    image: AppAssets.firstAid,
    category: CategoryType.medicine,
  );

  // ---- Baby Care ----
  static const drypers = ProductModel(
    id: 'drypers',
    name: 'Classic pantz Drypers',
    unit: '1 Box',
    price: 13,
    image: AppAssets.drypers,
    category: CategoryType.babyCare,
  );
  static const babyWipes = ProductModel(
    id: 'baby_wipes',
    name: 'Soft Baby Wipes',
    unit: '80 Pcs',
    price: 4,
    weightKg: 0.4,
    image: AppAssets.babyWipes,
    category: CategoryType.babyCare,
  );
  static const feedingBottle = ProductModel(
    id: 'feeding_bottle',
    name: 'Baby Feeding Bottle',
    unit: '250 Ml',
    price: 8,
    weightKg: 0.1,
    image: AppAssets.feedingBottle,
    category: CategoryType.babyCare,
  );

  // ---- Office Supplies ----
  static const notebook = ProductModel(
    id: 'notebook',
    name: 'Ruled Notebook A5',
    unit: '120 Pages',
    price: 3,
    weightKg: 0.25,
    image: AppAssets.notebook,
    category: CategoryType.office,
  );
  static const pens = ProductModel(
    id: 'pens',
    name: 'Ballpoint Pens',
    unit: '10 Pcs',
    price: 2,
    weightKg: 0.1,
    image: AppAssets.pens,
    category: CategoryType.office,
  );
  static const stapler = ProductModel(
    id: 'stapler',
    name: 'Desk Stapler',
    unit: '1 Pc',
    price: 7,
    weightKg: 0.3,
    image: AppAssets.stapler,
    category: CategoryType.office,
  );
  static const stickyNotes = ProductModel(
    id: 'sticky_notes',
    name: 'Sticky Notes',
    unit: '400 Sheets',
    price: 3,
    weightKg: 0.2,
    image: AppAssets.stickyNotes,
    category: CategoryType.office,
  );

  // ---- Beauty ----
  static const foundation = ProductModel(
    id: 'foundation',
    name: 'Treat Love Foundation',
    unit: '750 Ml',
    price: 17,
    weightKg: 0.75,
    image: AppAssets.foundation,
    category: CategoryType.beauty,
  );
  static const lipstick = ProductModel(
    id: 'lipstick',
    name: 'Matte Lipstick',
    unit: '1 Pc',
    price: 9,
    weightKg: 0.05,
    image: AppAssets.lipstick,
    category: CategoryType.beauty,
  );
  static const shampoo = ProductModel(
    id: 'shampoo',
    name: 'Herbal Shampoo',
    unit: '400 Ml',
    price: 7,
    weightKg: 0.4,
    image: AppAssets.shampoo,
    category: CategoryType.beauty,
  );
  static const faceCream = ProductModel(
    id: 'face_cream',
    name: 'Moisturising Face Cream',
    unit: '50 Ml',
    price: 12,
    oldPrice: 15,
    weightKg: 0.1,
    image: AppAssets.faceCream,
    category: CategoryType.beauty,
  );
  static const bodyLotion = ProductModel(
    id: 'body_lotion',
    name: 'Rose Body Lotion',
    unit: '236 Ml',
    price: 6,
    weightKg: 0.2,
    image: AppAssets.bodyLotion,
    category: CategoryType.beauty,
  );

  // ---- Gym Equipment ----
  static const dumbbells = ProductModel(
    id: 'dumbbells',
    name: 'Dumbbell Pair',
    unit: '2 x 5 Kg',
    price: 35,
    weightKg: 10,
    image: AppAssets.dumbbells,
    category: CategoryType.gym,
  );
  static const yogaMat = ProductModel(
    id: 'yoga_mat',
    name: 'Yoga Mat',
    unit: '6 mm',
    price: 19,
    image: AppAssets.yogaMat,
    category: CategoryType.gym,
  );
  static const vinylDumbbells = ProductModel(
    id: 'vinyl_dumbbells',
    name: 'Vinyl Dumbbell Set',
    unit: '3 Pairs',
    price: 24,
    weightKg: 9,
    image: AppAssets.vinylDumbbells,
    category: CategoryType.gym,
  );
  static const kettlebell = ProductModel(
    id: 'kettlebell',
    name: 'Kettlebell',
    unit: '8 Kg',
    price: 29,
    weightKg: 8,
    image: AppAssets.kettlebell,
    category: CategoryType.gym,
  );

  // ---- Gardening Tools ----
  static const wateringCan = ProductModel(
    id: 'watering_can',
    name: 'Watering Can',
    unit: '5 L',
    price: 11,
    weightKg: 0.6,
    image: AppAssets.wateringCan,
    category: CategoryType.gardening,
  );
  static const trowel = ProductModel(
    id: 'trowel',
    name: 'Hand Trowel',
    unit: '1 Pc',
    price: 6,
    weightKg: 0.3,
    image: AppAssets.trowel,
    category: CategoryType.gardening,
  );
  static const pruningShears = ProductModel(
    id: 'pruning_shears',
    name: 'Pruning Shears',
    unit: '1 Pc',
    price: 14,
    weightKg: 0.3,
    image: AppAssets.pruningShears,
    category: CategoryType.gardening,
  );
  static const gardenGloves = ProductModel(
    id: 'garden_gloves',
    name: 'Gardening Gloves',
    unit: '1 Pair',
    price: 5,
    weightKg: 0.1,
    image: AppAssets.gardenGloves,
    category: CategoryType.gardening,
  );

  // ---- Pet Care ----
  static const dogFood = ProductModel(
    id: 'dog_food',
    name: 'Dry Dog Food',
    unit: '2 Kg',
    price: 16,
    weightKg: 2,
    image: AppAssets.dogFood,
    category: CategoryType.petCare,
  );
  static const catFood = ProductModel(
    id: 'cat_food',
    name: 'Cat Food',
    unit: '1 Kg',
    price: 10,
    image: AppAssets.catFood,
    category: CategoryType.petCare,
  );
  static const petBall = ProductModel(
    id: 'pet_ball',
    name: 'Dog Toy Ball',
    unit: '1 Pc',
    price: 4,
    weightKg: 0.1,
    image: AppAssets.petBall,
    category: CategoryType.petCare,
  );
  static const petCollar = ProductModel(
    id: 'pet_collar',
    name: 'Collar & Leash',
    unit: '1 Set',
    price: 9,
    weightKg: 0.2,
    image: AppAssets.petCollar,
    category: CategoryType.petCare,
  );

  // ---- Eye Wears ----
  static const sunglasses = ProductModel(
    id: 'sunglasses',
    name: 'Classic Sunglasses',
    unit: 'UV400',
    price: 25,
    oldPrice: 32,
    weightKg: 0.05,
    image: AppAssets.sunglasses,
    category: CategoryType.eyeWears,
  );
  static const eyeglasses = ProductModel(
    id: 'eyeglasses',
    name: 'Round Eyeglasses',
    unit: '1 Pc',
    price: 30,
    weightKg: 0.05,
    image: AppAssets.eyeglasses,
    category: CategoryType.eyeWears,
  );
  static const readingGlasses = ProductModel(
    id: 'reading_glasses',
    name: 'Reading Glasses',
    unit: '+1.5',
    price: 12,
    weightKg: 0.05,
    image: AppAssets.readingGlasses,
    category: CategoryType.eyeWears,
  );
  static const lensCase = ProductModel(
    id: 'lens_case',
    name: 'Glasses Case',
    unit: '1 Pc',
    price: 4,
    weightKg: 0.1,
    image: AppAssets.lensCase,
    category: CategoryType.eyeWears,
  );

  // ---- Other (snacks, frozen) ----
  static const perrysIceCream = ProductModel(
    id: 'perrys_ice_cream',
    name: 'Perry’s Ice Cream Banana',
    unit: '800 Gm',
    price: 13,
    weightKg: 0.8,
    image: AppAssets.perrysIceCream,
  );
  static const vanillaIceCream = ProductModel(
    id: 'vanilla_ice_cream',
    name: 'Vanilla Ice Cream',
    unit: '500 Gm',
    price: 12,
    weightKg: 0.5,
    image: AppAssets.vanillaIceCream,
  );
  static const oreoBiscuit = ProductModel(
    id: 'oreo_biscuit',
    name: 'Oreo Biscut',
    unit: '1000 GM',
    price: 14,
    image: AppAssets.oreoBiscuit,
  );
  static const girlGuideBiscuits = ProductModel(
    id: 'girl_guide_biscuits',
    name: 'Girl Guide Biscuits',
    unit: '200 Gm',
    price: 18,
    weightKg: 0.2,
    image: AppAssets.girlGuideBiscuits,
  );
  static const sulphurfreeBura = ProductModel(
    id: 'sulphurfree_bura',
    name: 'Sulphurfree Bura',
    unit: '570 Ml',
    price: 11,
    weightKg: 0.57,
    image: AppAssets.sulphurfreeBura,
  );
  static const arnotts = ProductModel(
    id: 'arnotts',
    name: 'Arnott’s',
    unit: '700 Gm',
    price: 15,
    weightKg: 0.7,
    image: AppAssets.arnotts,
  );

  /// Every product, in shelf order.
  static const List<ProductModel> all = [
    cauliflower, potato, tomato, broccoli, carrot, papaya, cabbage, //
    meat, tunaFish, chicken, shrimp, //
    painRelief, vitaminC, coughSyrup, firstAid, //
    drypers, babyWipes, feedingBottle, //
    notebook, pens, stapler, stickyNotes, //
    foundation, lipstick, shampoo, faceCream, bodyLotion, //
    dumbbells, yogaMat, vinylDumbbells, kettlebell, //
    wateringCan, trowel, pruningShears, gardenGloves, //
    dogFood, catFood, petBall, petCollar, //
    sunglasses, eyeglasses, readingGlasses, lensCase, //
    perrysIceCream,
    vanillaIceCream,
    oreoBiscuit,
    girlGuideBiscuits,
    sulphurfreeBura,
    arnotts,
  ];

  /// Products on one shelf. `CategoryType.pack` has none (packs are in
  /// `PackData`).
  static List<ProductModel> byCategory(CategoryType type) =>
      all.where((p) => p.category == type).toList();

  /// Case-insensitive name search (Search Result, Create My Pack).
  static List<ProductModel> search(
    String query, {
    Iterable<ProductModel> from = all,
  }) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return from.toList();
    return from.where((p) => p.name.toLowerCase().contains(q)).toList();
  }

  /// Home "Our New Item" preview.
  static const List<ProductModel> homeNewItems = [
    girlGuideBiscuits,
    tomato,
    drypers,
    oreoBiscuit,
  ];

  /// "New Item" page.
  static const List<ProductModel> newItems = [
    perrysIceCream, vanillaIceCream, meat, tunaFish, drypers, cabbage, //
    oreoBiscuit, foundation, sunglasses, dumbbells, lipstick, dogFood,
  ];

  /// "My Favorite List" starting content.
  static const List<ProductModel> favorites = [
    oreoBiscuit,
    sulphurfreeBura,
    cauliflower,
    tomato,
    girlGuideBiscuits,
    arnotts,
  ];
}
