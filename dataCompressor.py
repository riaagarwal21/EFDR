import random 

lookUp = {
    1 : ['000', '100'],
    2 : ['001', '101'],
    3 : ['01000', '11000'],
    4 : ['01001', '11001'],
    5 : ['01010', '11010'],
    6 : ['01011', '11011'],
    7 : ['0110000', '111000'],
    8 : ['0110001', '1110001'],
    9 : ['0110010', '1110010'],
    10 : ['0110011', '1110011'],
    11 : ['0110100', '1110100'],
    12 : ['0110101', '1110101'],
    13 : ['0110110', '0110110'],
    14 : ['0110111', '1110111']
}


def modifyData(dataString):
    
    chars = list(dataString)
    for i in range(len(chars)):
        if chars[i] == 2:
            chars[i] = random.choice(['0','1'])
    
    while (chars[-1] == chars[-2]):
        chars[-1] = random.choice(['0','1'])
        
    return ''.join(chars)


testString = "1111101111110111100001"
testData = modifyData(testString)
testBits = len(testData)
print("Test Data: ",testData)
print("Size of Test Data: ",testBits," bits")

def efdrEncoding(testData):
    compressedData = []
    runLength = 0
    i = 0
    while i < testBits:
        if i > 0:
            if (testData[i] != testData[i-1]):
                dataSymbol = int(testData[i-1])
                if runLength > 0:
                    compressedData.append(lookUp[runLength][dataSymbol])
                i += 1
                runLength = 1
            else:
                runLength += 1;
        else:
            runLength += 1
        i += 1
    return compressedData
    
   
compressedData = efdrEncoding(testData)   
print("Compressed Data: ",compressedData)

compressedBits = sum(len(ele) for ele in compressedData)
print("Size of Compressed Data: ",compressedBits," bits")

compRatio = ((testBits-compressedBits)/testBits)*100
print("Compression Ratio: ",compRatio)
