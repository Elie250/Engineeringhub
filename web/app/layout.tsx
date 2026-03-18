import './globals.css'
import React from 'react'

export const metadata = {
  title: 'Engineering Hub',
  description: 'Engineering Hub Platform'
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en">
      <body>
        {children}
      </body>
    </html>
  )
}
