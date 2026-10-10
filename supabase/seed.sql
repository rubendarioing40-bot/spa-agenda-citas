insert into public.branches (name, slug, address, timezone, is_active)
values ('Sede Principal', 'sede-principal', 'Dirección por definir', 'America/Bogota', true)
on conflict (slug) do nothing;

insert into public.service_categories (name, slug, sort_order, is_active) values
  ('Manicure', 'manicure', 1, true),
  ('Pedicure', 'pedicure', 2, true),
  ('Acrílicas y Gel', 'acrilicas-y-gel', 3, true),
  ('Nail Art', 'nail-art', 4, true),
  ('Combos', 'combos', 5, true)
on conflict (slug) do nothing;

insert into public.services (category_id, name, slug, price, duration_minutes, buffer_minutes, sort_order, is_active)
values
  ((select id from public.service_categories where slug = 'manicure'), 'Manicure semipermanente', 'manicure-semipermanente', 45000, 60, 10, 1, true),
  ((select id from public.service_categories where slug = 'pedicure'), 'Pedicure Spa', 'pedicure-spa', 55000, 75, 10, 2, true),
  ((select id from public.service_categories where slug = 'acrilicas-y-gel'), 'Uñas acrílicas', 'unas-acrilicas', 120000, 120, 15, 3, true),
  ((select id from public.service_categories where slug = 'acrilicas-y-gel'), 'Uñas en gel', 'unas-en-gel', 90000, 90, 10, 4, true),
  ((select id from public.service_categories where slug = 'nail-art'), 'Nail Art básico', 'nail-art-basico', 30000, 45, 5, 5, true)
on conflict (slug) do nothing;
