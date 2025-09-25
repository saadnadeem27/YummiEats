# 🚀 YummiEats Supabase Setup Guide

This guide will walk you through setting up Supabase backend for the YummiEats application.

## 📋 Prerequisites

- Supabase account ([supabase.com](https://supabase.com))
- YummiEats Flutter project cloned locally

## 🔧 Step-by-Step Setup

### 1. Create Supabase Project

1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Click **"New Project"**
3. Choose your organization
4. Fill in project details:
   - **Project Name**: `yummi-eats`
   - **Database Password**: Generate a strong password (save it!)
   - **Region**: Choose closest to your users
5. Click **"Create new project"**
6. Wait for project initialization (2-3 minutes)

### 2. Configure Database Schema

1. In your Supabase dashboard, go to **SQL Editor**
2. Copy the entire content from `supabase_schema.sql` file
3. Paste it in the SQL editor
4. Click **"Run"** to execute the schema
5. Verify tables are created in **Table Editor**

### 3. Set Up Authentication

1. Go to **Authentication > Settings**
2. Configure **Site URL**: `https://yourapp.com` (or localhost for development)
3. Add **Redirect URLs**:
   - `https://yourapp.com/**` (production)
   - `http://localhost:3000/**` (development)
   - `io.supabase.yummieats://login-callback/` (mobile)

#### Enable OAuth Providers (Optional)

1. Go to **Authentication > Providers**
2. **Enable Google OAuth**:
   - Toggle **Google Enabled**
   - Add your **Google Client ID** and **Client Secret**
   - Get these from [Google Console](https://console.developers.google.com/)

### 4. Configure Storage

Storage buckets are automatically created by the schema. Verify in **Storage**:
- `restaurant-images` - For restaurant photos
- `menu-images` - For food item photos  
- `user-avatars` - For user profile pictures
- `review-images` - For review photos

### 5. Get API Keys

1. Go to **Settings > API**
2. Copy these values:
   - **Project URL**
   - **anon public key**
   - **service_role secret** (keep secure!)

### 6. Configure Flutter App

1. Copy `.env.example` to `.env` in project root:
```bash
cp .env.example .env
```

2. Update `.env` with your Supabase credentials:
```env
SUPABASE_URL=https://your-project-id.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
```

3. Update `lib/app/core/config/supabase_config.dart`:
```dart
class SupabaseConfig {
  static const String supabaseUrl = 'https://your-project-id.supabase.co';
  static const String supabaseAnonKey = 'your-anon-key-here';
  // ... rest of the configuration
}
```

### 7. Install Dependencies

Run in your Flutter project directory:
```bash
flutter pub get
```

### 8. Test Connection

1. Run your Flutter app:
```bash
flutter run
```

2. Try signing up with a test email
3. Check **Authentication > Users** in Supabase dashboard
4. Verify user data appears in **users** table

## 🔐 Security Setup

### Row Level Security (RLS)

RLS is automatically configured by the schema. Key policies:
- Users can only access their own data
- Public read access for restaurants/menus
- Secure order and payment data

### API Security

1. **Never expose service_role key** in client-side code
2. Use **anon key** for client applications
3. Set up **custom claims** for admin users if needed

## 🗄️ Database Management

### Backup Strategy

1. Go to **Settings > Database**
2. Enable **Point in Time Recovery** (recommended)
3. Set up regular backups based on your needs

### Monitoring

1. Go to **Observability** to monitor:
   - Database performance
   - API usage
   - Storage usage
   - Authentication events

## 🚀 Production Deployment

### Environment Configuration

1. Set up separate Supabase projects:
   - **Development**: For testing
   - **Staging**: For pre-production testing
   - **Production**: For live app

2. Use environment variables for different configs:
```dart
// lib/app/core/config/environment.dart
class Environment {
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'your-dev-url'
  );
  
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY', 
    defaultValue: 'your-dev-key'
  );
}
```

### Performance Optimization

1. **Enable connection pooling** in database settings
2. **Set up read replicas** for high traffic
3. **Configure CDN** for storage assets
4. **Monitor query performance** and add indexes as needed

## 🧪 Sample Data

The schema includes sample categories. To add sample restaurants and menu items:

```sql
-- Insert sample restaurants
INSERT INTO restaurants (name, description, cuisine, rating, delivery_time_min, delivery_time_max) VALUES
('Pizza Palace', 'Authentic Italian pizzas', 'Italian', 4.5, 25, 35),
('Burger Hub', 'Gourmet burgers and sides', 'American', 4.3, 15, 25),
('Sushi Master', 'Fresh sushi and Japanese cuisine', 'Japanese', 4.8, 30, 45);

-- Insert sample menu items
INSERT INTO menu_items (restaurant_id, name, price, category) VALUES
((SELECT id FROM restaurants WHERE name = 'Pizza Palace'), 'Margherita Pizza', 12.99, 'Pizza'),
((SELECT id FROM restaurants WHERE name = 'Burger Hub'), 'Classic Cheeseburger', 8.99, 'Burgers');
```

## 🆘 Troubleshooting

### Common Issues

1. **Connection Failed**
   - Verify URL and API keys
   - Check internet connection
   - Ensure Supabase project is active

2. **Authentication Not Working**
   - Check redirect URLs configuration
   - Verify email templates are enabled
   - Check OAuth provider setup

3. **Database Errors**
   - Verify schema was applied correctly
   - Check RLS policies are enabled
   - Review error logs in Supabase dashboard

4. **Storage Upload Failed**
   - Verify bucket policies are correct
   - Check file size limits
   - Ensure proper file types

### Getting Help

1. **Supabase Docs**: [supabase.com/docs](https://supabase.com/docs)
2. **Community**: [Discord](https://discord.supabase.com/)
3. **GitHub Issues**: Report bugs to Supabase team

## 📞 Support

If you encounter issues with this setup:

1. Check the [Supabase Documentation](https://supabase.com/docs)
2. Review error logs in Supabase Dashboard
3. Join the [Supabase Discord](https://discord.supabase.com/) for community help
4. Create an issue in this repository for project-specific problems

---

**Happy Coding! 🚀**