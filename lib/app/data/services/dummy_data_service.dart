import '../models/restaurant.dart';
import '../models/food_item.dart';
import '../models/category.dart';
import '../models/menu_category.dart';

class DummyDataService {
  static List<Category> getCategories() {
    return [
      Category(
        id: '1',
        name: 'Fast Food',
        imageUrl:
            'https://via.placeholder.com/300x200/FF6B6B/FFFFFF?text=Fast+Food',
        iconUrl: '🍔',
        description: 'Quick and delicious meals',
        itemCount: 50,
        isPopular: true,
      ),
      Category(
        id: '2',
        name: 'Pizza',
        imageUrl: 'https://picsum.photos/300/200?random=10',
        iconUrl: '🍕',
        description: 'Hot and cheesy pizzas',
        itemCount: 25,
        isPopular: true,
      ),
      Category(
        id: '3',
        name: 'Chinese',
        imageUrl:
            'https://via.placeholder.com/300x200/FFE66D/FFFFFF?text=Chinese',
        iconUrl: '🥡',
        description: 'Authentic Chinese cuisine',
        itemCount: 35,
        isPopular: false,
      ),
      Category(
        id: '4',
        name: 'Desserts',
        imageUrl:
            'https://via.placeholder.com/300x200/FF8B94/FFFFFF?text=Desserts',
        iconUrl: '🍰',
        description: 'Sweet treats and desserts',
        itemCount: 40,
        isPopular: true,
      ),
      Category(
        id: '5',
        name: 'Healthy',
        imageUrl:
            'https://images.unsplash.com/photo-1490645935967-10de6ba17061',
        iconUrl: '🥗',
        description: 'Nutritious and healthy meals',
        itemCount: 30,
        isPopular: false,
      ),
      Category(
        id: '6',
        name: 'Indian',
        imageUrl:
            'https://images.unsplash.com/photo-1565557623262-b51c2513a641',
        iconUrl: '🍛',
        description: 'Spicy and flavorful Indian food',
        itemCount: 45,
        isPopular: true,
      ),
    ];
  }

  static List<Restaurant> getRestaurants() {
    return [
      Restaurant(
        id: '1',
        name: 'Burger Palace',
        description: 'The best burgers in town with fresh ingredients',
        imageUrl: 'https://picsum.photos/300/200?random=1',
        coverImageUrl: 'https://picsum.photos/600/300?random=1',
        rating: 4.5,
        reviewCount: 250,
        cuisine: 'Fast Food',
        deliveryTime: 25,
        deliveryFee: 2.99,
        isOpen: true,
        address: '123 Food Street, Downtown',
        latitude: 37.7749,
        longitude: -122.4194,
        categories: ['Fast Food', 'Burgers'],
        priceRange: '\$\$',
        isFavorite: false,
        hasDiscount: true,
        discountPercentage: 20,
        menuCategories: _getBurgerPalaceMenu(),
      ),
      Restaurant(
        id: '2',
        name: 'Pizza Corner',
        description: 'Authentic Italian pizzas with wood-fired taste',
        imageUrl: 'https://picsum.photos/300/200?random=2',
        coverImageUrl: 'https://picsum.photos/600/300?random=2',
        rating: 4.7,
        reviewCount: 180,
        cuisine: 'Italian',
        deliveryTime: 30,
        deliveryFee: 3.49,
        isOpen: true,
        address: '456 Pizza Avenue, Little Italy',
        latitude: 37.7849,
        longitude: -122.4094,
        categories: ['Pizza', 'Italian'],
        priceRange: '\$\$',
        isFavorite: true,
        hasDiscount: false,
      ),
      Restaurant(
        id: '3',
        name: 'Dragon House',
        description: 'Traditional Chinese cuisine with modern twist',
        imageUrl:
            'https://images.unsplash.com/photo-1526318896980-cf78c088247c',
        coverImageUrl:
            'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43',
        rating: 4.3,
        reviewCount: 320,
        cuisine: 'Chinese',
        deliveryTime: 35,
        deliveryFee: 2.49,
        isOpen: true,
        address: '789 Dragon Way, Chinatown',
        latitude: 37.7649,
        longitude: -122.4294,
        categories: ['Chinese', 'Asian'],
        priceRange: '\$\$',
        isFavorite: false,
        hasDiscount: false,
      ),
      Restaurant(
        id: '4',
        name: 'Sweet Treats',
        description: 'Delicious desserts and sweet delights',
        imageUrl: 'https://images.unsplash.com/photo-1551024506-0bccd828d307',
        coverImageUrl:
            'https://images.unsplash.com/photo-1578985545062-69928b1d9587',
        rating: 4.6,
        reviewCount: 95,
        cuisine: 'Desserts',
        deliveryTime: 20,
        deliveryFee: 1.99,
        isOpen: true,
        address: '321 Sweet Street, Dessert District',
        latitude: 37.7549,
        longitude: -122.4394,
        categories: ['Desserts', 'Bakery'],
        priceRange: '\$',
        isFavorite: false,
        hasDiscount: true,
        discountPercentage: 15,
      ),
      Restaurant(
        id: '5',
        name: 'Green Garden',
        description: 'Fresh and healthy meals for a better lifestyle',
        imageUrl:
            'https://images.unsplash.com/photo-1490645935967-10de6ba17061',
        coverImageUrl:
            'https://images.unsplash.com/photo-1512621776951-a57141f2eefd',
        rating: 4.4,
        reviewCount: 140,
        cuisine: 'Healthy',
        deliveryTime: 28,
        deliveryFee: 3.99,
        isOpen: true,
        address: '654 Health Avenue, Green District',
        latitude: 37.7449,
        longitude: -122.4494,
        categories: ['Healthy', 'Salads', 'Vegan'],
        priceRange: '\$\$\$',
        isFavorite: true,
        hasDiscount: false,
      ),
      Restaurant(
        id: '6',
        name: 'Spice Palace',
        description: 'Authentic Indian flavors that will spice up your day',
        imageUrl:
            'https://images.unsplash.com/photo-1565557623262-b51c2513a641',
        coverImageUrl:
            'https://images.unsplash.com/photo-1546833999-b9f581a1996d',
        rating: 4.8,
        reviewCount: 210,
        cuisine: 'Indian',
        deliveryTime: 40,
        deliveryFee: 2.79,
        isOpen: true,
        address: '987 Curry Lane, Spice Quarter',
        latitude: 37.7349,
        longitude: -122.4594,
        categories: ['Indian', 'Curry', 'Spicy'],
        priceRange: '\$\$',
        isFavorite: false,
        hasDiscount: false,
      ),
    ];
  }

  static List<FoodItem> getFoodItems(String restaurantId) {
    switch (restaurantId) {
      case '1': // Burger Palace
        return [
          FoodItem(
            id: '1',
            name: 'Classic Beef Burger',
            description:
                'Juicy beef patty with lettuce, tomato, onion, and our special sauce',
            imageUrl:
                'https://images.unsplash.com/photo-1568901346375-23c9450c58cd',
            price: 12.99,
            category: 'Burgers',
            isPopular: true,
            preparationTime: 15,
            rating: 4.6,
            reviewCount: 85,
            ingredients: [
              'Beef patty',
              'Lettuce',
              'Tomato',
              'Onion',
              'Special sauce',
              'Bun'
            ],
            addOns: [
              FoodAddOn(id: '1', name: 'Extra Cheese', price: 1.50),
              FoodAddOn(id: '2', name: 'Bacon', price: 2.00),
              FoodAddOn(id: '3', name: 'Avocado', price: 1.75),
            ],
            variants: [
              FoodVariant(
                  id: '1', name: 'Regular', price: 12.99, size: 'Regular'),
              FoodVariant(id: '2', name: 'Large', price: 15.99, size: 'Large'),
            ],
          ),
          FoodItem(
            id: '2',
            name: 'Chicken Deluxe',
            description:
                'Crispy chicken breast with mayo, lettuce, and pickles',
            imageUrl:
                'https://images.unsplash.com/photo-1606755962773-d324e2dabd39',
            price: 11.99,
            category: 'Burgers',
            preparationTime: 18,
            rating: 4.4,
            reviewCount: 62,
            ingredients: [
              'Chicken breast',
              'Mayo',
              'Lettuce',
              'Pickles',
              'Bun'
            ],
            addOns: [
              FoodAddOn(id: '1', name: 'Extra Cheese', price: 1.50),
              FoodAddOn(id: '4', name: 'Hot Sauce', price: 0.75),
            ],
          ),
          FoodItem(
            id: '3',
            name: 'Crispy Fries',
            description: 'Golden crispy fries seasoned to perfection',
            imageUrl:
                'https://images.unsplash.com/photo-1573080496219-bb080dd4f877',
            price: 4.99,
            category: 'Sides',
            preparationTime: 8,
            rating: 4.3,
            reviewCount: 120,
            ingredients: ['Potatoes', 'Salt', 'Oil'],
            variants: [
              FoodVariant(
                  id: '1', name: 'Regular', price: 4.99, size: 'Regular'),
              FoodVariant(id: '2', name: 'Large', price: 6.99, size: 'Large'),
            ],
          ),
        ];
      case '2': // Pizza Corner
        return [
          FoodItem(
            id: '4',
            name: 'Margherita Pizza',
            description:
                'Classic pizza with fresh mozzarella, tomato sauce, and basil',
            imageUrl:
                'https://images.unsplash.com/photo-1604382355076-af4b0eb60143',
            price: 16.99,
            category: 'Pizza',
            isVegetarian: true,
            isPopular: true,
            preparationTime: 25,
            rating: 4.7,
            reviewCount: 95,
            ingredients: ['Pizza dough', 'Tomato sauce', 'Mozzarella', 'Basil'],
            variants: [
              FoodVariant(
                  id: '1', name: 'Small (10")', price: 14.99, size: 'Small'),
              FoodVariant(
                  id: '2', name: 'Medium (12")', price: 16.99, size: 'Medium'),
              FoodVariant(
                  id: '3', name: 'Large (14")', price: 19.99, size: 'Large'),
            ],
          ),
          FoodItem(
            id: '5',
            name: 'Pepperoni Supreme',
            description: 'Loaded with pepperoni, mozzarella, and Italian herbs',
            imageUrl:
                'https://images.unsplash.com/photo-1628840042765-356cda07504e',
            price: 19.99,
            category: 'Pizza',
            isPopular: true,
            preparationTime: 30,
            rating: 4.8,
            reviewCount: 78,
            ingredients: [
              'Pizza dough',
              'Tomato sauce',
              'Mozzarella',
              'Pepperoni',
              'Italian herbs'
            ],
          ),
        ];
      default:
        return [];
    }
  }

  static List<MenuCategory> _getBurgerPalaceMenu() {
    return [
      MenuCategory(
        id: 'burgers',
        name: 'Burgers',
        description: 'Delicious handcrafted burgers',
        isPopular: true,
        items: getFoodItems('Fast Food').take(3).toList(),
      ),
      MenuCategory(
        id: 'sides',
        name: 'Sides',
        description: 'Crispy sides and appetizers',
        items: [
          FoodItem(
            id: 'fries',
            name: 'Crispy Fries',
            description: 'Golden crispy french fries',
            price: 4.99,
            imageUrl:
                'https://images.unsplash.com/photo-1573080496219-bb080dd4f877',
            category: 'Sides',
            isVegetarian: true,
            rating: 4.2,
            preparationTime: 10,
            variants: [],
            addOns: [],
          ),
        ],
      ),
    ];
  }
}
