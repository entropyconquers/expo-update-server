import { use } from "react";
import { redirect } from "next/navigation";

// Required for static export with dynamic routes
export function generateStaticParams() {
  // Return a placeholder param to satisfy static export requirements
  // Real apps will be handled dynamically
  return [{ slug: "example-app" }];
}

interface AppPageProps {
  params: Promise<{
    slug: string;
  }>;
}

export default function AppPage({ params }: AppPageProps) {
  const resolvedParams = use(params);

  // Redirect to the new query parameter approach
  redirect(`/apps?id=${resolvedParams.slug}`);
}
