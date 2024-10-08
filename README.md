# ZiniPay Task

## Overview
The **ZiniPay Task** is a mobile application developed using Flutter that allows users to authenticate via an API and manage SMS syncing in the background. The app includes a simple user interface with two main pages: a login page and a home page where users can start or stop syncing incoming SMS messages.

## Preview Video
You can watch the preview video of the ZiniPay Task app by clicking the link below:
[Preview Video](assets/images/preview_video/preview_video.mp4)

## Screenshots
### User Interface
Below are some screenshots of the application:

#### Login and Home Screens
| ![Login Screen](assets/images/preview_images/login.jpg) | ![Home Inactive](assets/images/preview_images/home_inactive.jpg) | ![Home Active](assets/images/preview_images/home_active.jpg) |
|-------------------------------------------|-----------------------------------------------------|-------------------------------------------------|

#### Messages and Credentials Screens
| ![Messages Screen](assets/images/preview_images/messages.jpg) | ![Credentials Screen](assets/images/preview_images/credentials.jpg) |
|------------------------------------------------|-----------------------------------------------------|

## Features
1. **Login Page**:
   - Two input fields for email and API key.
   - Authentication via the provided login API.
   - On successful login, the user is redirected to the home page.

2. **Home Page**:
   - A button to start or stop syncing incoming SMS messages in the background.
   - Implements a persistent notification to indicate that SMS syncing is ongoing.
   - Automatically resumes syncing after an internet reconnection.
  
3. **All Messages Page**:
   - Displayed all the messages from the endpoint provided for retrieving all the messages: `GET https://demo.zinipay.com/sms`.

4. **All Credentials Page**:
   - Displayed all the User Credentials from the endpoint provided for retrieving all devices/login credentials: `GET https://demo.zinipay.com/devices`.
  
4. **API Integration**:
   - All the api integration is handled in the class [**dio_helper.dart**](lib/src/features/data/helpers/dio_helper.dart)
      - **Login API**: Authenticates users using their email and API key.
        - **Endpoint**: `POST https://demo.zinipay.com/app/auth`
        - **Request Body**:
          ```json
          {
            "email": "user1@example.com",
            "apiKey": "apikey1"
          }
          ```
        - **Success Response**:
          ```json
          {
            "success": true,
            "message": "Authentication successful"
          }
          ```
      - **SMS Sync API**: Sends incoming SMS messages to a specified endpoint.
        - **Endpoint**: `POST https://demo.zinipay.com/sms/sync`
        - **Request Body**:
          ```json
          {
            "message": "Test message now",
            "from": "+1234567890",
            "timestamp": "2024-07-31T10:00:00Z"
          }
          ```
        - **Success Response**:
          ```json
          {
            "success": true,
            "message": "SMS synced successfully."
          }
          ```
      - **Additional Endpoints**: 
        - Retrieve all messages: `GET https://demo.zinipay.com/sms`
        - View all devices/login credentials: `GET https://demo.zinipay.com/devices`
---

## Background Tasks
Used [**workmanager**](https://pub.dev/packages/workmanager) library to handle the background tasks like syncing sms.
The app runs continuously in the background, syncing SMS messages even when closed. It also handles cases where the device loses internet connectivity, queuing messages until the connection is restored.

## Setup Instructions
To run the app locally, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/zini_pay_task.git
   cd zini_pay_task

2. **Resolve Dependencies**:
   ```bash
   flutter pub get

2. **Run the App**:
   ```bash
   flutter run
---

## 📦 Packages Used

- [**dio**](https://pub.dev/packages/dio) – For making API requests
- [**dartz**](https://pub.dev/packages/dartz) – Functional programming
- [**equatable**](https://pub.dev/packages/equatable) – Value equality for Dart objects
- [**workmanager**](https://pub.dev/packages/workmanager) – For managing background tasks
- [**flutter_local_notifications**](https://pub.dev/packages/flutter_local_notifications ) – For handling notifications
---
