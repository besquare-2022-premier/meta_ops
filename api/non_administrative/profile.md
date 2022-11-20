# Profile API

This page contain the information about the profile access and manipulation endpoints. These endpoint must be used with the authentication. The base URL for this API is `/api/v1/whoami`. These endpoints are _CSRF protected_

## Schema for the profile

```jsonc
{
  "email": "a@b.c", //mandatory,immutable
  "first_name": "First Name", //mandatory
  "last_name": "Last Name", //mandatory
  "username": "username", //mandatory
  "address": "address", //optional
  "residence": "", //optional
  "telephone_number": "<optional>", //mandatory
  "first_join": "ddd", //immutable,
  "gender": "male", //mandatory
  "birthday": "ddd" //optional,immutable
}
```

<table>
<tr><th>Method</th><th>Endpoint</th><th>Description</th></tr>
<tbody>
<tr>
<td>

`GET`

</td><td>

`/`</td><td>Obtain the user profile information  
Payload: none

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted the request succeeded. Check schema for the information
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

`/`</td><td>Update the user profile information  
Payload: refer the schema for the payload format. (Note: there are some fields which are immutable)

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted the request succeeded. Returns the current status
</td>
</tr>
<tr>
<td>400</td>
<td>Invalid request (Attempt to change immutable field or clearing out the mandatory fields)

Example:

```json
{
  "status": 206,
  "message": "Email is immutable"
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
<tr>
<td>

`POST`

</td><td>

`/change-password`</td><td>Change the user password  
Payload:

```json
{
  "password": "currentpassword",
  "new_password": "",
  "new_password_again": ""
}
```

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted when the request succeeded.

```json
{
  "status": 0,
  "message": "OK"
}
```

</td>
</tr>
<tr>
<td>400</td>
<td>Invalid request (Attempt to change immutable field or clearing out the mandatory fields)

Example:

```json
{
  "status": 105,
  "message": "Password do not match"
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
