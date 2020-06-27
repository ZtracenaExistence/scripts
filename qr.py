import qrcode

#Dokumentace od CBA
#https://cbaonline.cz/upload/538-qr-kody-2015.pdf
#SPD*1.0*ACC:CZ5855000000001265098001*AM:480.50*CC:CZK*X-VS:1234567890*MSG:PLATBA VSTUPENKY XY

#SPD - short payment descriptor, konstanta

#1.0 - císlo verze

cisloUctu = "CZ5855000000001265098001"
'''
Max. 46 znaků (IBAN+BIC)
Identifikace protistrany, která je složena  ze  dvou  komponent oddělených znaménkem
+Tyto komponenty jsou:číslo účtu ve formátu IBANidentifikace  banky  ve  formátu SWIFT dle ISO 9362.
Druhá  komponenta  (SWIFT)  je přitom volitelná.

ACC:CZ5855000000001265098001+RZBCCZPP*...
a  nebo  (varianta bez čísla BIC):ACC:CZ5855000000001265098001*
'''

castka = '480.50'
'''
Desetinné číslo.max.2 desetiny
Výše částky platby
'''

mena = 'CZK'
'''
ISO 4217 - délka  3  znaky, velká písmena
'''

variabilniSymbol = '1234567890'
'''
celé èíslo, max 10 znakù
'''

zpravaProPrijemce = 'AKICON VSTUPENKA XY'
'''
Max 60 znakù.
Povolené znaky: 0–9,A–Z [pouze velká písmena], mezera, $, %, *, +, -, ., /, :
'''

qCodeString = "SPD*1.0*" + "ACC:" + cisloUctu + "*AM:" + castka + "*CC:" + mena + "*X-VS:" + variabilniSymbol + "*MSG:" + zpravaProPrijemce

qr = qrcode.QRCode(
    error_correction=qrcode.constants.ERROR_CORRECT_M,
    box_size=10,
    border=4,
)
#https://github.com/lincolnloop/python-qrcode
'''
error_correction = L (7%) / M (15%, default) / Q (25%) / H (30%)
CBA doporucuje 15%, ale zase predpoklada ze se QR bude tisknout na fakturu, ktera se muze zmuchlat, uspinit atp, na web by melo stacit i 7%


box_size parameter controls how many pixels each "box" of the QR code is

border parameter controls how many boxes thick the border should be (the default is 4, which is the minimum according to the specs)
'''
qr.add_data( qCodeString )
qr.make( fit=True )

img = qr.make_image()
img.save("qr.png")


