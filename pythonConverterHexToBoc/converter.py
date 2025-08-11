# Пример строки hex (например, для "hello" в hex: 68656c6c6f)
hex_data = "b5ee9c720101070100e1000114ff00f4a413f4bcf2c80b0102016202030202cf0405000fa12d81f04ede446101db0831c02497c138007434c0c05c6c2497c1383e900c3c004074c7c822d58da1958dae31c1638e96f220841b7cded34072c7f222e595e1958dd5d1a5bdba33c5b2407316a87000007280327220060072c15633c59c3e809c4072dab33260103ec0380cccc0b00038c096e103fcbc2006001d3b51343e90007e1874c7c07e18b4600078d430d0ed1ef825f815f81001ed44019a94d868f282925b6df2ffda1101ed54c8c9ed55baf2e1f5c8801801cb0501cf1670fa027001cb6ac98306fb00"  # твоя строка в hex

# Преобразуем hex в байты
binary_data = bytes.fromhex(hex_data)

# Запишем в бинарный файл
with open("output.boc", "wb") as f:
    f.write(binary_data)

print("Файл успешно создан!")
