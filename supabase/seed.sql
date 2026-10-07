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
