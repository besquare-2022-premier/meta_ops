# Orders API

This page contain the information about the orders access and manipulation endpoints. The base URL for this API is `/api/v1/orders`. All the APIs in this section is _authenticated_.

## The schema for the orders

```json
{
  "order_id": 123,
  "time": "time",
  "transaction_id": 123,
  "transaction_status": "success",
  "total_amount": 1234
}
```

## Past Orders API

This group of API is intended for the users to access their past orders. This API is _paginated_.

<table>
<tr><th>Method</th><th>Endpoint</th><th>Description</th></tr>
<tbody>
<tr>
<td>

`GET`

</td><td>

`/`

</td>
<td>

**Obtain a summary for all orders made by the user**  
Payload: none

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted when the request is succeeded
</td>
</tr>
<tr>
<td>401</td>
<td>Unauthorized request (missing or invalid Access Token)

Example:

```json
{
  "status": 203,
  "message": "Invalid access token"
}
```

</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>

`GET`

</td><td>

`/:order-id`

</td>
<td>

**Get the detailed information of the orders by ID**  
Payload: none

URL parameters:

| Parameter  | Description                |
| ---------- | -------------------------- |
| `order-id` | The ID of the order to get |

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted when the request is succeeded

Example:

```json
{
  "order_id": 123,
  "time": "time",
  "products": [
    {
      "product": "id",
      "product_name": "",
      "quantity": 200,
      "image": ""
    }
  ],
  "total_value": 10000,
  "transaction_id": 123,
  "transaction_status": "success"
}
```

</td>
</tr>
<tr>
<td>401</td>
<td>Unauthorized request (missing or invalid Access Token)

Example:

```json
{
  "status": 203,
  "message": "Invalid access token"
}
```

</td>
</tr>
<tr>
<td>404</td>
<td>The order is not found

Example:

```json
{
  "status": 104,
  "message": "The order does not exists"
}
```

</td>
</tr>
</tr>
</table>
</td>
</tr>
</tbody>
</table>

## Cart API

These APIs are intended to be used to manipulate the users' cart. All endpoints here is also _CSRF protected_

<table>
<tr><th>Method</th><th>Endpoint</th><th>Description</th></tr>
<tbody>
<tr>
<td>

`GET`

</td><td>

`/cart`

</td>
<td>

**Obtain the list of the items inside the cart**  
Payload: none

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted when the request is succeeded

Example:

```json
[
  {
    "product": "id",
    "product_name": "",
    "quantity": 200,
    "unit_price": 1200,
    "available": false
  }
]
```

</td>
</tr>
<tr>
<td>401</td>
<td>Unauthorized request (missing or invalid Access Token)

Example:

```json
{
  "status": 203,
  "message": "Invalid access token"
}
```

</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>

`PATCH`

</td><td>

`/cart`

</td>
<td>

**Update the cart**  
Payload:

```jsonc
//changes
[
  {
    "product": "product id",
    "quantity": 12 // new quantity or 0 to remove
  }
]
```

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted when the request is succeeded. Return the current content of the cart
</td>
</tr>
<tr>
<td>401</td>
<td>Unauthorized request (missing or invalid Access Token)

Example:

```json
{
  "status": 203,
  "message": "Invalid access token"
}
```

</td>
</tr>
<tr>
<td>404</td>
<td>The product id is not found

Example:

```json
{
  "status": 102,
  "message": "The product id does not exists"
}
```

</td>
</tr>
</tr>
</table>
</td>
</tr>
<tr>
<td>

`DELETE`

</td><td>

`/cart`

</td>
<td>

**Clear the entire cart**  
Payload: none

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted when the request is succeeded

Example:

```json
[]
```

</td>
</tr>
<tr>
<td>401</td>
<td>Unauthorized request (missing or invalid Access Token)

Example:

```json
{
  "status": 203,
  "message": "Invalid access token"
}
```

</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>

`POST`

</td><td>

`/cart/populate`

</td>
<td>

**Populate the cart with the content of the order**  
Payload:

```json
{
  "orderid": 2
}
```

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted when the request is succeeded. Returns the current cart content

Example:

```json
[]
```

</td>
</tr>
<tr>
<td>401</td>
<td>Unauthorized request (missing or invalid Access Token)

Example:

```json
{
  "status": 203,
  "message": "Invalid access token"
}
```

</td>
</tr>
<tr>
<td>404</td>
<td>The product id is not found

Example:

```json
{
  "status": 104,
  "message": "The order id does not exists"
}
```

</td>
</tr>
</table>
</td>
</tr>
<tr>
<td>

`GET`

</td><td>

`/cart/checkout`

</td>
<td>

**Get the checkout url**  
Payload: none for default or specify the shipping address using the following payload

```json
{
  "address": "address",
  "residence": "address"
}
```

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted when the request is succeeded

Example:

```json
{
  "status": 0,
  "message": "OK",
  "url": ""
}
```

</td>
</tr>
<tr>
<td>400</td>
<td>When checking out the empty cart

Example:

```json
{
  "status": 205,
  "message": "Cannot checkout empty"
}
```

</td>
</tr>
<tr>
<td>401</td>
<td>Unauthorized request (missing or invalid Access Token)

Example:

```json
{
  "status": 203,
  "message": "Invalid access token"
}
```

</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
