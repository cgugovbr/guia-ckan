# Preenchimento dos dados no CKAN

O formulário do conjunto de dados do CKAN possui campos definidos originalmente e campos customizados.

O Portal de Dados Abertos do Governo Federal utiliza os dois tipos de campo, listados a seguir.

## Campos Originais

### Campos que mantém a mesma terminologia

Os campos a seguir tem a mesma terminologia no CKAN e no Portal de Dados Abertos, sendo de fácil identificação:
* Título
* Descrição
* Licença
* Versão

### Campos com terminologia ou comportamento diferente

1. URL

O final da URL do conjunto também terá o mesmo final no Portal, exceto se já existir um conjunto
com a mesma URL em outra organização. Nesse caso, será adicionado um número ao final da URL, para fazer a distinção.

Exemplo:
* URL no órgão: https://dados.turismo.gov.br/dataset/licitacoes
* URL no Portal: https://dados.gov.br/dados/conjuntos-dados/licitacoes
* URL no Portal caso haja outro conjunto com a mesma URL: https://dados.gov.br/dados/conjuntos-dados/licitacoes1

2. Etiquetas

As etiquetas definidas no CKAN aparecem com o nome de "Palavras-Chave" no Portal.
O significado, no entanto, é o mesmo, servindo para indicar termos associados ao conjunto de dados em questão.

3. Mantenedor

O campo mantenedor aparece no Portal com o nome de "Área técnica responsável pelo dado".

4. E-mail do Mantenedor

O campo de e-mail do mantenedor aparece no Portal com o nome de "E-mail da área técnica".

### Campos não utilizados

Os campos a seguir não são exibidos no Portal:
* Visibilidade: o Portal só importa conjuntos que estão públicos no CKAN do órgão
* Organização: por padrão todos os conjuntos do CKAN do órgão aparecerão na mesma organização no Portal, o que não impede o órgão de criar organizações no seu CKAN para representar suas sub-unidades.
* Fonte
* Autor
* E-mail do autor

## Campos Customizados

No CKAN, os campos customizados são nada mais do que pares de chave/valor que podem ser adicionados
ao conjunto de dados para incluir informações adicionais não cobertas pelos campos originais.

O Portal de Dados Abertos se utiliza desses campos customizados para obter algumas informações.
Os campos devem ser preenchidos com chave e valor exatamente como explicados a seguir.

1. Periodicidade de Atualização

* Chave: periodicidade
* Valores possíveis:
    * ANUAL
    * DIARIA
    * MENSAL
    * OUTRAS
    * QUINZENAL
    * SEMANAL
    * SOB\_DEMANDA
    * TRIMESTRAL

2. Cobertura Temporal Início

* Chave: coberturaTemporalInicio
* Valores possíveis: data no formato dia/mês/ano (dd/mm/aaaaa)

3. Cobertura Temporal Fim

* Chave: coberturaTemporalFim
* Valores possíveis: data no formato dia/mês/ano (dd/mm/aaaa)

4. Cobertura Espacial

* Chave: coberturaEspacial
* Valores possíveis:
    * FEDERAL
    * ESTADUAL
    * MUNICIPAL

5. Granularidade Espacial

* Chave: granularidadeEspacial
* Valores possíveis:
    * FEDERAL
    * ESTADUAL
    * MUNICIPAL

6. Atualização de Versão

* Chave: atualizacaoVersao
* Valores possíveis:
    * true
    * false

7. Homologado

* Chave: statusHomologacao
* Valores possíveis:
    * HOMOLOGADO
    * NAO\_HOMOLOGADO

8. Descontinuado

* Chave: descontinuado
* Valores possíveis:
    * true
    * false

9. Data da Descontinuação

* Chave: dataDescontinuacao
* Valores possíveis: data no formato dia/mês/ano (dd/mm/aaaaa)

## Formulário ilustrado

As imagens a seguir mostram o formulário do CKAN indicando os campos que são tratados pelo Portal de Dados Abertos:

![Formulário CKAN - Parte 1](imagens/form-ckan-1.png)

![Formulário CKAN - Parte 2](imagens/form-ckan-2.png)

![Formulário CKAN - Parte 1](imagens/form-ckan-3.png)

![Formulário CKAN - Parte 1](imagens/form-ckan-4.png)
