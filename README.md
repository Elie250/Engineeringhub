# Engineering Hub - Deployable Repo

This archive contains a minimal deployable template for the Engineering Hub web platform and Supabase migrations to enforce platform access rules.

Contents:
- web/: Next.js app skeleton (App Router) configured for Vercel.
- supabase/: Database migrations and RPC examples for platform RBAC and mobile RPC protection.
- shared/: Shared role helpers.
- env.example: Environment variable template.

Deployment overview:
1. Create a new GitHub repository and push this project.
2. On Vercel, import the GitHub repository and set the environment variables from `.env.example`.
3. Run Supabase migrations: `supabase db push` or run the SQL in `supabase/migrations/03_platform_access.sql` in the Supabase SQL editor.

See `web/README.md` and `supabase/README.md` for details.
