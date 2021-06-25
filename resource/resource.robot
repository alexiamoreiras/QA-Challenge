*** Settings ****
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections

*** Variables ***
${BROWSER}    firefox
${URL}        https://www.google.com/
${URL_API}      https://exchangeratesapi.io/

*** Keywords ***
####Setup e Teardown
Abrir navegador
    Open Browser    about:blank     ${BROWSER}

Fechar navegador
    Close Browser

Conectar a minha API
    Create Session    exchangerates    ${URL_API}

####Passo-a-Passo
Acessar a página home do site
    Go To     ${URL}
    Title Should be     Google

Digitar o nome da página ${PAGINA} no campo da pesquisa
     Input Text     name=q    ${PAGINA}

Clicar no botão pesquisar do Google
    Click Element     xpath=/html/body/div[1]/div[3]/form/div[1]/div[1]/div[3]/center/input[2]

Digitar o nome do produto ${PRODUTO} no campo da pesquisa
     Input Text     name=field-keywords    ${PRODUTO}

Clicar no botão pesquisar da amazon
     Click Element     id=nav-search-submit-button

Procurar o ${ATRIBUTO} mais caro da página
     ${ATRIBUTO} =  Get Text     xpath://*[@id="search"]//*[@class="a-price-whole"][starts-with(text(),"8.790")]

Fazer uma requisição na ${URL_API}
      ${RESPOSTA}     Get On Session    exchangerates    https://exchangeratesapi.io/
      Log             ${RESPOSTA.text}
      Set Test Variable    ${RESPOSTA}

# Cadastrar o valor do ${ATRIBUTO}
#       ${HEADERS}      Create Dictionary    content-type=application/json
#       ${RESPOSTA}     Post Request    exchangerates    https://exchangeratesapi.Session
#       ...                             data={ "timestamp": 1610726768,"source": USD,"quotes": {"USDCAD": 1.218883,"USDCHF": 0.814918,"USDEUR": 0.811882,"USDGBP": 0.733611,}}
#       ...                             headers=${HEADERS}
#

 ####Conferências
Conferir se existe "${NOME-CNPJ}" da Amazon
      Page Should Contain    ${NOME-CNPJ}

Conferir número total do produto "${IPHONE}"
       ${IPHONE} =  Get Element Count    xpath://*[@id="search"]//*[@class="a-size-base-plus a-color-base a-text-normal"][starts-with(text(),"iPhone")]
