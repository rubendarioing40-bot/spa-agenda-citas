create table public.service_categories (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text not null unique,
  description text,
  sort_order integer not null default 0,
  is_active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint service_categories_slug_format
    check (slug ~ '^[a-z0-9]+(-[a-z0-9]+)*$')
);

create index service_categories_active_sort_idx
on public.service_categories(is_active, sort_order);

create trigger service_categories_set_updated_at
before update on public.service_categories
for each row execute function public.set_updated_at();

alter table public.service_categories enable row level security;

revoke all on public.service_categories from anon, authenticated;
grant select on public.service_categories to anon, authenticated;
grant insert, update on public.service_categories to authenticated;

create policy service_categories_select_public_active
on public.service_categories
for select
to anon, authenticated
using (is_active);

create policy service_categories_select_staff
on public.service_categories
for select
to authenticated
using ((select public.is_staff()));

create policy service_categories_write_manager
on public.service_categories
for all
to authenticated
using ((select public.is_manager()))
with check ((select public.is_manager()));
