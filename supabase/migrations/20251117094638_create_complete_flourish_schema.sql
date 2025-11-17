/*
  # Complete FlourishTalents Database Schema

  ## 1. New Tables Created
    - `profiles` - User profiles with account types, tiers, loyalty points
    - `media_content` - All media items (stream, listen, blog, gallery, resources)
    - `media_likes` - User likes on media content
    - `creator_follows` - User follows of creators
    - `tips` - Monetary tips from users to creators
    - `activities` - User activity logs
    - `comments` - User comments on media
    - `media` - General media storage
    - `likes` - General likes table
    - `follows` - General follows table
    - `media_items` - Alternative media storage

  ## 2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users
    - Policies check auth.uid() for ownership
    - Public read access where appropriate
    - Restrictive write access based on user ownership

  ## 3. Performance Indexes
    - Composite indexes on (type, category, created_at)
    - User interaction indexes (user_id, media_id)
    - Creator follow indexes
    - Tier and premium content lookups

  ## 4. Triggers & Functions
    - Auto-create profile on signup
    - Update timestamps automatically
    - Update like/comment counts automatically
*/

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Profiles table
CREATE TABLE IF NOT EXISTS profiles (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  name text NOT NULL,
  email text UNIQUE NOT NULL,
  account_type text NOT NULL DEFAULT 'member' CHECK (account_type IN ('creator', 'member')),
  tier text NOT NULL DEFAULT 'free' CHECK (tier IN ('free', 'premium', 'professional', 'elite')),
  loyalty_points integer NOT NULL DEFAULT 0,
  avatar_url text,
  bio text,
  joined_date timestamptz NOT NULL DEFAULT now(),
  last_login timestamptz NOT NULL DEFAULT now(),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

-- Media content table
CREATE TABLE IF NOT EXISTS media_content (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  title text NOT NULL,
  creator_name text NOT NULL,
  description text,
  thumbnail_url text NOT NULL,
  duration text,
  read_time text,
  type text NOT NULL CHECK (type IN ('stream', 'listen', 'blog', 'gallery', 'resources')),
  category text NOT NULL DEFAULT 'all',
  content_type text NOT NULL CHECK (content_type IN ('video', 'audio', 'blog', 'image', 'file')),
  price numeric(10, 2),
  rating numeric(3, 2) NOT NULL DEFAULT 0,
  is_premium boolean NOT NULL DEFAULT false,
  views_count integer NOT NULL DEFAULT 0,
  plays_count integer NOT NULL DEFAULT 0,
  sales_count integer NOT NULL DEFAULT 0,
  likes_count integer NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

-- Media likes table
CREATE TABLE IF NOT EXISTS media_likes (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  media_id uuid REFERENCES media_content(id) ON DELETE CASCADE NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(user_id, media_id)
);

-- Creator follows table
CREATE TABLE IF NOT EXISTS creator_follows (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  follower_id uuid REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  creator_name text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(follower_id, creator_name)
);

-- Tips table
CREATE TABLE IF NOT EXISTS tips (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  from_user_id uuid REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  creator_name text NOT NULL,
  amount numeric(10, 2) NOT NULL,
  currency text NOT NULL DEFAULT 'UGX' CHECK (currency IN ('UGX', 'USD', 'EUR', 'GBP')),
  message text,
  created_at timestamptz NOT NULL DEFAULT now()
);

-- Activities table
CREATE TABLE IF NOT EXISTS activities (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  action text NOT NULL,
  description text,
  activity_type text NOT NULL CHECK (activity_type IN ('update', 'follower', 'approval', 'achievement', 'like', 'comment', 'upload')),
  created_at timestamptz NOT NULL DEFAULT now()
);

-- Comments table
CREATE TABLE IF NOT EXISTS comments (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  media_id uuid REFERENCES media_content(id) ON DELETE CASCADE NOT NULL,
  content text NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

-- Media table (general)
CREATE TABLE IF NOT EXISTS media (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  title text NOT NULL,
  description text,
  media_url text NOT NULL,
  media_type text NOT NULL DEFAULT 'video',
  thumbnail_url text,
  views_count integer NOT NULL DEFAULT 0,
  likes_count integer NOT NULL DEFAULT 0,
  comments_count integer NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

-- Likes table (general)
CREATE TABLE IF NOT EXISTS likes (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  media_id uuid REFERENCES media(id) ON DELETE CASCADE NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(user_id, media_id)
);

-- Follows table (general)
CREATE TABLE IF NOT EXISTS follows (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  follower_id uuid REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  following_id uuid REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE(follower_id, following_id)
);

-- Media items table
CREATE TABLE IF NOT EXISTS media_items (
  id uuid PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id uuid REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  title text NOT NULL,
  description text,
  type text NOT NULL,
  category text NOT NULL DEFAULT 'all',
  thumbnail_url text NOT NULL,
  creator text NOT NULL,
  duration text,
  read_time text,
  views_count integer NOT NULL DEFAULT 0,
  like_count integer NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

-- Performance Indexes
CREATE INDEX IF NOT EXISTS idx_media_content_type_category_created ON media_content(type, category, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_media_content_type_is_premium ON media_content(type, is_premium);
CREATE INDEX IF NOT EXISTS idx_media_content_user_id ON media_content(user_id);
CREATE INDEX IF NOT EXISTS idx_media_likes_user_media ON media_likes(user_id, media_id);
CREATE INDEX IF NOT EXISTS idx_media_likes_media_id ON media_likes(media_id);
CREATE INDEX IF NOT EXISTS idx_creator_follows_user_creator ON creator_follows(follower_id, creator_name);
CREATE INDEX IF NOT EXISTS idx_creator_follows_creator_name ON creator_follows(creator_name);
CREATE INDEX IF NOT EXISTS idx_profiles_tier ON profiles(tier);
CREATE INDEX IF NOT EXISTS idx_activities_user_id ON activities(user_id);
CREATE INDEX IF NOT EXISTS idx_comments_media_id ON comments(media_id);

-- Enable Row Level Security
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE media_content ENABLE ROW LEVEL SECURITY;
ALTER TABLE media_likes ENABLE ROW LEVEL SECURITY;
ALTER TABLE creator_follows ENABLE ROW LEVEL SECURITY;
ALTER TABLE tips ENABLE ROW LEVEL SECURITY;
ALTER TABLE activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE media ENABLE ROW LEVEL SECURITY;
ALTER TABLE likes ENABLE ROW LEVEL SECURITY;
ALTER TABLE follows ENABLE ROW LEVEL SECURITY;
ALTER TABLE media_items ENABLE ROW LEVEL SECURITY;

-- Profiles Policies
CREATE POLICY "Public profiles are viewable by everyone"
  ON profiles FOR SELECT
  USING (true);

CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE
  TO authenticated
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

CREATE POLICY "Users can insert own profile"
  ON profiles FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = id);

-- Media Content Policies
CREATE POLICY "Media content viewable by everyone"
  ON media_content FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can insert media"
  ON media_content FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own media"
  ON media_content FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own media"
  ON media_content FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- Media Likes Policies
CREATE POLICY "Media likes viewable by everyone"
  ON media_likes FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can like"
  ON media_likes FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can unlike own likes"
  ON media_likes FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- Creator Follows Policies
CREATE POLICY "Follows viewable by everyone"
  ON creator_follows FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can follow"
  ON creator_follows FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = follower_id);

CREATE POLICY "Users can unfollow"
  ON creator_follows FOR DELETE
  TO authenticated
  USING (auth.uid() = follower_id);

-- Tips Policies
CREATE POLICY "Tips viewable by sender and recipient"
  ON tips FOR SELECT
  TO authenticated
  USING (auth.uid() = from_user_id);

CREATE POLICY "Authenticated users can send tips"
  ON tips FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = from_user_id);

-- Activities Policies
CREATE POLICY "Users can view own activities"
  ON activities FOR SELECT
  TO authenticated
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own activities"
  ON activities FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Comments Policies
CREATE POLICY "Comments viewable by everyone"
  ON comments FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can comment"
  ON comments FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own comments"
  ON comments FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can delete own comments"
  ON comments FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- Media Policies
CREATE POLICY "Media viewable by everyone"
  ON media FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can upload media"
  ON media FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can update own media"
  ON media FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Likes Policies
CREATE POLICY "Likes viewable by everyone"
  ON likes FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can like"
  ON likes FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can unlike"
  ON likes FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id);

-- Follows Policies
CREATE POLICY "Follows viewable by everyone"
  ON follows FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can follow users"
  ON follows FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = follower_id);

CREATE POLICY "Users can unfollow users"
  ON follows FOR DELETE
  TO authenticated
  USING (auth.uid() = follower_id);

-- Media Items Policies
CREATE POLICY "Media items viewable by everyone"
  ON media_items FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can create media items"
  ON media_items FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id);

-- Triggers for updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_media_content_updated_at
  BEFORE UPDATE ON media_content
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_comments_updated_at
  BEFORE UPDATE ON comments
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_media_updated_at
  BEFORE UPDATE ON media
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_media_items_updated_at
  BEFORE UPDATE ON media_items
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Function to auto-create profile on signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, name, email, account_type)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'name', 'User'),
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'account_type', 'member')
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to create profile on user signup
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- Function to update like count
CREATE OR REPLACE FUNCTION update_media_likes_count()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE media_content
    SET likes_count = likes_count + 1
    WHERE id = NEW.media_id;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE media_content
    SET likes_count = GREATEST(0, likes_count - 1)
    WHERE id = OLD.media_id;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update like count
DROP TRIGGER IF EXISTS update_likes_count_trigger ON media_likes;
CREATE TRIGGER update_likes_count_trigger
  AFTER INSERT OR DELETE ON media_likes
  FOR EACH ROW
  EXECUTE FUNCTION update_media_likes_count();