-- 1. Create Sellers/Buyers Profiles
CREATE TABLE profiles (
    id UUID REFERENCES auth.users PRIMARY KEY,
    full_name TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    user_type TEXT CHECK (user_type IN ('seller', 'buyer')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Create Product Listings Table
CREATE TABLE products (
    id BIGSERIAL PRIMARY KEY,
    seller_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    price_pgk NUMERIC NOT NULL,
    location TEXT DEFAULT 'Port Moresby',
    image_url TEXT,
    is_available BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 3. Create Orders & Inquiry Table
CREATE TABLE orders (
    id BIGSERIAL PRIMARY KEY,
    product_id BIGINT REFERENCES products(id) ON DELETE CASCADE,
    buyer_id UUID REFERENCES profiles(id),
    buyer_message TEXT,
    payment_status TEXT DEFAULT 'pending_bank_transfer' CHECK (payment_status IN ('pending_bank_transfer', 'verified_paid', 'cancelled')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
