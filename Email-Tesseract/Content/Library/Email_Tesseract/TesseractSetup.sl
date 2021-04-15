namespace: Email_Tesseract
flow:
  name: TesseractSetup
  workflow:
    - tesseract_setup:
        do:
          io.cloudslang.tesseract.ocr.utils.tesseract_setup:
            - data_path: "C:\\Program Files\\Tesseract-OCR"
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      tesseract_setup:
        x: 141
        'y': 170
        navigate:
          8fd81d88-0557-cc8d-5840-848296e3b97b:
            targetId: 49955a7b-3a81-4c43-c6de-f28cdfdd576d
            port: SUCCESS
    results:
      SUCCESS:
        49955a7b-3a81-4c43-c6de-f28cdfdd576d:
          x: 329
          'y': 162
