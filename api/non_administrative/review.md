# Review API

This page contain the information about the review access and manipulation endpoints. The base URL for this API is `/api/v1/products-review`.

## The schema for the reviews

```json
{
  "productid": 123,
  "loginid": 1,
  "product_rating": 5,
  "product_review": "review",
  "time": "time"
}
```

## Endpoints

<table>
<tr><th>Method</th><th>Endpoint</th><th>Description</th></tr>
<tbody>
<tr>
<td>

`GET`

</td><td>

`/:productid`

</td><td>

**Get the detailed information of product reviews by ID**  
Payload: none

URL parameters:

| Parameter   | Description                  |
| ----------- | ---------------------------- |
| `productid` | The ID of the product to get |

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted when the request is succeeded

Example:

```json
[
  {
    "productid": 38,
    "loginid": 13,
    "rating": "4",
    "review": "nice",
    "time": "2022-11-10T17:25:47.736Z"
  }
]
```

</td>
</tr>
<tr>
<td>400</td>
<td>The product is not found

Example:

```json
{
  "status": 104,
  "message": "Invalid or inexistant product id"
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

`/add-review`

</td><td> Add review for a product.
Payload:

```json
{
  "productid": 38,
  "product_rating": 4,
  "product_review": "review"
}
```

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted the request succeeded
</td>
</tr>
<tr>
<td>400</td>
<td>The product is not found

Example:

```json
{
  "status": 104,
  "message": "Invalid or inexistant product id"
}
```

</td>
</tr>
<tr>

</tr>
</table>
</td>
</tr>
