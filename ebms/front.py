import tkinter as tk
from tkinter import ttk, messagebox, simpledialog
import requests
from requests.exceptions import RequestException
from datetime import datetime

BASE_URL = "http://127.0.0.1:5000"

root = tk.Tk()
root.title("Electricity Billing System")
root.geometry("800x600")

def check_backend():
    try:
        response = requests.get(f"{BASE_URL}/customers", timeout=5)
        response.raise_for_status()
        return True
    except RequestException:
        messagebox.showerror("Backend Error", "Cannot connect to backend server. Please make sure the backend is running.")
        root.destroy()
        return False

def fetch_customers():
    try:
        response = requests.get(f"{BASE_URL}/customers", timeout=5)
        response.raise_for_status()
        customers = response.json()
        
        customer_list.delete(0, tk.END)
        for cust in customers:
            if isinstance(cust, dict):
                display_text = f"{cust['customer_id']} - {cust['name']}"
            else:
                display_text = f"{cust[0]} - {cust[1]}"
            
            customer_list.insert(tk.END, display_text)
    except Exception as e:
        messagebox.showerror("Error", f"Failed to fetch customers: {str(e)}")

def search_customers():
    query = search_entry.get()
    if not query:
        fetch_customers()  # Reload all if search is empty
        return
    
    try:
        response = requests.get(
            f"{BASE_URL}/customers/search",
            params={"name": query},
            timeout=5
        )
        response.raise_for_status()
        
        customers = response.json()
        
        # Clear the listbox
        customer_list.delete(0, tk.END)
        
        # Handle both tuple and dict responses
        for cust in customers:
            if isinstance(cust, dict):
                # Backend returns dictionaries (correct format)
                display_text = f"{cust['customer_id']} - {cust['name']}"
            else:
                # Backend returns tuples (fallback)
                display_text = f"{cust[0]} - {cust[1]}"
            
            customer_list.insert(tk.END, display_text)
    
    except Exception as e:
        messagebox.showerror("Search Error", f"Failed to search: {str(e)}")

def view_bills():
    selected = customer_list.curselection()
    if not selected:
        messagebox.showwarning("No Selection", "Please select a customer.")
        return
    
    try:
        # Extract customer ID correctly (handles both "ID - Name" and raw ID cases)
        customer_text = customer_list.get(selected[0])
        if " - " in customer_text:
            customer_id = customer_text.split(" - ")[0]
        else:
            customer_id = customer_text
        
        response = requests.get(f"{BASE_URL}/customers/{customer_id}/bills", timeout=5)
        
        if response.status_code != 200:
            messagebox.showerror("Error", f"Backend returned {response.status_code}: {response.text}")
            return
        
        bills = response.json()
        
        # Clear existing rows
        for i in bill_tree.get_children():
            bill_tree.delete(i)
        
        # Insert new rows
        for bill in bills:
            status = bill.get('status', 'Unknown')
            due_date = bill.get('due_date', '')
            
            tree_id = bill_tree.insert('', 'end', values=(
                bill.get('bill_id', ''),
                bill.get('bill_date', ''),
                bill.get('amount', ''),
                due_date,
                status
            ))
            
            # Mark overdue bills
            if bill.get('overdue', False):
                bill_tree.item(tree_id, tags=('overdue',))
        
        bill_tree.tag_configure('overdue', background='tomato')
    
    except Exception as e:
        messagebox.showerror("Error", f"Failed to fetch bills: {str(e)}")

def make_payment():
    selected_item = bill_tree.focus()
    if not selected_item:
        messagebox.showwarning("No Selection", "Select a bill to make payment.")
        return

    try:
        bill_id = bill_tree.item(selected_item)['values'][0]
        response = requests.post(f"{BASE_URL}/pay/{bill_id}", timeout=5)

        if response.status_code != 200:
            error_msg = response.json().get("error", "Payment failed (unknown error)")
            messagebox.showerror("Payment Failed", error_msg)
            return

        resp_json = response.json()
        receipt_url = resp_json.get("receipt_path")
        if receipt_url:
            full_url = f"{BASE_URL}{receipt_url}"
            messagebox.showinfo("Success", f"Payment successful!\nReceipt: {full_url}")
            import webbrowser
            webbrowser.open(full_url)
        else:
            messagebox.showinfo("Success", "Payment successful!")

        view_bills()

    except requests.exceptions.RequestException as e:
        messagebox.showerror("Connection Error", f"Could not connect to server: {str(e)}")
    except Exception as e:
        messagebox.showerror("Error", f"Unexpected error: {str(e)}")


def add_customer():
    name = simpledialog.askstring("New Customer", "Enter customer name:")
    if not name:
        return
    address = simpledialog.askstring("New Customer", "Enter customer address:")
    phone = simpledialog.askstring("New Customer", "Enter customer phone:")

    try:
        payload = {
            "name": name,
            "address": address,
            "phone": phone
        }
        response = requests.post(f"{BASE_URL}/customers/add", json=payload, timeout=5)
        response.raise_for_status()
        if response.status_code == 200:
            messagebox.showinfo("Success", "Customer added successfully!")
            fetch_customers()
        else:
            messagebox.showerror("Error", response.json().get('error', 'Failed to add customer'))
    except RequestException as e:
        messagebox.showerror("Connection Error", "Unable to connect to the server. Please make sure the backend is running.")
    except Exception as e:
        messagebox.showerror("Error", str(e))

# Layout
if check_backend():
    frame_left = tk.Frame(root)
    frame_left.pack(side=tk.LEFT, fill=tk.Y, padx=10, pady=10)

    tk.Label(frame_left, text="Customers").pack()

    search_entry = tk.Entry(frame_left)
    search_entry.pack()
    tk.Button(frame_left, text="Search", command=search_customers).pack(pady=5)

    customer_list = tk.Listbox(frame_left, width=30)
    customer_list.pack()

    btn_frame = tk.Frame(frame_left)
    btn_frame.pack(pady=10)
    tk.Button(btn_frame, text="Load Customers", command=fetch_customers).pack(fill=tk.X, pady=2)
    tk.Button(btn_frame, text="View Bills", command=view_bills).pack(fill=tk.X, pady=2)
    tk.Button(btn_frame, text="Add Customer", command=add_customer).pack(fill=tk.X, pady=2)

    frame_right = tk.Frame(root)
    frame_right.pack(side=tk.RIGHT, fill=tk.BOTH, expand=True, padx=10, pady=10)

    columns = ('Bill ID', 'Date', 'Amount', 'Due Date', 'Status')
    bill_tree = ttk.Treeview(frame_right, columns=columns, show='headings')
    for col in columns:
        bill_tree.heading(col, text=col)
        bill_tree.column(col, width=100)
    bill_tree.pack(fill=tk.BOTH, expand=True)

    tk.Button(frame_right, text="Pay Selected Bill", command=make_payment).pack(pady=10)

    root.mainloop()
