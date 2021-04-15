namespace: advantage__accountservice_war_rest_api.accountrest.api.v1
flow:
  name: register_user
  inputs:
    - login_name
    - password
    - first_name
    - last_name
    - email
    - phone_number
    - address
    - city_name
    - zip_code
    - country
    - state_province
  workflow:
    - register_using_post:
        do:
          advantage__accountservice_war_rest_api.accountrest.api.v1.register_using_post:
            - account_create_request: |-
                ${'''
                {
                  "accountType": "USER",
                  "address": "%s",
                  "allowOffersPromotion": true,
                  "cityName": "%s",
                  "country": "%s",
                  "email": "%s",
                  "firstName": "%s",
                  "lastName": "%s",
                  "loginName": "%s",
                  "password": "%s",
                  "phoneNumber": "%s",
                  "stateProvince": "%s",
                  "zipcode": "%s"
                }
                ''' % (address, city_name, country, email, first_name, last_name, login_name, password, phone_number, state_province, zip_code)}
        publish:
          - return_result
          - error_message
          - status_code
          - return_code
          - response_headers
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - return_result: '${return_result}'
    - error_message: '${error_message}'
    - status_code: '${status_code}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      register_using_post:
        x: 63
        'y': 92
        navigate:
          f5042913-25cf-01b8-28fe-5dbd97b6d9db:
            targetId: 360ea61c-1c9b-1833-cc59-fd659d1e91cf
            port: SUCCESS
    results:
      SUCCESS:
        360ea61c-1c9b-1833-cc59-fd659d1e91cf:
          x: 257
          'y': 94
