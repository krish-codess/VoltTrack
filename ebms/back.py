from flask import Flask, request, jsonify, send_from_directory
from flask_cors import CORS
import MySQLdb
from datetime import datetime
from reportlab.lib.pagesizes import LETTER
from reportlab.pdfgen import canvas
import os

app = Flask(__name__)
CORS(app)

# Database Connection
conn = MySQLdb.connect(
    host="localhost",
    user="root",
    password="Krish123.",
    database="electricity_billings"
)
cursor = conn.cursor()

# PDF generation helper
def generate_pdf_receipt(bill_id, amount, customer_name):
    file_path = f"receipts/receipt_{bill_id}.pdf"
    os.makedirs("receipts", exist_ok=True)
    c = canvas.Canvas(file_path, pagesize=LETTER)
    c.drawString(100, 750, "Electricity Billing System")
    c.drawString(100, 730, f"Receipt for Bill ID: {bill_id}")
    c.drawString(100, 710, f"Customer: {customer_name}")
    c.drawString(100, 690, f"Amount Paid: ₹{amount}")
    c.drawString(100, 670, f"Date: {datetime.today().strftime('%Y-%m-%d')}")
    c.save()
    return file_path

# --- API Endpoints ---

@app.route('/customers', methods=['GET'])
def get_customers():
    cursor.execute("SELECT customer_id, name FROM customers")
    customers = cursor.fetchall()
    return jsonify(customers)

@app.route('/customers/<int:customer_id>/bills', methods=['GET'])
def get_bills(customer_id):
    try:
        cursor.execute("""
            SELECT bill_id, bill_date, amount, due_date, status 
            FROM Bills 
            WHERE customer_id = %s
        """, (customer_id,))
        
        columns = [col[0] for col in cursor.description]
        bills = [dict(zip(columns, row)) for row in cursor.fetchall()]
        
        today = datetime.today().date()
        for bill in bills:
            due_date = bill['due_date']
            bill['overdue'] = due_date < today and bill['status'].lower() != 'paid'
        
        return jsonify(bills)
    
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/pay/<int:bill_id>', methods=['POST'])
def pay_bill(bill_id):
    try:
        cursor.execute("SELECT amount, status FROM bills WHERE bill_id = %s", (bill_id,))
        bill = cursor.fetchone()
        
        if not bill:
            return jsonify({"error": "Bill not found"}), 404
        
        bill_amount = bill[0]
        bill_status = bill[1]
        
        if bill_status.lower() == 'paid':
            return jsonify({"error": "Bill is already paid"}), 400

        cursor.execute("""
            INSERT INTO Payments (bill_id, payment_date, payment_mode, amount_paid, payment_status)
            VALUES (%s, CURDATE(), 'Cash', %s, 'Successful')
        """, (bill_id, bill_amount))

        cursor.execute("UPDATE bills SET status = 'Paid' WHERE bill_id = %s", (bill_id,))
        conn.commit()

        # Get customer name for the receipt
        cursor.execute("""
            SELECT c.name FROM customers c
            JOIN bills b ON c.customer_id = b.customer_id
            WHERE b.bill_id = %s
        """, (bill_id,))
        customer_row = cursor.fetchone()
        customer_name = customer_row[0] if customer_row else "Unknown"

        pdf_path = generate_pdf_receipt(bill_id, bill_amount, customer_name)

        return jsonify({
            "message": "Payment successful",
            "receipt_path": f"/receipt/{os.path.basename(pdf_path)}"
        })

    except Exception as e:
        conn.rollback()
        return jsonify({"error": str(e)}), 500

@app.route('/receipt/<filename>')
def get_receipt(filename):
    return send_from_directory('receipts', filename)

@app.route('/customers/search', methods=['GET'])
def search_customer():
    name_query = request.args.get('name', '')
    try:
        cursor.execute("""
            SELECT customer_id, name 
            FROM customers 
            WHERE name LIKE %s
        """, (f"%{name_query}%",))
        columns = [col[0] for col in cursor.description]
        results = [dict(zip(columns, row)) for row in cursor.fetchall()]
        return jsonify(results)
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@app.route('/customers/add', methods=['POST'])
def add_customer():
    data = request.json
    name = data.get('name')
    address = data.get('address')
    phone = data.get('phone')

    try:
        cursor.execute("""
            INSERT INTO customers (name, address, phone)
            VALUES (%s, %s, %s)
        """, (name, address, phone))
        conn.commit()
        return jsonify({'message': 'Customer added successfully'})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
