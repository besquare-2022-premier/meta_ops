# CSRF API

This page contain the information about the CSRF endpoints. These endpoint can be used with or without the authentication. The base URL for this API is `/api/v1/token`

<table>
<tr><th>Method</th><th>Endpoint</th><th>Description</th></tr>
<tbody>
<tr>
<td>

`GET`

</td><td>

`/`</td><td>Obtain the token for the CSRF protected call, the new token will superseded the current token  
Payload: none

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted when the token is issued

Example:

```json
{
  "status": 0,
  "message": "OK",
  "token": "REDACTED"
}
```

</td>
</tr>
<tr>
<td>429</td>
<td>Emited when the request fail with rate limit exceeded

Example:

```json
{
  "status": 204,
  "message": "Rate limit exceeded"
}
```

</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
