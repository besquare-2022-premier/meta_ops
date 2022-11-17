# Database: premier_project

# Schema: premier

## Tables

### 1. user_details

- loginid (PK) (serial) - stores customer login id after successful registration
- fname (text) - stores first name of customers
- lname (text) - stores last name of customers
- username (text) - stores the username of customers
- email (text) - stores customers' registered email
- pwd (text) - stores customers' account password
- tel_no (varchar(15)) - stores customers' telephone number
- address (text) - stores customers' registered address
- first_join (timestamp) - stores customers' registration timestamp
- access_field (text) - stores users' access type (user/admin)
- residence (text) - stores customers' country of residence
- gender (text) - stores gender of customers
- birthday (date) - stores customers' birthday

### 2. category

- categoryid (PK) (serial) - stores product category id
- category_name (text) - stores category name

### 3. product

- productid (PK) (serial) - stores product id
- product_name (text) - stores name of product
- description (text) - stores the description of product
- stock (integer) - stores the remaining stock for product
- price (numeric) - stores the price for product
- categoryid (FK) (integer) - references table category (categoryid)
- image (text) - image of product url

### 4. orders

- orderid (PK) (serial) - stores customers' order id
- loginid (FK) (integer) - references table user_details (loginid)
- ship_address (text) - stores address for product shipping
- country (text) - stores the country of shipped product

### 5. order_details

- orderid (PK, FK) (integer) - references table orders (orderid)
- productid (PK, FK) (integer) - references table product (productid)
- quantity (integer) - stores customers' quantity of product bought
- price (numeric) - stores the price of products that customers has to pay

### 6. transaction

- transactionid (PK) (serial) - stores customers' transaction id
- orderid (FK) (integer) - references table orders (orderid)
- loginid (FK) (integer) - references table user_details (loginid)
- amount (numeric) - stores the amount paid by customers
- payment_method (text) - stores the payment method used to pay by customers
- tx_status (text) - stores the customers' transaction status (created,failed,succeeded,cancelled)
- tx_time (timestamp) - time when tx is created
- tx_settled (timestamp) - time when tx is settled (finalized)

### 7. user_data

- loginid (FK) (integer) - references table user_details (loginid)
- items_bought (integer) - stores the number of products bought
- money_spent_myr (numeric) - stores the amount of money spent in MYR

### 8. verification

- verification_email (PK) (text) - stores email that needs verification
- verification_code (varchar(25)) - stores the code to verify email
- epired (timestamp) - stores the expired time for verification code

### 9. product_review

- transactionid (FK) (integer) - references table transaction (transactionid)
- product_rating ('1','2','3','4','5') - stores number of stars for that product
- product_review (text) - stores comment from customers
