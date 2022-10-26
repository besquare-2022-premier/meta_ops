# Authentication API

This page contain the information about the authentication endpoints. The base URL for this API is `/api/auth`. All the APIs in this section is _CSRF protected_.

## Registration API

This part contain the api to perform the registration of the users.

<table>
<tr><th>Method</th><th>Endpoint</th><th>Description</th></tr>
<tbody>
<tr>
<td>

`POST`

</td><td>

`/register`

</td>
<td>

**Register an user using an email address**  
Payload:

```json
{
  "email": "EMAIL ADDRESS"
}
```

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted when the signup is succeeded

Example:

```json
{
  "status": 0,
  "message": "Please check your email for the sign up instructions"
}
```

</td>
</tr>
<tr>
<td>400</td>
<td>Emiited when there is the error inside the data

Example:

```json
{
  "status": 401,
  "message": "Invalid Credentials"
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

`/finalize-registration`

</td>
<td>

**Finalize the registration**  
Payload:

```json
{
  "verification_code": "verification_code",
  "first_name": "First Name",
  "last_name": "Last Name",
  "username": "username",
  "password": "password",
  "address": "<optional>",
  "telephone_number": "<optional>"
}
```

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted when the signup is finalized sucessfully

Example:

```json
{
  "status": 0,
  "message": "Please check your email for the sign up instructions"
}
```

</td>
</tr>
<tr>
<td>400</td>
<td>Emiited when there is the error inside the data

Example:

```json
{
  "status": 103,
  "message": "Last name is required"
}
```

</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>

## Login API

This part contain the api to perform the registration of the users.

<table>
<tr><th>Method</th><th>Endpoint</th><th>Description</th></tr>
<tbody>
<tr>
<td>

`POST`

</td><td>

`/login`</td><td>Perform the login and get the access token for the future api calls  
Payload:

```json
{
  "username": "username or email",
  "password": "password"
}
```

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted when the signin is succeeded

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
<td>400</td>
<td>Emiited when there is the error inside the data or the request fail

Example:

```json
{
  "status": 103,
  "message": "Last name is required"
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

`/revoke`</td><td>Revoke the access token  
Payload: none
Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Always succeeded
</td>
</tr>
</table>
</td>
</tr>
</tbody>
</table>
