*** Settings ***
Resource            ../resource/Resource.robot
Test Setup          Abrir navegador
Test Teardown       Fechar navegador
Suite Setup         Conectar a minha API

*** Variables ***
${URL}        https://www.google.com/
${BROWSER}    firefox

*** Test Case ***
Cenário 01: Pesquisar pagina existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo página "Amazon Brasil"
    Então a página deve exibir "Amazon Serviços de Varejo do Brasil Ltda. | CNPJ 15.436.940/0001-03"

Caso de Teste 02: Pesquisar produto existente
    Dado que estou na página home do site
    Quando eu pesquisar pelo página "Amazon Brasil"
    E eu pesquisar pelo produto "iPhone"
    Então a página deve exibir a mensagem o número total do produto "iPhone"

Caso de Teste 03: Pesquisar produto mais caro
      Dado que estou na página home do site
      Quando eu pesquisar pelo página "Amazon Brasil"
      E eu pesquisar pelo produto "iPhone"
      E pegar o "item" mais caro da página
      Então devo converter o valor do "item" para USD

*** Keywords ***
Dado que estou na página home do site
    Acessar a página home do site

Quando eu pesquisar pelo página "${PAGINA}"
    Digitar o nome da página ${PAGINA} no campo da pesquisa
    Clicar no botão pesquisar do Google

Então a página deve exibir "${NOME-CNPJ}"
    Conferir se existe "${NOME-CNPJ}" da Amazon

E eu pesquisar pelo produto "${PRODUTO}"
     Digitar o nome do produto ${PRODUTO} no campo da pesquisa
     Clicar no botão pesquisar da amazon

Então a página deve exibir a mensagem o número total do produto "${IPHONE}"
     Conferir número total do produto "${IPHONE}"

E pegar o ${ATRIBUTO} mais caro da página
     Procurar o ${ATRIBUTO} mais caro da página

Então devo converter o valor do ${ATRIBUTO} para USD
    Fazer uma requisição na ${URL_API}
    # Cadastrar o valor do ${ATRIBUTO}
