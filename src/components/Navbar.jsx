import React from "react";
import { NavLink } from "react-router-dom";

export default function Navbar() {
  return (
    <nav className="bg-white shadow p-4 flex gap-6 justify-center text-lg">
      <NavLink to="/" className={({ isActive }) => isActive ? "text-blue-600 font-bold" : ""}>Home</NavLink>
      <NavLink to="/about" className={({ isActive }) => isActive ? "text-blue-600 font-bold" : ""}>About</NavLink>
      <NavLink to="/dashboard" className={({ isActive }) => isActive ? "text-blue-600 font-bold" : ""}>Dashboard</NavLink>
      <NavLink to="/profile" className={({ isActive }) => isActive ? "text-blue-600 font-bold" : ""}>Profile</NavLink>
    </nav>
  );
}

