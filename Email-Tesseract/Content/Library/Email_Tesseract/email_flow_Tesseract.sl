namespace: Email_Tesseract
flow:
  name: email_flow_Tesseract
  inputs:
    - _host: imap.gmail.com
    - _port: '993'
    - _username: rpademoocr@gmail.com
    - _password:
        default: 'R0b0t$!987'
        sensitive: true
    - _folder: INBOX
    - _protocol: imap
    - _trustAllRoots: 'True'
    - _enableTLS: 'True'
    - _enableSSL: 'True'
    - _destination: "C:\\ocr"
    - _overwrite: 'True'
    - _attachementName: picture.jpg
    - _fromEmail: Robot@microfocusrpa.com
    - _toEmail: gregory.rohmer@microfocus.com
    - _subject: "OCR'd Content"
    - _ocrtext: "c:\\ocr\\result\\picture.txt"
    - _send_port: '465'
    - _send_protocol: smtp
    - _send_host: smtp.gmail.com
  workflow:
    - get_mail_message_count:
        do:
          io.cloudslang.base.mail.get_mail_message_count:
            - host: '${_host}'
            - port: '${_port}'
            - protocol: '${_protocol}'
            - username: '${_username}'
            - password:
                value: '${_password}'
                sensitive: true
            - folder: '${_folder}'
            - enable_SSL: '${_enableSSL}'
            - enable_TLS: '${_enableTLS}'
            - trust_all_roots: '${_trustAllRoots}'
        publish:
          - _message_count: '${return_result}'
        navigate:
          - SUCCESS: get_mail_attachment
          - FAILURE: FAILURE
    - get_mail_attachment:
        do:
          io.cloudslang.base.mail.get_mail_attachment:
            - host: '${_host}'
            - port: '${_port}'
            - protocol: '${_protocol}'
            - username: '${_username}'
            - password:
                value: '${_password}'
                sensitive: true
            - folder: '${_folder}'
            - message_number: '${_message_count}'
            - destination: '${_destination}'
            - attachment_name: '${_attachementName}'
            - overwrite: 'True'
            - trust_all_roots: '${_trustAllRoots}'
            - enable_SSL: '${_enableSSL}'
            - enable_TLS: '${_enableTLS}'
        navigate:
          - SUCCESS: tesseract_setup
          - FAILURE: FAILURE
    - send_mail:
        do:
          io.cloudslang.base.mail.send_mail:
            - hostname: '${_send_host}'
            - port: '${_send_port}'
            - from: '${_fromEmail}'
            - to: '${_toEmail}'
            - subject: '${_subject}'
            - body: '${text_string}'
            - username: '${_username}'
            - password:
                value: '${_password}'
                sensitive: true
            - character_set: UTF-8
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: FAILURE
    - extract_text_from_image:
        do:
          io.cloudslang.tesseract.ocr.extract_text_from_image:
            - file_path: "C:\\ocr\\picture.jpg"
            - data_path: '${data_path}'
            - language: ENG
        publish:
          - text_string
        navigate:
          - SUCCESS: send_mail
          - FAILURE: FAILURE
    - tesseract_setup:
        do:
          io.cloudslang.tesseract.ocr.utils.tesseract_setup:
            - data_path: "C:\\ocrtemp"
        publish:
          - data_path: '${data_path_output}'
        navigate:
          - SUCCESS: extract_text_from_image
          - FAILURE: FAILURE
  outputs:
    - flow_output_0: pictureattachment
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      get_mail_message_count:
        x: 242
        'y': 259
        navigate:
          3dd62cbb-41a7-2858-f28c-834595236c09:
            targetId: 822c5533-71f0-b284-cc07-470f7c0199ef
            port: FAILURE
      get_mail_attachment:
        x: 400
        'y': 125
        navigate:
          af7e4739-3ff4-2a2e-4f55-d3d9ccb208fd:
            targetId: 822c5533-71f0-b284-cc07-470f7c0199ef
            port: FAILURE
      tesseract_setup:
        x: 563
        'y': 252
        navigate:
          c321234b-6cbc-244b-050e-e9582cd6294e:
            targetId: 822c5533-71f0-b284-cc07-470f7c0199ef
            port: FAILURE
      extract_text_from_image:
        x: 694
        'y': 255
        navigate:
          f030432e-95b7-f631-b55b-d15c04d113d4:
            targetId: 822c5533-71f0-b284-cc07-470f7c0199ef
            port: FAILURE
      send_mail:
        x: 829
        'y': 253
        navigate:
          dba692fa-fd31-cb1e-780f-80cc555a2829:
            targetId: d77e8947-52a2-71d5-1532-694b71306ba5
            port: SUCCESS
          6c4f7c8e-901b-507d-36ff-7a5df9ad0376:
            targetId: 822c5533-71f0-b284-cc07-470f7c0199ef
            port: FAILURE
    results:
      SUCCESS:
        d77e8947-52a2-71d5-1532-694b71306ba5:
          x: 967
          'y': 255
      FAILURE:
        822c5533-71f0-b284-cc07-470f7c0199ef:
          x: 400
          'y': 375
