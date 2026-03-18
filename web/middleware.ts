import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'

export async function middleware(req: NextRequest) {
  // This is a lightweight example guard. Replace with server-side verification using Supabase Admin keys.
  const url = req.nextUrl.clone()

  // Example: block access to /admin for non-admins by checking a cookie (implement robust check)
  if (url.pathname.startsWith('/admin')) {
    const role = req.cookies.get('role')?.value
    if (role !== 'admin') {
      url.pathname = '/403'
      return NextResponse.redirect(url)
    }
  }

  return NextResponse.next()
}

export const config = {
  matcher: ['/admin/:path*', '/instructor/:path*']
}
