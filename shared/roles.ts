export const UserRoles = {
  ADMIN: 'admin',
  INSTRUCTOR: 'instructor',
  STUDENT: 'student',
  SALES: 'sales',
} as const;

export function canAccessPlatform(role: string | null | undefined, platform: 'web' | 'mobile') {
  if (!role) return false;
  if (role === UserRoles.ADMIN || role === UserRoles.INSTRUCTOR) return platform === 'web';
  if (role === UserRoles.STUDENT || role === UserRoles.SALES) return true;
  return false;
}
