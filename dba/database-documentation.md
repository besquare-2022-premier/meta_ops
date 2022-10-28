# Database: premier-project
# Schema: premier

## Tables
### 1. user_details
 - loginid (PK) (bigint) - stores customer login id after successful registration
 - fname (text) - stores first name of customers
 - lname (text) - stores last name of customers
 - username (text) - stores the username of customers
 - email (text) - stores customers' registered email
 - pwd (text) - stores customers' account password
 - tel_no (bigint) - stores customers' telephone number
 - address (text) - stores customers' registered address
 - first_join (timestamp) - stores customers' registration timestamp

### 2. category
 - categoryid (PK) (bigint) - stores product category id
 - category_name (text) - stores category name

### 3. product
 - productid (PK) (bigint) - stores product id
 - product_name (text) - stores name of product
 - description (text) - stores the description of product
 - stock (integer) - stores the remaining stock for product
 - price (numeric) - stores the price for product
 - categoryid (FK) (bigint) - references table category (categoryid)

### 4. orders
 - orderid (PK) (bigint) - stores customers' order id
 - loginid (FK) (bigint) - references table user_details (loginid) 
 - ship_address (text) - stores address for product shipping

### 5. order_details
 - orderid (PK, FK) (bigint) - references table orders (orderid)
 - productid (PK, FK) (bigint) - references table product (productid)
 - quantity (integer) - stores customers' quantity of product bought

### 6. transaction
 - transactionid (PK) (bigint) - stores customers' transaction id
 - orderid (FK) (bigint) - references table orders (orderid)
 - loginid (FK) (bigint) - references table user_details (loginid)
 - amount (numeric) - stores the amount paid by customers
 - payment_method (text) - stores the payment method used to pay by customers
