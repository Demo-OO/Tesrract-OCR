namespace: advantage__accountservice_war_rest_api
flow:
  name: ocr
  inputs:
    - abbyy_location_id: cloud-eu
    - abbyy_application_id
    - abbyy_password
    - abbyy_source_file: "c:\\\\temp\\\\list-of-aos-users2.png"
    - user_password: Cloud@123
  workflow:
    - process_image:
        do:
          io.cloudslang.abbyy.cloud.v1.process_image:
            - location_id: '${abbyy_location_id}'
            - application_id: '${abbyy_application_id}'
            - password:
                value: '${abbyy_password}'
                sensitive: true
            - source_file: '${abbyy_source_file}'
            - export_format: txt
        publish:
          - return_result
          - txt_result
          - xml_result
          - pdf_url
          - task_id
          - credits
          - status_code
          - items: "${cs_substring(txt_result,txt_result.find('Phone number')+len('Phone number'),txt_result.find('Thanks')).strip()}"
          - office_address: "${txt_result.split('office address:')[1].split('Also, their')[0].strip()}"
        navigate:
          - SUCCESS: list_iterator
          - FAILURE: on_failure
    - list_iterator:
        do:
          io.cloudslang.base.lists.list_iterator:
            - list: '${items}'
            - separator: "\\n"
        publish:
          - item: '${result_string}'
          - first_name: "${'' if result_string is '' else result_string.split()[0]}"
          - last_name: "${'' if result_string is '' else result_string.split()[1]}"
          - phone_number: "${'' if result_string is '' else \" \".join(result_string.split()[2:])}"
        navigate:
          - HAS_MORE: random_number_generator
          - NO_MORE: SUCCESS
          - FAILURE: on_failure
    - random_number_generator:
        do:
          io.cloudslang.base.math.random_number_generator:
            - min: '0'
            - max: '999999'
        publish:
          - random_number
        navigate:
          - SUCCESS: register_user
          - FAILURE: on_failure
    - register_user:
        do:
          advantage__accountservice_war_rest_api.accountrest.api.v1.register_user:
            - login_name: "${(first_name[0:2]+'.'+last_name[0:3]).lower()+'.'+random_number}"
            - password: '${user_password}'
            - first_name: '${first_name}'
            - last_name: '${last_name}'
            - email: "${(first_name+'.'+last_name).lower()+'@microfocus.com'}"
            - phone_number: '${phone_number}'
            - address: '${office_address.splitlines()[0].strip()}'
            - city_name: '${office_address.splitlines()[3].strip()}'
            - zip_code: '${office_address.splitlines()[6].strip()}'
            - country: UNITED_KINGDOM_UK
            - state_province: None
        publish:
          - login_name
        navigate:
          - FAILURE: on_failure
          - SUCCESS: send_mail
    - send_mail:
        do:
          io.cloudslang.base.mail.send_mail:
            - hostname: localhost
            - port: '25'
            - from: petr.panuska@microfocus.com
            - to: petr.panuska@microfocus.com
            - subject: "${'User %s registered at AOS site' % login_name}"
            - body: |-
                ${'''We are pleased to inform you that an account has been created!
                Login Name: %s
                First Name: %s
                Last Name: %s
                ''' % (login_name, first_name, last_name)}
            - html_email: 'false'
        navigate:
          - SUCCESS: list_iterator
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      process_image:
        x: 75
        'y': 126
      list_iterator:
        x: 276
        'y': 128
        navigate:
          fdff25a1-cc1c-e79f-c2dd-777d921948c9:
            targetId: c4dad3a2-08dc-40c4-b454-90068c3f9376
            port: NO_MORE
      send_mail:
        x: 105
        'y': 327
      random_number_generator:
        x: 492
        'y': 328
      register_user:
        x: 280
        'y': 531
    results:
      SUCCESS:
        c4dad3a2-08dc-40c4-b454-90068c3f9376:
          x: 496
          'y': 130
