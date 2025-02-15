"use client";
import Image from "next/image";

export default function Game() {
  return (
    <div className="min-h-screen bg-antiqueBrown p-4 font-mono text-parchment">
      {/* Top Bar */}
      <div className="border border-gold/30 p-3 flex justify-between items-center">
        <Image
          src="/anachronist-logo.png"
          alt="The Anachronist Logo"
          width={200}
          height={53}
          className="invert opacity-80"
        />
        <span className="text-gold/70 text-sm">SYSTEM v1.0.3</span>
      </div>

      {/* Game Window */}
      <div className="my-4 border border-gold/30 aspect-video w-full">
        {/* Godot game will be embedded here */}
      </div>

      {/* Control Panel */}
      <div className="border border-gold/30 p-4 grid gap-4">
        <div className="grid grid-cols-2 gap-4">
          <div className="space-y-2">
            <label className="block text-gold/70 text-sm">LOCATION STATUS</label>
            <input 
              type="text"
              placeholder="Where are you?"
              className="w-full bg-antiqueBrown/50 border border-gold/30 p-2 text-parchment placeholder:text-gold/30"
            />
          </div>
          <div className="space-y-2">
            <label className="block text-gold/70 text-sm">TEMPORAL READING</label>
            <input 
              type="text" 
              readOnly 
              value="18:42:03 / 15.03.1789"
              className="w-full bg-antiqueBrown/50 border border-gold/30 p-2"
            />
          </div>
        </div>
        
        <div className="space-y-2">
          <label className="block text-gold/70 text-sm">SITUATION ANALYSIS</label>
          <textarea 
            placeholder="What's going on?"
            className="w-full h-32 bg-antiqueBrown/50 border border-gold/30 p-2 text-parchment placeholder:text-gold/30"
          />
        </div>
      </div>
    </div>
  );
} 