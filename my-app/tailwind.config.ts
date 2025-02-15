import type { Config } from "tailwindcss";

export default {
  content: [
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        background: "var(--background)",
        foreground: "var(--foreground)",
        parchment: "var(--color-parchment)",
        antiqueBrown: "var(--color-antique-brown)",
        gold: "var(--color-gold)",
      },
    },
  },
  plugins: [],
} satisfies Config;
