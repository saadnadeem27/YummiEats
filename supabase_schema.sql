-- YummiEats Database Schema for Supabase
-- Run these commands in your Supabase SQL editor

-- Enable necessary extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "postgis";

-- ===========================================
-- USER MANAGEMENT TABLES
-- ===========================================

-- Users table (extends Supabase auth.users)
CREATE TABLE public.users (
    id UUID REFERENCES auth.users(id) PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    phone VARCHAR(20),
    avatar_url TEXT,
    date_of_birth DATE,
    gender VARCHAR(10),
    email_verified BOOLEAN DEFAULT FALSE,
    phone_verified BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- User addresses
CREATE TABLE public.addresses (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
    label VARCHAR(50) NOT NULL, -- 'Home', 'Work', 'Other'
    street_address TEXT NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100) DEFAULT 'US',
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    is_default BOOLEAN DEFAULT FALSE,
    delivery_instructions TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ===========================================
-- RESTAURANT & MENU TABLES
-- ===========================================

-- Categories
CREATE TABLE public.categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    description TEXT,
    icon_url TEXT,
    color_code VARCHAR(7), -- Hex color code
    is_active BOOLEAN DEFAULT TRUE,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Restaurants
CREATE TABLE public.restaurants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    cuisine VARCHAR(100),
    image_url TEXT,
    cover_image_url TEXT,
    rating DECIMAL(3,2) DEFAULT 0.00,
    review_count INTEGER DEFAULT 0,
    delivery_time_min INTEGER, -- minimum delivery time in minutes
    delivery_time_max INTEGER, -- maximum delivery time in minutes
    delivery_fee DECIMAL(10,2) DEFAULT 0.00,
    minimum_order DECIMAL(10,2) DEFAULT 0.00,
    phone VARCHAR(20),
    email VARCHAR(255),
    website TEXT,
    
    -- Address
    street_address TEXT,
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100) DEFAULT 'US',
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    
    -- Business details
    is_active BOOLEAN DEFAULT TRUE,
    is_featured BOOLEAN DEFAULT FALSE,
    is_verified BOOLEAN DEFAULT FALSE,
    opening_hours JSONB, -- Store opening hours
    
    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Restaurant categories (many-to-many)
CREATE TABLE public.restaurant_categories (
    restaurant_id UUID REFERENCES public.restaurants(id) ON DELETE CASCADE,
    category_id UUID REFERENCES public.categories(id) ON DELETE CASCADE,
    PRIMARY KEY (restaurant_id, category_id)
);

-- Menu items
CREATE TABLE public.menu_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    restaurant_id UUID REFERENCES public.restaurants(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(100),
    image_url TEXT,
    
    -- Dietary information
    is_vegetarian BOOLEAN DEFAULT FALSE,
    is_vegan BOOLEAN DEFAULT FALSE,
    is_gluten_free BOOLEAN DEFAULT FALSE,
    is_spicy BOOLEAN DEFAULT FALSE,
    spice_level INTEGER DEFAULT 0, -- 0-5 scale
    
    -- Nutritional info (optional)
    calories INTEGER,
    protein DECIMAL(5,2),
    carbs DECIMAL(5,2),
    fat DECIMAL(5,2),
    
    -- Availability
    is_available BOOLEAN DEFAULT TRUE,
    preparation_time INTEGER, -- in minutes
    
    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Menu item customizations/add-ons
CREATE TABLE public.menu_item_addons (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    menu_item_id UUID REFERENCES public.menu_items(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) DEFAULT 0.00,
    is_required BOOLEAN DEFAULT FALSE,
    max_selections INTEGER DEFAULT 1,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ===========================================
-- ORDER MANAGEMENT TABLES
-- ===========================================

-- Orders
CREATE TABLE public.orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.users(id),
    restaurant_id UUID REFERENCES public.restaurants(id),
    
    -- Pricing
    subtotal DECIMAL(10,2) NOT NULL,
    delivery_fee DECIMAL(10,2) DEFAULT 0.00,
    tax_amount DECIMAL(10,2) DEFAULT 0.00,
    tip_amount DECIMAL(10,2) DEFAULT 0.00,
    discount_amount DECIMAL(10,2) DEFAULT 0.00,
    total_amount DECIMAL(10,2) NOT NULL,
    
    -- Status
    status VARCHAR(50) DEFAULT 'pending', -- pending, confirmed, preparing, ready, delivered, cancelled
    payment_status VARCHAR(50) DEFAULT 'pending', -- pending, paid, failed, refunded
    
    -- Delivery details
    delivery_address JSONB, -- Full address object
    delivery_instructions TEXT,
    estimated_delivery_time TIMESTAMP WITH TIME ZONE,
    actual_delivery_time TIMESTAMP WITH TIME ZONE,
    
    -- Payment
    payment_method VARCHAR(50), -- card, cash, wallet
    payment_id TEXT, -- External payment provider ID
    
    -- Additional info
    special_instructions TEXT,
    cancellation_reason TEXT,
    
    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Order items
CREATE TABLE public.order_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID REFERENCES public.orders(id) ON DELETE CASCADE,
    menu_item_id UUID REFERENCES public.menu_items(id),
    quantity INTEGER NOT NULL DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    special_instructions TEXT,
    addons JSONB, -- Selected addons as JSON
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ===========================================
-- REVIEWS & RATINGS
-- ===========================================

-- Restaurant reviews
CREATE TABLE public.reviews (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.users(id),
    restaurant_id UUID REFERENCES public.restaurants(id),
    order_id UUID REFERENCES public.orders(id),
    
    -- Ratings (1-5 scale)
    overall_rating INTEGER NOT NULL CHECK (overall_rating >= 1 AND overall_rating <= 5),
    food_rating INTEGER CHECK (food_rating >= 1 AND food_rating <= 5),
    service_rating INTEGER CHECK (service_rating >= 1 AND service_rating <= 5),
    delivery_rating INTEGER CHECK (delivery_rating >= 1 AND delivery_rating <= 5),
    
    -- Review content
    title VARCHAR(255),
    comment TEXT,
    images TEXT[], -- Array of image URLs
    
    -- Status
    is_verified BOOLEAN DEFAULT FALSE,
    is_featured BOOLEAN DEFAULT FALSE,
    
    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Constraints
    UNIQUE(user_id, order_id)
);

-- ===========================================
-- USER PREFERENCES & FAVORITES
-- ===========================================

-- User favorites
CREATE TABLE public.favorites (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
    restaurant_id UUID REFERENCES public.restaurants(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, restaurant_id)
);

-- Shopping cart
CREATE TABLE public.cart_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.users(id) ON DELETE CASCADE,
    restaurant_id UUID REFERENCES public.restaurants(id) ON DELETE CASCADE,
    menu_item_id UUID REFERENCES public.menu_items(id) ON DELETE CASCADE,
    quantity INTEGER NOT NULL DEFAULT 1,
    addons JSONB, -- Selected addons as JSON
    special_instructions TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ===========================================
-- NOTIFICATIONS & PROMOTIONS
-- ===========================================

-- Push notifications log
CREATE TABLE public.notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.users(id),
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    type VARCHAR(50), -- order_update, promotion, general
    data JSONB, -- Additional data like order_id, restaurant_id
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Promotions and coupons
CREATE TABLE public.promotions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code VARCHAR(50) UNIQUE NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    discount_type VARCHAR(20) NOT NULL, -- percentage, fixed_amount
    discount_value DECIMAL(10,2) NOT NULL,
    minimum_order DECIMAL(10,2) DEFAULT 0.00,
    maximum_discount DECIMAL(10,2),
    
    -- Validity
    start_date TIMESTAMP WITH TIME ZONE NOT NULL,
    end_date TIMESTAMP WITH TIME ZONE NOT NULL,
    usage_limit INTEGER,
    usage_count INTEGER DEFAULT 0,
    
    -- Targeting
    applicable_restaurants UUID[], -- Array of restaurant IDs
    user_type VARCHAR(20) DEFAULT 'all', -- all, new, returning
    
    -- Status
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- User promotion usage tracking
CREATE TABLE public.user_promotions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES public.users(id),
    promotion_id UUID REFERENCES public.promotions(id),
    order_id UUID REFERENCES public.orders(id),
    used_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, promotion_id, order_id)
);

-- ===========================================
-- DELIVERY & TRACKING
-- ===========================================

-- Delivery tracking
CREATE TABLE public.delivery_tracking (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID REFERENCES public.orders(id) ON DELETE CASCADE,
    driver_name VARCHAR(255),
    driver_phone VARCHAR(20),
    vehicle_type VARCHAR(50),
    vehicle_number VARCHAR(20),
    
    -- Location tracking
    current_latitude DECIMAL(10, 8),
    current_longitude DECIMAL(11, 8),
    estimated_arrival TIMESTAMP WITH TIME ZONE,
    
    -- Status updates
    status VARCHAR(50) DEFAULT 'assigned', -- assigned, picked_up, on_the_way, delivered
    status_updates JSONB, -- Array of status updates with timestamps
    
    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ===========================================
-- INDEXES FOR PERFORMANCE
-- ===========================================

-- User indexes
CREATE INDEX idx_users_email ON public.users(email);
CREATE INDEX idx_users_phone ON public.users(phone);
CREATE INDEX idx_addresses_user_id ON public.addresses(user_id);
CREATE INDEX idx_addresses_default ON public.addresses(user_id, is_default);

-- Restaurant indexes
CREATE INDEX idx_restaurants_rating ON public.restaurants(rating DESC);
CREATE INDEX idx_restaurants_cuisine ON public.restaurants(cuisine);
CREATE INDEX idx_restaurants_active ON public.restaurants(is_active);
CREATE INDEX idx_restaurants_featured ON public.restaurants(is_featured);
CREATE INDEX idx_restaurants_location ON public.restaurants USING GIST(ST_Point(longitude, latitude));

-- Menu indexes
CREATE INDEX idx_menu_items_restaurant ON public.menu_items(restaurant_id);
CREATE INDEX idx_menu_items_category ON public.menu_items(category);
CREATE INDEX idx_menu_items_available ON public.menu_items(is_available);
CREATE INDEX idx_menu_items_price ON public.menu_items(price);

-- Order indexes
CREATE INDEX idx_orders_user ON public.orders(user_id, created_at DESC);
CREATE INDEX idx_orders_restaurant ON public.orders(restaurant_id, created_at DESC);
CREATE INDEX idx_orders_status ON public.orders(status);
CREATE INDEX idx_orders_created_at ON public.orders(created_at DESC);
CREATE INDEX idx_order_items_order ON public.order_items(order_id);

-- Review indexes
CREATE INDEX idx_reviews_restaurant ON public.reviews(restaurant_id, created_at DESC);
CREATE INDEX idx_reviews_user ON public.reviews(user_id);
CREATE INDEX idx_reviews_rating ON public.reviews(overall_rating DESC);

-- Favorite and cart indexes
CREATE INDEX idx_favorites_user ON public.favorites(user_id);
CREATE INDEX idx_cart_user ON public.cart_items(user_id);
CREATE INDEX idx_cart_restaurant ON public.cart_items(user_id, restaurant_id);

-- ===========================================
-- ROW LEVEL SECURITY (RLS)
-- ===========================================

-- Enable RLS on all tables
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.addresses ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.favorites ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.cart_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_promotions ENABLE ROW LEVEL SECURITY;

-- Users can only access their own data
CREATE POLICY "Users can view own profile" ON public.users FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON public.users FOR UPDATE USING (auth.uid() = id);

-- Address policies
CREATE POLICY "Users can manage own addresses" ON public.addresses FOR ALL USING (auth.uid() = user_id);

-- Order policies
CREATE POLICY "Users can view own orders" ON public.orders FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can create orders" ON public.orders FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Order items policies
CREATE POLICY "Users can view own order items" ON public.order_items FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.orders WHERE orders.id = order_items.order_id AND orders.user_id = auth.uid())
);

-- Review policies
CREATE POLICY "Users can manage own reviews" ON public.reviews FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "Anyone can view reviews" ON public.reviews FOR SELECT USING (true);

-- Favorite policies
CREATE POLICY "Users can manage own favorites" ON public.favorites FOR ALL USING (auth.uid() = user_id);

-- Cart policies
CREATE POLICY "Users can manage own cart" ON public.cart_items FOR ALL USING (auth.uid() = user_id);

-- Notification policies
CREATE POLICY "Users can view own notifications" ON public.notifications FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can update own notifications" ON public.notifications FOR UPDATE USING (auth.uid() = user_id);

-- ===========================================
-- FUNCTIONS AND TRIGGERS
-- ===========================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Add triggers for updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON public.users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_restaurants_updated_at BEFORE UPDATE ON public.restaurants FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_menu_items_updated_at BEFORE UPDATE ON public.menu_items FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_orders_updated_at BEFORE UPDATE ON public.orders FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_reviews_updated_at BEFORE UPDATE ON public.reviews FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_cart_items_updated_at BEFORE UPDATE ON public.cart_items FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_delivery_tracking_updated_at BEFORE UPDATE ON public.delivery_tracking FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to update restaurant rating
CREATE OR REPLACE FUNCTION update_restaurant_rating()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE public.restaurants 
    SET 
        rating = (
            SELECT ROUND(AVG(overall_rating)::numeric, 2)
            FROM public.reviews 
            WHERE restaurant_id = COALESCE(NEW.restaurant_id, OLD.restaurant_id)
        ),
        review_count = (
            SELECT COUNT(*)
            FROM public.reviews 
            WHERE restaurant_id = COALESCE(NEW.restaurant_id, OLD.restaurant_id)
        )
    WHERE id = COALESCE(NEW.restaurant_id, OLD.restaurant_id);
    
    RETURN COALESCE(NEW, OLD);
END;
$$ language 'plpgsql';

-- Add trigger for restaurant rating updates
CREATE TRIGGER update_restaurant_rating_trigger 
    AFTER INSERT OR UPDATE OR DELETE ON public.reviews 
    FOR EACH ROW EXECUTE FUNCTION update_restaurant_rating();

-- ===========================================
-- SAMPLE DATA (Optional)
-- ===========================================

-- Insert sample categories
INSERT INTO public.categories (name, description, icon_url, color_code) VALUES
('Pizza', 'Delicious pizzas with various toppings', '🍕', '#FF6B35'),
('Burgers', 'Juicy burgers and sandwiches', '🍔', '#4CAF50'),
('Asian', 'Asian cuisine including Chinese, Japanese, Thai', '🥡', '#2196F3'),
('Italian', 'Authentic Italian dishes', '🍝', '#FF9800'),
('Mexican', 'Spicy Mexican food and tacos', '🌮', '#F44336'),
('Desserts', 'Sweet treats and desserts', '🍰', '#E91E63'),
('Healthy', 'Healthy and organic options', '🥗', '#8BC34A'),
('Fast Food', 'Quick and convenient meals', '🍟', '#FF5722');

-- ===========================================
-- STORAGE BUCKETS
-- ===========================================

-- Create storage buckets for file uploads
INSERT INTO storage.buckets (id, name, public) VALUES 
    ('restaurant-images', 'restaurant-images', true),
    ('menu-images', 'menu-images', true),
    ('user-avatars', 'user-avatars', true),
    ('review-images', 'review-images', true);

-- Storage policies
CREATE POLICY "Public can view restaurant images" ON storage.objects FOR SELECT USING (bucket_id = 'restaurant-images');
CREATE POLICY "Public can view menu images" ON storage.objects FOR SELECT USING (bucket_id = 'menu-images');
CREATE POLICY "Users can upload own avatar" ON storage.objects FOR INSERT WITH CHECK (bucket_id = 'user-avatars' AND auth.uid()::text = (storage.foldername(name))[1]);
CREATE POLICY "Users can view own avatar" ON storage.objects FOR SELECT USING (bucket_id = 'user-avatars' AND auth.uid()::text = (storage.foldername(name))[1]);
CREATE POLICY "Users can upload review images" ON storage.objects FOR INSERT WITH CHECK (bucket_id = 'review-images' AND auth.uid()::text = (storage.foldername(name))[1]);
CREATE POLICY "Public can view review images" ON storage.objects FOR SELECT USING (bucket_id = 'review-images');