*** Settings ***
Documentation   This bot will insert update delete data of 
...             an inventory management system
Library         RPA.Browser
Library         RPA.FileSystem
Library         RPA.PDF
Library         RPA.core.notebook
Library         String


***Keywords***
Open the app
    Open Available Browser  https://excelcult.com/inventorymanagement
    Maximize Browser Window

***Keywords***
Extract the data from pdf
    [Arguments]  ${file}
    ${data}=  Get Text From Pdf  ${file}
    #Notebook Print  ${data}
    #Notebook Print  ${data[1]}
    ${productname}=  Get Regexp Matches  ${data[1]}  (?<=Product Name : ).*
    ${seller}=  Get Regexp Matches  ${data[1]}  (?<=Seller : ).*
    ${price}=  Get Regexp Matches  ${data[1]}  (?<=Price : ).*
    ${product_name}=  Strip String  ${productname[0]}
    ${seller_name}=   Strip String  ${seller[0]}
    ${price_name}=  Strip String  ${price[0]}  
    Return From Keyword  ${product_name}  ${seller_name}  ${price_name} 
    

***Keywords***
Insert the records
    ${files}=  List Files In Directory  ${CURDIR}${/}Inventory Managment${/}insert${/}
    FOR  ${file}  IN  @{files}
        ${ProductName}  ${seller}  ${price}=  Extract the data from pdf  ${file}
        Input Text   id:proname  ${ProductName}
        Input Text   id:seller  ${seller}
        Input Text   id:price  ${price}
        Sleep  3 seconds
        Click Button  id:btn-create 
    END  

*** Tasks ***
Inventory Management Bot 
    Open the app
    Insert the records


