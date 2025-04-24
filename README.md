# VoltTrack
Electricity Bill Management System.





# ⚡ Electricity Billing System

A simple electricity billing system built using **Flask (Python backend)**, **Tkinter (Python GUI frontend)**, and a **MySQL database**. This application allows utility companies or administrators to manage customer data, view and pay electricity bills, and generate PDF receipts for payments.

---

## 📝 Table of Contents

- [About the Project](#about-the-project)
- [Features](#features)
- [How It Works](#how-it-works)
- [Screenshots](#screenshots)
- [Getting Started](#getting-started)
- [Database Schema](#database-schema)
- [Future Enhancements](#future-enhancements)
- [License](#license)

---

## 📘 About the Project

The Electricity Billing System is a desktop-based application that streamlines customer and bill management for power distribution companies. It helps manage customer records, track monthly electricity usage, and automate the payment process.

The system is split into two parts:
- A **Tkinter-based GUI** for interacting with the system.
- A **Flask-based REST API** for database operations.

This project is ideal for learning purposes, small-scale deployment, or as a foundation for more complex utility billing systems.

---

## ✨ Features

- ✅ Customer registration and management
- ✅ Search functionality for customers
- ✅ View pending and paid bills
- ✅ Make payments for electricity bills
- ✅ Automatically generate **PDF receipts** on payment
- ✅ Highlight **overdue bills** in the interface

---

## ⚙️ How It Works

### 📌 Workflow:

1. **Frontend (Tkinter GUI):**
   - Displays a list of customers and their bills.
   - Allows searching, viewing, and paying bills.

2. **Backend (Flask REST API):**
   - Serves customer and billing data.
   - Handles payment processing.
   - Generates PDF receipts using `reportlab`.

3. **Database (MySQL):**
   - Stores customer data, bill details, and payment records.

### 🔁 Data Flow:

- User selects a customer → views bills → pays a bill.
- Payment is saved in the database.
- Bill status is updated to "Paid".
- A PDF receipt is generated and accessible via a browser.

---

## 📸 Screenshots

> *(Add screenshots of the Tkinter UI and a sample PDF receipt here once available.)*

---

## 🚀 Getting Started

### 🔧 Requirements

- Python 3.8+
- MySQL Server
- Pip packages: `flask`, `flask-cors`, `requests`, `reportlab`, `mysqlclient`

### 📦 Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/yourusername/electricity-billing-system.git
   cd electricity-billing-system
