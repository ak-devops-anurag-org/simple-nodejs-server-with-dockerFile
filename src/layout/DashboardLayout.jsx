import { Outlet, Link } from "react-router-dom";
import React from "react";

export default function DashboardLayout() {
  return (
    <div className="flex flex-col items-center mt-10">
      <h2 className="text-xl font-bold mb-4">Dashboard Layout</h2>
      {/* Whatever will be in the Dashboard Layout - it will be there in its child component (outlet) */}

       {/* Renders the matching child route */}
      <Outlet />
    </div>
  );
}
