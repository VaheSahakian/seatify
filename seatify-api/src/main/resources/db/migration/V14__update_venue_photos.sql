-- =============================================
-- V14: Replace first venue image with real restaurant photos
-- =============================================

-- For each venue, update the sort_order=0 image to use the real photo.
-- Photos are served from /venues/<slug>.<ext> via Vite public dir.

UPDATE venue_images SET url = '/venues/yasaman.jpg' WHERE venue_id = 'v1' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/de-angelo.jpeg' WHERE venue_id = 'v2' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/mamma-mia.jpg' WHERE venue_id = 'v3' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/twins.jpg' WHERE venue_id = 'v4' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/sirelis.jpg' WHERE venue_id = 'v5' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/dragon-garden.jpg' WHERE venue_id = 'v6' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/bar-bq.jpg' WHERE venue_id = 'v7' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/black-angus.jpg' WHERE venue_id = 'v8' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/cinnabon.jpg' WHERE venue_id = 'v9' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/espress-it.jpg' WHERE venue_id = 'v10' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/intempo.webp' WHERE venue_id = 'v11' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/iykyk.jpg' WHERE venue_id = 'v12' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/kamancha.jpg' WHERE venue_id = 'v13' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/ktoor.jpg' WHERE venue_id = 'v14' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/mao.jpg' WHERE venue_id = 'v15' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/mozzarella.jpg' WHERE venue_id = 'v16' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/patrick-pastry.jpg' WHERE venue_id = 'v17' AND sort_order = 0;
UPDATE venue_images SET url = '/venues/segafredo.jpeg' WHERE venue_id = 'v18' AND sort_order = 0;
