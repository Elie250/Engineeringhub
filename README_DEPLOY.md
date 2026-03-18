Deployment Steps (GitHub -> Vercel & Supabase)

1. Create a GitHub repository and push this project's files.
2. Vercel (Web):
   - Import the GitHub repository into Vercel.
   - Set env variables from `.env.example` in the Vercel project settings.
   - Trigger a deploy; Vercel will build the `web` app.
3. Supabase:
   - Create a Supabase project and copy the `SUPABASE_URL` and `SUPABASE_ANON_KEY` and `SUPABASE_SERVICE_ROLE_KEY` into your environment variables.
   - In the Supabase SQL editor, run `supabase/migrations/03_platform_access.sql` and `supabase/functions/rpc_mobile_process_sale.sql`.
4. Test roles:
   - Create test users with roles: admin, instructor, student, sales.
   - Verify web and mobile access per Platform Access Rules.
