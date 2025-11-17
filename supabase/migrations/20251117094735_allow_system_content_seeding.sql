/*
  # Allow System Content Seeding
  
  1. Changes
    - Make user_id nullable in media_content to allow system-seeded content
    - Add system_content flag to distinguish platform content from user content
    - Update policies to allow viewing of system content
  
  2. Security
    - Maintain RLS for user-generated content
    - System content (user_id IS NULL) is publicly viewable
*/

-- Add system_content flag
ALTER TABLE media_content
ADD COLUMN IF NOT EXISTS system_content boolean NOT NULL DEFAULT false;

-- Make user_id nullable for system content
ALTER TABLE media_content
ALTER COLUMN user_id DROP NOT NULL;

-- Update policy to allow system content
DROP POLICY IF EXISTS "Media content viewable by everyone" ON media_content;
CREATE POLICY "Media content viewable by everyone"
  ON media_content FOR SELECT
  USING (true);

DROP POLICY IF EXISTS "Authenticated users can insert media" ON media_content;
CREATE POLICY "Authenticated users can insert media"
  ON media_content FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = user_id OR system_content = true);

DROP POLICY IF EXISTS "Users can update own media" ON media_content;
CREATE POLICY "Users can update own media"
  ON media_content FOR UPDATE
  TO authenticated
  USING (auth.uid() = user_id AND system_content = false)
  WITH CHECK (auth.uid() = user_id AND system_content = false);

DROP POLICY IF EXISTS "Users can delete own media" ON media_content;
CREATE POLICY "Users can delete own media"
  ON media_content FOR DELETE
  TO authenticated
  USING (auth.uid() = user_id AND system_content = false);