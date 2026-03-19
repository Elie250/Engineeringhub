
export default function Home() {
  return (
    <div className="flex flex-col items-center justify-center min-h-screen p-4">
      <h1 className="text-4xl font-bold mb-4">Engineering Hub</h1>
      <p className="text-lg text-slate-600 mb-8">Access management, courses, and engineering tools.</p>
      <div className="flex gap-4">
        <a href="/login" className="px-6 py-2 bg-blue-600 text-white rounded-lg">Login</a>
        <a href="https://github.com" className="px-6 py-2 border border-slate-300 rounded-lg">Documentation</a>
      </div>
    </div>
  )
}
