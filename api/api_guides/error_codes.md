# Error code guides

This document contains the guideline of all the error codes which might returned by the endpoints.

## Basic classification

| Status | Meaning                                              |
| ------ | ---------------------------------------------------- |
| 000    | No error happened. All operation succeeded           |
| 1xx    | Invalid user input is being provided to the endpoint |
| 2xx    | Illegal operation                                    |
| 3xx    | Unauthorized operation                               |
| 4xx    | Internal Error                                       |

## Allocation guideline

The steps required to allocate a new error code is as below:

- Open a dicussion topic inside the `#BackEND`
- Discuss with the backend team
- Open a Pull Request which modifies this file

## **1xx Error Codes**

| Code | Meaning                                         |
| ---- | ----------------------------------------------- |
| 101  | Invalid email address is provided to the system |
| 102  | The product id given is not exists              |
| 103  | Required fields is missing                      |
| 104  | The order id given is not exists                |
| 105  | Password do not match                           |

## **2xx Error Codes**

| Code | Meaning                                               |
| ---- | ----------------------------------------------------- |
| 201  | Invalid verification code                             |
| 202  | Invalid CSRF token                                    |
| 203  | Invalid access token                                  |
| 204  | Rate limit exceeded                                   |
| 205  | Cannot checkout empty cart                            |
| 206  | Field is immutable                                    |
| 207  | Neither residence address nor shipping address is set |

## **3xx Error Codes**

| Code | Meaning               |
| ---- | --------------------- |
| 301  | Authentication Failed |

## **4xx Error Codes**

| Code | Meaning |
| ---- | ------- |
