create table public.services (
  id uuid primary key default gen_random_uuid(),
  category_id uuid not null references public.service_categories(id),
  name text not null,
  slug text not null unique,
  description text,
  price numeric(12,2) not null,
  duration_minutes integer not null,
  buffer_minutes integer not null default 0,
  image_url text,
  sort_order integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint services_price_nonnegative check (price >= 0),
  constraint services_duration_positive check (duration_minutes > 0),
  constraint services_buffer_nonnegative check (buffer_minutes >= 0),
  constraint services_slug_format check (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$')
);

create index services_category_idx on public.services(category_id);
create index services_active_sort_idx on public.services(is_active, sort_order);

create trigger services_set_updated_at
before update on public.services
for each row execute function public.set_updated_at();

alter table public.services enable row level security;

revoke all on public.services from anon, authenticated;
grant select on public.services to anon, authenticated;
grant insert, update on public.services to authenticated;

create policy services_select_public_active
on public.services
for select
to anon, authenticated
using (is_active);

create policy services_select_staff
on public.services
for select
to authenticated
using ((select public.is_staff()));

create policy services_write_manager
on public.services
for all
to authenticated
using ((select public.is_manager()))
with check ((select public.is_manager()));
