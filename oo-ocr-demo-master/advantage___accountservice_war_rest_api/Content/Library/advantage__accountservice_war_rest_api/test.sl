namespace: advantage__accountservice_war_rest_api
flow:
  name: test
  inputs:
    - login_name: pe.pan
    - first_name: Petr
    - last_name: Panuska
  workflow:
    - send_mail:
        do:
          io.cloudslang.base.mail.send_mail:
            - hostname: localhost
            - port: '25'
            - from: pe.pan@rpa.mf-te.com
            - to: pe.pan@centrum.cz
            - subject: "${'User %s registered at AOS site' % login_name}"
            - body: |-
                ${'''
                We are pleased to inform you that an account has been created!
                Login Name: %s
                First Name: %s
                Last Name: %s
                ''' % (login_name, first_name, last_name)}
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      send_mail:
        x: 161
        'y': 76
        navigate:
          1bd20aa8-211c-f4de-0110-fd1fa100fe64:
            targetId: 96d498ad-136b-c3a1-625d-d80dbba65e14
            port: SUCCESS
    results:
      SUCCESS:
        96d498ad-136b-c3a1-625d-d80dbba65e14:
          x: 340
          'y': 78
