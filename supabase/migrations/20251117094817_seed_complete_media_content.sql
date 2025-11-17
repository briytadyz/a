/*
  # Seed Complete Media Content
  
  1. Content Added
    - Stream: Unstoppable (Sia), The Journey Home, Midnight in Paris, Living Your Best Life
    - Listen: Afrobeat Dreams, Hip Hop Chronicles, Smooth RnB Vibes, New Talent Showcase
    - Blog: Interviews, Lifestyle, Product Reviews
    - Gallery: Design, Photography, Art, Nature
    - Resources: Templates, Presets, eBooks, Software
  
  2. Notes
    - All content marked as system_content = true
    - Real Pexels image URLs used for thumbnails
    - Realistic view counts, likes, and engagement metrics
*/

-- Insert Stream content
INSERT INTO media_content (title, creator_name, description, thumbnail_url, duration, type, category, content_type, rating, is_premium, views_count, plays_count, likes_count, system_content) VALUES
('Unstoppable', 'Sia', 'Official music video featuring powerful vocals and inspiring visuals', 'https://images.pexels.com/photos/1105666/pexels-photo-1105666.jpeg', '3:37', 'stream', 'music-video', 'video', 4.9, false, 2847000, 1245000, 45230, true),
('The Journey Home', 'Emma Stone', 'A heartwarming documentary about finding your roots', 'https://images.pexels.com/photos/1415131/pexels-photo-1415131.jpeg', '45:22', 'stream', 'documentaries', 'video', 4.7, false, 156000, 89000, 12400, true),
('Midnight in Paris', 'Woody Allen', 'Classic romantic comedy film set in the heart of Paris', 'https://images.pexels.com/photos/2166711/pexels-photo-2166711.jpeg', '1:34:12', 'stream', 'movie', 'video', 4.8, true, 892000, 456000, 34200, true),
('Living Your Best Life', 'Sarah Johnson', 'Lifestyle vlog series about wellness and personal growth', 'https://images.pexels.com/photos/1181406/pexels-photo-1181406.jpeg', '12:45', 'stream', 'lifestyle', 'video', 4.6, false, 234000, 123000, 8900, true)
ON CONFLICT DO NOTHING;

-- Insert Listen content
INSERT INTO media_content (title, creator_name, description, thumbnail_url, duration, type, category, content_type, rating, is_premium, plays_count, likes_count, system_content) VALUES
('Afrobeat Dreams', 'Burna Boy', 'Latest Afrobeat hit taking the world by storm', 'https://images.pexels.com/photos/1763075/pexels-photo-1763075.jpeg', '3:45', 'listen', 'Afrobeat', 'audio', 4.9, false, 567000, 23400, true),
('Hip Hop Chronicles', 'DJ Khaled', 'Classic hip hop mixtape featuring top artists', 'https://images.pexels.com/photos/1449844/pexels-photo-1449844.jpeg', '45:30', 'listen', 'hip-hop', 'audio', 4.8, false, 345000, 18900, true),
('Smooth RnB Vibes', 'Alicia Keys', 'Soulful RnB collection for late night listening', 'https://images.pexels.com/photos/1540406/pexels-photo-1540406.jpeg', '38:22', 'listen', 'RnB', 'audio', 4.7, true, 289000, 15600, true),
('New Talent Showcase', 'Various Artists', 'Discover the next generation of musical talent', 'https://images.pexels.com/photos/1190297/pexels-photo-1190297.jpeg', '52:15', 'listen', 'new-talent', 'audio', 4.5, false, 123000, 9800, true),
('Greatest Hits Collection', 'Legends', 'Timeless classics from the greatest artists', 'https://images.pexels.com/photos/210922/pexels-photo-210922.jpeg', '1:15:30', 'listen', 'greatest-of-all-time', 'audio', 4.9, false, 789000, 34500, true),
('Latest Release 2024', 'Top Charts', 'Fresh tracks from this year''s hottest releases', 'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg', '42:18', 'listen', 'latest-release', 'audio', 4.6, false, 234000, 12300, true),
('DJ Summer Mixtape', 'DJ Supreme', 'Perfect mix for summer parties and good vibes', 'https://images.pexels.com/photos/1047442/pexels-photo-1047442.jpeg', '1:05:45', 'listen', 'DJ-mixtapes', 'audio', 4.8, false, 445000, 21200, true),
('Uganda Unscripted Vol 1', 'Local Voices', 'Authentic Ugandan stories and sounds', 'https://images.pexels.com/photos/1864642/pexels-photo-1864642.jpeg', '35:20', 'listen', 'UG-Unscripted', 'audio', 4.7, false, 98000, 7800, true)
ON CONFLICT DO NOTHING;

-- Insert Blog content
INSERT INTO media_content (title, creator_name, description, thumbnail_url, read_time, type, category, content_type, rating, views_count, likes_count, system_content) VALUES
('Interview with Rising Star', 'Music Weekly', 'Exclusive interview with breakthrough artist of the year', 'https://images.pexels.com/photos/1181676/pexels-photo-1181676.jpeg', '8 min read', 'blog', 'interviews', 'blog', 4.6, 45000, 3400, true),
('Top 10 Lifestyle Trends 2024', 'Lifestyle Magazine', 'The biggest lifestyle trends shaping this year', 'https://images.pexels.com/photos/1181467/pexels-photo-1181467.jpeg', '6 min read', 'blog', 'lifestyle', 'blog', 4.5, 32000, 2100, true),
('Camera Gear Review 2024', 'Tech Reviews', 'Comprehensive review of the latest camera equipment', 'https://images.pexels.com/photos/51383/photo-camera-subject-photographer-51383.jpeg', '12 min read', 'blog', 'product-reviews', 'blog', 4.7, 28000, 1890, true),
('Behind the Scenes: Music Production', 'Studio Insider', 'An intimate look at the music creation process', 'https://images.pexels.com/photos/164821/pexels-photo-164821.jpeg', '10 min read', 'blog', 'interviews', 'blog', 4.8, 38000, 2890, true),
('Travel Lifestyle Guide', 'Wanderlust', 'Living your best life while traveling the world', 'https://images.pexels.com/photos/346885/pexels-photo-346885.jpeg', '7 min read', 'blog', 'lifestyle', 'blog', 4.4, 21000, 1560, true)
ON CONFLICT DO NOTHING;

-- Insert Gallery content
INSERT INTO media_content (title, creator_name, description, thumbnail_url, type, category, content_type, rating, is_premium, views_count, likes_count, system_content) VALUES
('Modern Minimalist Design', 'Jane Cooper', 'Clean and elegant design portfolio showcasing minimalist aesthetics', 'https://images.pexels.com/photos/1571460/pexels-photo-1571460.jpeg', 'gallery', 'design', 'image', 4.8, false, 23400, 2340, true),
('Urban Photography Collection', 'Michael Chen', 'Stunning urban landscapes and street photography', 'https://images.pexels.com/photos/1486222/pexels-photo-1486222.jpeg', 'gallery', 'photography', 'image', 4.9, true, 34500, 4120, true),
('Abstract Art Series', 'Lisa Martinez', 'Bold and colorful abstract art exploration', 'https://images.pexels.com/photos/1568607/pexels-photo-1568607.jpeg', 'gallery', 'art', 'image', 4.7, false, 18900, 1560, true),
('Nature Photography', 'David Park', 'Breathtaking nature and wildlife photography', 'https://images.pexels.com/photos/1287145/pexels-photo-1287145.jpeg', 'gallery', 'photography', 'image', 4.8, false, 28700, 3210, true),
('Graphic Design Portfolio', 'Creative Minds', 'Innovative graphic design and branding work', 'https://images.pexels.com/photos/196645/pexels-photo-196645.jpeg', 'gallery', 'design', 'image', 4.6, false, 19800, 1890, true),
('Portrait Photography', 'Studio Art', 'Professional portrait photography collection', 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg', 'gallery', 'photography', 'image', 4.9, true, 42100, 5230, true)
ON CONFLICT DO NOTHING;

-- Insert Resources content
INSERT INTO media_content (title, creator_name, description, thumbnail_url, type, category, content_type, price, rating, is_premium, sales_count, likes_count, system_content) VALUES
('Web Design Template Pack', 'Creative Studio', 'Professional web design templates for modern websites', 'https://images.pexels.com/photos/196644/pexels-photo-196644.jpeg', 'resources', 'templates', 'file', 49000, 4.9, true, 234, 890, true),
('Photography Presets Bundle', 'Photo Pro', 'Premium Lightroom presets for professional photography', 'https://images.pexels.com/photos/1029757/pexels-photo-1029757.jpeg', 'resources', 'presets', 'file', 35000, 4.8, true, 456, 1234, true),
('Digital Marketing eBook', 'Marketing Guru', 'Complete guide to digital marketing strategies', 'https://images.pexels.com/photos/267350/pexels-photo-267350.jpeg', 'resources', 'ebooks', 'file', 25000, 4.7, false, 678, 567, true),
('Video Editing Software', 'Tech Solutions', 'Professional video editing software suite', 'https://images.pexels.com/photos/257904/pexels-photo-257904.jpeg', 'resources', 'software', 'file', 89000, 4.9, true, 123, 789, true),
('UI/UX Design Templates', 'Design Pro', 'Modern UI/UX templates for web and mobile', 'https://images.pexels.com/photos/326514/pexels-photo-326514.jpeg', 'resources', 'templates', 'file', 42000, 4.8, true, 345, 678, true),
('Social Media Graphics Pack', 'Social Studio', 'Ready-to-use social media templates and graphics', 'https://images.pexels.com/photos/267350/pexels-photo-267350.jpeg', 'resources', 'templates', 'file', 28000, 4.6, false, 567, 456, true),
('Audio Production eBook', 'Sound Masters', 'Master audio production techniques', 'https://images.pexels.com/photos/164938/pexels-photo-164938.jpeg', 'resources', 'ebooks', 'file', 32000, 4.7, false, 234, 345, true),
('Color Grading Presets', 'Film Look', 'Professional color grading presets for video', 'https://images.pexels.com/photos/1181467/pexels-photo-1181467.jpeg', 'resources', 'presets', 'file', 38000, 4.9, true, 189, 567, true)
ON CONFLICT DO NOTHING;