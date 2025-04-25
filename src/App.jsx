import React from "react";
import { Routes, Route, Navigate } from "react-router-dom";
import Navbar from "./components/Navbar";
import Home from "./components/Home";
import About from "./components/About";
import Profile from "./components/Profile";
import Dashboard from "./components/Dashboard";
import DashboardLayout from "./layout/DashboardLayout";

const isAuth = true;

const ProtectedRoute = ({ children }) => {
  return isAuth ? children : <Navigate to="/profile" replace />;
};

export default function App() {
  return (
    <div className="min-h-screen bg-gray-100">
      <Navbar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
        <Route path="/profile" element={<Profile />} />
        
        <Route
          path="/dashboard/*"
          element={
            <ProtectedRoute>
              <DashboardLayout />
            </ProtectedRoute>
          }
        >
          <Route index element={<Dashboard />} />
        </Route>

        <Route path="*" element={<div className="text-center mt-10">404 Not Found</div>} />
      </Routes>
    </div>
  );
}
