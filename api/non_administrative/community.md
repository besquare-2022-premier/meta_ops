# Community API

This page contain the information about the community access and manipulation endpoints. The base URL for this API is `/api/v1/community`. All the GET responses for this section are paginated also all the POST requests are CSRF and Authenticated.

## The schema for the messages

```json
{
  "message_id": 123,
  "topic_id": 5,
  "username": 1,
  "message": "",
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

`/topics`

</td><td>

**Get all the topics supported**  
Payload: none

Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted when the request is succeeded

Example:

```json
["Genshin"]
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

`/:topic`

</td><td> Get messages for a topic.
Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted the request succeeded
</td>
</tr>
<tr>
<td>404</td>
<td>The topic is not found

Example:

```json
{
  "status": 107,
  "message": "Invalid or inexistant topic id"
}
```

</tr></table>
</td>
</tr>
<tr>
<td>

`POST`

</td><td>

`/:topic`

</td><td> Post a new message.

Payload:

```json
{
  "message": ""
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
<td>Message is empty

Example:

```json
{
  "status": 103,
  "message": "Message cannot be empty"
}
```

</tr>
<tr>
<td>404</td>
<td>The product is not found

Example:

```json
{
  "status": 107,
  "message": "Invalid or inexistant topic id"
}
```

</td>
</tr>
</table>
</td>
<tr>
<td>

`GET`

</td><td>

`/:topic/:message-id`

</td><td> Get the message.
Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted the request succeeded
</td>
</tr>
<tr>
<td>404</td>
<td>The topic or message is not found

Example:

```json
{
  "status": 107,
  "message": "Invalid or inexistant topic id"
}
```

</tr></table>
</td>
</tr>
<tr>
<td>

`GET`

</td><td>

`/:topic/:message-id/replies`

</td><td> Get replies for a message.
Response:

<table>
<tr><th>HTTP Status</th><th>Description</th></tr>
<tr><td>200</td><td>
Emitted the request succeeded
</td>
</tr>
<tr>
<td>404</td>
<td>The topic or message is not found

Example:

```json
{
  "status": 107,
  "message": "Invalid or inexistant topic id"
}
```

</tr></table>
</td>
</tr>
<tr>
<td>

`POST`

</td><td>

`/:topic/:message-id`

</td><td> Post a new reply for a thread.

Payload:

```json
{
  "message": ""
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
<td>Message is empty

Example:

```json
{
  "status": 103,
  "message": "Message cannot be empty"
}
```

</tr>
<tr>
<td>404</td>
<td>The product is not found

Example:

```json
{
  "status": 107,
  "message": "Invalid or inexistant topic id"
}
```

</td>
</tr>

</table>
