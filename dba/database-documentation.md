# Database: premier_project

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
- access_level (text) - stores users' access type (user/admin)
- residence (text) - stores customers' country of residence
- gender (text) - stores gender of customers
- birthday (date) - stores customers' birthday

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
- image (text) - image of product url

### 4. orders

- orderid (PK) (bigint) - stores customers' order id
- loginid (FK) (bigint) - references table user_details (loginid)
- ship_address (text) - stores address for product shipping

### 5. order_details

- orderid (PK, FK) (bigint) - references table orders (orderid)
- productid (PK, FK) (bigint) - references table product (productid)
- quantity (integer) - stores customers' quantity of product bought
- price (numeric) - stores the price of products that customers has to pay

### 6. transaction

- transactionid (PK) (bigint) - stores customers' transaction id
- orderid (FK) (bigint) - references table orders (orderid)
- loginid (FK) (bigint) - references table user_details (loginid)
- amount (numeric) - stores the amount paid by customers
- payment_method (text) - stores the payment method used to pay by customers
- tx_status (text) - stores the customers' transaction status (created,failed,succeeded,cancelled)
- tx_time (timestamp) - time when tx is created
- tx_settled (timestamp) - time when tx is settled (finalized)

### 7. user_data

- loginid (FK) (bigint) - references table user_details (loginid)
- items_bought (integer) - stores the number of products bought
- money_spent_myr (numeric) - stores the amount of money spent in MYR
