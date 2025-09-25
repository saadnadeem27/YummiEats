# 🍕 YummiEats - Professional Food Delivery App

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-9C27B0?style=for-the-badge&logo=flutter&logoColor=white)
![Material Design](https://img.shields.io/badge/Material%20Design-757575?style=for-the-badge&logo=material-design&logoColor=white)

**A modern, feature-rich food delivery application built with Flutter, featuring beautiful UI/UX design, robust architecture, and seamless user experience.**

[🚀 Features](#-features) • [📱 Screenshots](#-screenshots) • [🏗️ Architecture](#️-architecture) • [🛠️ Installation](#️-installation) • [🔧 Configuration](#-configuration)

</div>

---

## 📋 Table of Contents

- [✨ Features](#-features)
- [📱 Screenshots](#-screenshots)  
- [🏗️ Architecture](#️-architecture)
- [🛠️ Installation](#️-installation)
- [🔧 Configuration](#-configuration)
- [📚 Project Structure](#-project-structure)
- [🎨 UI/UX Design](#-uiux-design)
- [🔐 Authentication](#-authentication)
- [🗄️ Database Schema](#️-database-schema)
- [🚀 Deployment](#-deployment)
- [🧪 Testing](#-testing)
- [📖 API Documentation](#-api-documentation)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)

---

## ✨ Features

### 🎯 **Core Features**
- **🔐 Complete Authentication System** - Sign up, sign in, Google OAuth, password recovery
- **🏠 Advanced Home Dashboard** - Categories, featured restaurants, personalized recommendations
- **🔍 Smart Search & Filters** - Real-time search, category filters, location-based results
- **🛒 Dynamic Shopping Cart** - Add/remove items, quantity management, price calculations
- **❤️ Favorites Management** - Save favorite restaurants and dishes
- **👤 Comprehensive Profile** - User settings, order history, addresses, payment methods
- **📱 Multi-Platform Support** - Android, iOS, Web, Windows, macOS, Linux

### 🚀 **Advanced Features**
- **📍 Location Services** - GPS integration, address management, delivery tracking
- **💳 Payment Integration** - Multiple payment methods, secure transactions
- **⭐ Reviews & Ratings** - Restaurant and food item reviews
- **🔔 Real-time Notifications** - Order updates, promotions, delivery status
- **🌙 Dark/Light Theme** - Adaptive UI with theme switching
- **🌐 Internationalization** - Multi-language support
- **📊 Analytics Integration** - User behavior tracking and insights

### 🎨 **UI/UX Excellence**
- **🎭 Material Design 3** - Latest Material Design guidelines
- **✨ Smooth Animations** - Staggered animations, hero transitions, micro-interactions
- **📱 Responsive Design** - Optimized for all screen sizes and orientations
- **🎨 Beautiful Gradients** - Modern gradient designs and glassmorphism effects
- **🖼️ Optimized Images** - Lazy loading, caching, and error handling
- **♿ Accessibility** - Screen reader support, keyboard navigation, high contrast mode

---

## 📱 Screenshots

<div align="center">

### 📲 Mobile Experience
| Splash Screen | Onboarding | Authentication | Home Dashboard |
|---------------|------------|----------------|----------------|
| ![Splash](assets/screenshots/splash.png) | ![Onboarding](assets/screenshots/onboarding.png) | ![Auth](assets/screenshots/auth.png) | ![Home](assets/screenshots/home.png) |

| Search & Filter | Restaurant Details | Shopping Cart | User Profile |
|-----------------|-------------------|---------------|--------------|
| ![Search](assets/screenshots/search.png) | ![Restaurant](assets/screenshots/restaurant.png) | ![Cart](assets/screenshots/cart.png) | ![Profile](assets/screenshots/profile.png) |

</div>

---

## 🏗️ Architecture

### 🎯 **Clean Architecture Pattern**
```
📦 YummiEats
├── 🎨 Presentation Layer (Views & Controllers)
├── 💼 Business Logic Layer (Use Cases & Services)
├── 🗄️ Data Layer (Models & Data Sources)
└── 🔧 Core Layer (Constants, Themes, Utils)
```

### 🔧 **State Management**
- **GetX Framework** - Reactive state management with dependency injection
- **Reactive Programming** - Observable variables and real-time updates
- **Memory Optimization** - Lazy loading and automatic disposal

### 🗄️ **Backend Integration**
- **Supabase Backend** - PostgreSQL database, real-time subscriptions, authentication
- **RESTful APIs** - Clean API architecture with proper error handling
- **Real-time Updates** - Live order tracking and notifications

---

## 🛠️ Installation

### 📋 **Prerequisites**
```bash
# Required Software
Flutter SDK: >=3.6.0
Dart SDK: >=3.0.0
Android Studio / Xcode (for mobile development)
VS Code (recommended IDE)
```

### 🚀 **Quick Start**
```bash
# 1. Clone the repository
git clone https://github.com/saadnadeem27/YummiEats.git
cd YummiEats

# 2. Install dependencies
flutter pub get

# 3. Generate necessary files
flutter packages pub run build_runner build

# 4. Configure environment variables (see Configuration section)
cp .env.example .env

# 5. Run the application
flutter run
```

### 📱 **Platform-Specific Setup**

#### **Android Setup**
```bash
# Enable developer options and USB debugging
# Install Android SDK and accept licenses
flutter doctor --android-licenses
```

#### **iOS Setup**
```bash
# Install Xcode from App Store
# Install CocoaPods
sudo gem install cocoapods
cd ios && pod install
```

#### **Web Setup**
```bash
# Enable web support
flutter config --enable-web
flutter run -d web-server --web-port=8080
```

---

## 🔧 Configuration

### 🔐 **Environment Variables**
Create a `.env` file in the root directory:

```env
# Supabase Configuration
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key

# Optional API Keys
GOOGLE_MAPS_API_KEY=your_google_maps_api_key
STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
```

### 🗄️ **Supabase Setup**
```sql
-- Create necessary tables (see Database Schema section)
-- Enable Row Level Security (RLS)
-- Set up authentication providers
-- Configure storage buckets for images
```

### 🔑 **Firebase Setup (Optional)**
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Configure Firebase project
firebase login
firebase init
```

---

## 📚 Project Structure

```
lib/
├── 📱 app/
│   ├── 🔧 core/
│   │   ├── 🎨 theme/           # App themes and styling
│   │   ├── 🔧 config/          # App configuration
│   │   ├── 📝 constants/       # App constants
│   │   └── 🛠️ utils/           # Utility functions
│   ├── 📊 data/
│   │   ├── 🏷️ models/          # Data models
│   │   ├── 🔌 services/        # API services
│   │   └── 📋 repositories/    # Data repositories
│   ├── 🎭 modules/
│   │   ├── 🚀 splash/          # Splash screen module
│   │   ├── 📖 onboarding/      # Onboarding module
│   │   ├── 🔐 auth/            # Authentication module
│   │   ├── 🏠 home/            # Home dashboard module
│   │   ├── 🔍 search/          # Search functionality
│   │   ├── 🏪 restaurant/      # Restaurant details
│   │   ├── 🛒 cart/            # Shopping cart
│   │   ├── 📍 tracking/        # Order tracking
│   │   └── 👤 profile/         # User profile
│   └── 🧩 global_widgets/      # Reusable widgets
├── 🎯 main.dart                # App entry point
└── 🔧 firebase_options.dart    # Firebase configuration
```

### 📁 **Module Structure (Example: Home Module)**
```
home/
├── 🎮 controllers/
│   └── home_controller.dart    # Business logic
├── 🎨 views/
│   └── home_view.dart          # UI components
├── 🔗 bindings/
│   └── home_binding.dart       # Dependency injection
└── 🧩 widgets/
    └── custom_widgets.dart     # Module-specific widgets
```

---

## 🎨 UI/UX Design

### 🎭 **Design System**
- **🎨 Color Palette**: Modern orange (#FF6B35) primary with complementary colors
- **📝 Typography**: Roboto font family with proper weight hierarchy
- **📐 Spacing**: 8px grid system for consistent spacing
- **🔄 Animations**: 300ms duration with easeInOut curves
- **🖼️ Icons**: Material Design icons with custom food icons

### 🎯 **Design Principles**
- **📱 Mobile-First**: Optimized for mobile devices with responsive web support
- **♿ Accessibility**: WCAG 2.1 AA compliance
- **🚀 Performance**: 60fps animations and smooth scrolling
- **🔍 Usability**: Intuitive navigation and clear CTAs

### 🎨 **Component Library**
```dart
// Custom Widgets
- CustomButton()          # Reusable button component
- CustomTextField()       # Input field with validation
- CustomCard()           # Consistent card design
- CustomBottomSheet()    # Modal bottom sheets
- LoadingIndicator()     # Loading states
- ErrorWidget()          # Error handling UI
```

---

## 🔐 Authentication

### 🔑 **Authentication Methods**
- **📧 Email/Password**: Traditional authentication with validation
- **🔍 Google OAuth**: One-tap Google sign-in
- **📱 Phone Authentication**: OTP-based phone verification (optional)
- **🔒 Biometric**: Fingerprint/Face ID for quick access

### 🛡️ **Security Features**
- **🔐 JWT Tokens**: Secure token-based authentication
- **🔄 Auto Refresh**: Automatic token renewal
- **🚪 Session Management**: Proper session handling
- **🔒 Secure Storage**: Encrypted local storage

### 📝 **User Flow**
```
Guest User → Sign Up/Sign In → Email Verification → Home Dashboard
           ↓
    Google OAuth → Automatic Sign In → Home Dashboard
```

---

## 🗄️ Database Schema

### 📊 **Supabase Tables**

#### 👤 **Users Table**
```sql
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255),
    phone VARCHAR(20),
    avatar_url TEXT,
    email_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

#### 🏪 **Restaurants Table**
```sql
CREATE TABLE restaurants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    cuisine VARCHAR(100),
    image_url TEXT,
    rating DECIMAL(3,2) DEFAULT 0.00,
    delivery_time INTEGER, -- in minutes
    delivery_fee DECIMAL(10,2),
    minimum_order DECIMAL(10,2),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);
```

#### 🍕 **Menu Items Table**
```sql
CREATE TABLE menu_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    restaurant_id UUID REFERENCES restaurants(id),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(100),
    image_url TEXT,
    is_vegetarian BOOLEAN DEFAULT FALSE,
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT NOW()
);
```

#### 📦 **Orders Table**
```sql
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id),
    restaurant_id UUID REFERENCES restaurants(id),
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    delivery_address TEXT,
    payment_method VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);
```

### 🔄 **Real-time Features**
- **📊 Live Order Tracking**: Real-time status updates
- **🔔 Push Notifications**: Order confirmations and updates
- **📍 Live Location**: Delivery tracking with GPS

---

## 🚀 Deployment

### 📱 **Mobile Deployment**

#### **Android (Google Play Store)**
```bash
# Build release APK
flutter build apk --release

# Build App Bundle (recommended)
flutter build appbundle --release

# Upload to Google Play Console
# Follow Google Play Store guidelines
```

#### **iOS (App Store)**
```bash
# Build iOS release
flutter build ios --release

# Archive in Xcode
# Upload to App Store Connect
# Follow Apple App Store guidelines
```

### 🌐 **Web Deployment**
```bash
# Build web app
flutter build web --release

# Deploy to Firebase Hosting
firebase deploy --only hosting

# Or deploy to Vercel/Netlify
vercel --prod
```

### 🖥️ **Desktop Deployment**
```bash
# Windows
flutter build windows --release

# macOS
flutter build macos --release

# Linux
flutter build linux --release
```

---

## 🧪 Testing

### 🔍 **Testing Strategy**
```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Widget tests
flutter test test/widget_test.dart

# Integration tests
flutter drive --target=test_driver/app.dart
```

### 📊 **Test Coverage**
- **Unit Tests**: Business logic and utility functions
- **Widget Tests**: UI components and interactions  
- **Integration Tests**: Complete user flows
- **Performance Tests**: Memory usage and rendering performance

---

## 📖 API Documentation

### 🔌 **API Endpoints**
```
Authentication:
POST   /auth/signup          # User registration
POST   /auth/signin          # User login
POST   /auth/signout         # User logout
POST   /auth/refresh         # Refresh token

Restaurants:
GET    /restaurants          # Get all restaurants
GET    /restaurants/:id      # Get restaurant details
GET    /restaurants/search   # Search restaurants

Orders:
POST   /orders               # Create new order
GET    /orders/:id           # Get order details
PUT    /orders/:id/status    # Update order status
```

### 📝 **API Response Format**
```json
{
  "success": true,
  "data": { ... },
  "message": "Operation successful",
  "timestamp": "2024-01-01T00:00:00Z"
}
```

---

## 🤝 Contributing

### 🔄 **Development Workflow**
```bash
# 1. Fork the repository
# 2. Create feature branch
git checkout -b feature/amazing-feature

# 3. Make changes and commit
git commit -m "Add amazing feature"

# 4. Push to branch
git push origin feature/amazing-feature

# 5. Create Pull Request
```

### 📋 **Coding Standards**
- **📝 Code Style**: Follow Dart/Flutter conventions
- **🧪 Testing**: Write tests for new features
- **📖 Documentation**: Update documentation for changes
- **🔍 Code Review**: All PRs require review

### 🐛 **Issue Reporting**
- **🐛 Bug Reports**: Use bug report template
- **💡 Feature Requests**: Use feature request template
- **❓ Questions**: Use discussion forum

---

## 👨‍💻 Developer

**Saad Nadeem**
- 🌐 **Portfolio**: [saadnadeem.dev](https://saadnadeem.dev)
- 💼 **LinkedIn**: [linkedin.com/in/saadnadeem27](https://linkedin.com/in/saadnadeem27)
- 🐙 **GitHub**: [@saadnadeem27](https://github.com/saadnadeem27)
- 📧 **Email**: saadnadeem.dev@gmail.com

---

## 🏆 **Technical Highlights**

- ✨ **Clean Architecture** with separation of concerns
- 🚀 **Performance Optimized** with lazy loading and caching
- 🔐 **Security First** approach with encrypted storage
- 📱 **Responsive Design** for all device sizes
- 🌍 **Scalable Backend** with Supabase integration
- 🧪 **Well Tested** with comprehensive test suite
- 📖 **Well Documented** with inline code documentation

---

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**⭐ If you found this project helpful, please give it a star! ⭐**

Made with ❤️ by [Saad Nadeem](https://github.com/saadnadeem27)

</div>
