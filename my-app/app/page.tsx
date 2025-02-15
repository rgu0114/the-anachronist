"use client";
import { useState } from 'react';
import Image from "next/image";

export default function Home() {
  const [isExpanding, setIsExpanding] = useState(false);

  const handleClick = (e: React.MouseEvent) => {
    e.preventDefault();
    setIsExpanding(true);
    setTimeout(() => {
      window.location.href = '#begin';
    }, 1000);
  };

  return (
    <div className="relative min-h-screen overflow-hidden">
      {/* Animated gradient background */}
      <div 
        className="absolute inset-0 bg-gradient-to-r from-antiqueBrown/5 via-gold/10 to-antiqueBrown/5 animate-gradient bg-[length:200%_200%]"
        style={{ zIndex: 0 }}
      />
      
      {/* Content */}
      <div className="relative z-10 min-h-screen bg-parchment/90 text-serif flex items-center justify-center">
        <main className="text-center px-6">
          <div className="mb-6">
            <Image
              src="/anachronist-logo.png"
              alt="The Anachronist Logo"
              width={500}
              height={133}
              priority
              className="hover:opacity-90 transition-opacity mx-auto"
            />
          </div>
          
          <h1 className="text-5xl font-baroque mb-6 text-antiqueBrown">
            Journey into the Past, Rediscover the Future
          </h1>
          
          <p className="text-xl max-w-2xl mx-auto mb-12 text-antiqueBrown/90">
            The past is never dead. It's not even past. 
          </p>

          <a
            href="#begin"
            onClick={handleClick}
            className={`
              inline-block px-12 py-4 
              bg-antiqueBrown text-parchment 
              rounded-sm
              transition-all duration-200
              border border-antiqueBrown/20 
              shadow-ornate 
              text-lg
              btn-dive
              backdrop-blur-sm
              ${isExpanding ? 'expanding' : ''}
            `}
          >
            <span>Take the Dive</span>
          </a>
        </main>
      </div>
    </div>
  );
}

const features = [
  {
    title: "Interactive Time Travel",
    description: "Step into meticulously crafted historical environments and experience history firsthand."
  },
  {
    title: "Field Notes System",
    description: "Document your discoveries and insights with our authentic period-inspired journal system."
  },
  {
    title: "Historical Accuracy",
    description: "Every detail is researched and verified by historical experts for an authentic experience."
  }
];
