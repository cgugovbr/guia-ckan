# Integração DCAT-BR

DCAT-BR é um perfil definido pelo Governo Federal para o padrão Data Catalog
Vocabulary (DCAT) do World Wide Web Consoritum (W3C). O padrão DCAT especifica
um formato para catálogos de dados, de forma a facilitar a integração entre
sistemas e dados na internet.

O Portal de Dados Abertos entende catálogos no formato DCAT-BR gerados por
qualquer tipo de sistema, não sendo necessário que o órgão implemente
o CKAN.

## O formato RDF

A base do padrão DCAT é o formato RDF (Resource Description Framework) que
representa dados na forma de um grafo orientado. Esse grafo é representado por
um conjunto de afirmações compostas por 3 elementos: um sujeito (nó do grafo),
um predicado (aresta do grafo) e um objeto (outro nó do grafo). Esse modelo
simples permite representar diversos tipos de relação entre dados.

Um grafo RDF pode ser serializado de diversas formas, sendo as mais comuns o
XML, o JSON-LD e o Turtle.

Referências:
* https://www.w3.org/RDF/
* https://www.w3.org/TR/rdf11-xml/
* https://www.w3.org/TR/json-ld11/
* https://www.w3.org/TR/turtle/

## O padrão DCAT

O padrão DCAT define tipos de classes adequadas para catálogos de dados. Classes
são tipos de nós no grafo RDF. O padrão também define as propriedades dessas
classes, que são usadas como predicados no grafo RDF. Com isso é possível atribuir
valores às propriedades dessas classes, formando o catálogo.

Veja a especificação completa do padrão DCAT em [Data Catalog Vocabulary](https://www.w3.org/TR/vocab-dcat-3/).

## O perfil DCAT-BR

O perfil DCAT-BR é uma especificação sobre as seguintes classes RDF:

* [`dcat:Dataset`](#classe-dcatdataset): representa um conjunto de dados
* [`dcat:Distribution`](#classe-dcatdistribution): representa um recurso
(arquivo) do conjunto de dados.
* [`dcterms:PeriodOfTime`](#classe-dctermsperiodoftime): representa um
intervalo de tempo.
* [`spdx:Checksum`](#classe-spdxchecksum): representa informações de verificação
de integridade de um arquivo ou pacote.

O perfil define as propriedades que essas classes devem ter e os valores possíveis.

Veja a especificação completa do perfil DCAT-BR em https://dcat-br.github.io/dcat-br/.

As tabelas a seguir mostram resumidamente as propriedades definidas pelo
perfil DCAT-BR para as classes acima.

### Classe `dcat:Dataset`

| Propriedade RDF            | Classe RDF do Objeto Associado | Campo no Portal de Dados Abertos       |
|----------------------------|--------------------------------|----------------------------------------|
| dcterms:title              | Literal                        | Título                                 |
| dcterms:description        | Literal                        | Descrição                              |
| dcat:license               | URI                            | Licença de Uso                         |
| dcterms:accrualPeriodicity | URI                            | Periodicidade de Atualização           |
| dcterms:accessRights       | URI                            | Observância Legal                      |
| dcterms:publisher          | Literal                        | Área técnica responsável pelo dado     |
| dcat:contactPoint          | vcard:Organization             | E-mail da área técnica responsável     |
| dcat:keyword               | Literal                        | Palavras-chave                         |
| adms:version               | Literal                        | Versão                                 |
| dcat:theme                 | URI                            | Tema associado ao conjunto de dados    |
| dcterms:language           | URI                            | Idioma                                 |
| dcterms:isVersionOf        | URI                            | Versão anterior                        |
| dcterms:isReplacedBy       | URI                            | Substituído por                        |
| dcterms:temporal           | dcterms:PeriodOfTime           | Cobertura temporal                     |
| dcterms:spatial            | URI                            | Cobertura espacial                     |
| dcat:spatialResolutionInMeters | URI                        | Granularidade espacial                 |
| dcatbr:relacionadoODS      | Literal                        | Possui relação com Objetivos de Desenvolvimento Sustentável (ODS)? |
| dcatbr:ods                 | Literal                        | Objetivos de Desenvolvimento Sustentável (ODS) |
| dcatbr:dadosRacaEtnia      | Literal                        | Possui dados de raça/etnia?            |
| dcatbr:dadosGenero         | Literal                        | Possui dados de gênero?                |
| dcat:distribution          | dcat:Distribution              | Recurso associado ao conjunto de dados |

#### Propriedade `dcterms:title`

Deve conter um texto livre indicando o título do conjunto de dados.

#### Propriedade `dcterms:description`

Deve conter um texto livre indicando a descrição do conjunto de dados.

#### Propriedade `dcat:license`

Deve seguir o vocabulário controlado de licenças de uso (VCR-LU) e estar
associada a uma URI que indica uma licença.

Consulte os valores disponíveis na [documentação do VCR-LU](https://dcat-br.github.io/dcat-br/docs/vocabularies/VCR-LU/index.html#termos).

Exemplo: https://creativecommons.org/licenses/by/4.0 para a licença Creative
Commons Atributtion.

#### Propriedade `dcterms:accrualPeriodicity`

Deve seguir o vocabulário controlado para frequência (VCR-FR) e estar associada
a uma URI que representa um valor de periodicidade.

Consulte os valores disponíveis na [documentação do VCR-FR](https://dcat-br.github.io/dcat-br/docs/vocabularies/VCR-FR/index.html).

Exemplo: https://dcat-br.github.io/dcat-br/docs/vocabularies/VCR-FR/MENSAL para atualização de uma vez por mês.

#### Propriedade `dcterms:accessRights`

Deve seguir o vocabulário controlado para observância legal e estar associada
a uma URI indicando se o dado é público ou qual a norma legal que o permite ser
restrito.

Consulte os valores disponíveis na [documentação do vocabulário](https://dcat-br.github.io/dcat-br/docs/vocabularies/SEI/index.html#termos).

Exemplo: https://dcat-br.github.io/dcat-br/docs/vocabularies/SEI/1 para dado público.

#### Propriedade `dcterms:publisher`

Deve conter um texto livre indicando a área técnica do órgão responsável pelos
dados.

#### Propriedade `dcat:contactPoint`

Deve estar associada a um nó da classe
Organization (`vcard:Organization`) da ontologia vCard (ver https://www.w3.org/TR/vcard-rdf/#d4e2121).

O nó deve conter a propriedade `vcard:hasEmail` associado ao endereço de e-mail
da área responsável pelo dado.

#### Propriedade `dcat:keyword`

Deve conter um texto livre indicando uma palavra-chave associada ao conjunto de
dados. A propriedade pode ser definida mais de uma vez, indicando mais de uma
palavra-chave associada.

#### Propriedade `adms:version`

Deve conter um texto livre indicando a versão do conjunto de dados.

#### Propriedade `dcat:theme`

Deve seguir o vocabulário controlado de temas e estar associada a uma URI
que representa um tema.

Os temas disponíveis podem ser consultados na [documentação do vocabulário](https://dcat-br.github.io/dcat-br/docs/vocabularies/themes/index.html).

Exemplo: https://dcat-br.github.io/dcat-br/docs/vocabularies/themes/meio-ambiente
para o tema "Meio Ambiente".

A propriedade pode ser definida mais de uma vez, indicando mais de um tema
associado.

#### Propriedade `dcterms:language`

Deve seguir o vocabulário controlado para linguagem (VCR-LN) e estar associada
a uma URI que indica um idioma previsto na norma ISO 639-1. Consulte os idiomas
e URIs disponíveis no site https://id.loc.gov/vocabulary/iso639-1.html.

Exemplo: para o idioma Português, usar a URI `http://id.loc.gov/vocabulary/iso639-1/pt`.

Referência: [Documentação do VCR-LN](https://dcat-br.github.io/dcat-br/docs/vocabularies/VCR-LN/index.html)

#### Propriedade `dcterms:isVersionOf`

Deve ser associada a uma URI que indica o conjunto de dados que foi substituído
pelo conjunto atual.

#### Propriedade `dcterms:isReplacedBy`

Deve ser associada a uma URI que indica o conjunto de dados que substituiu
o conjunto atual.

#### Propriedade `dcterms:temporal`

Deve estar associada a um nó da classe [`dcterms:PeriodOfTime`](#classe-dctermsperiodoftime)
indicando a cobertura temporal do recurso, isto é, o período de tempo
representado pelos dados deste recurso específico.

#### Propriedade `dcterms:spatial`

Deve seguir o vocabulário controlado para cobertura espacial (VCR-CE) e
estar associado a uma URI que representa os termos disponíveis na
[documentação do VCR-CE](https://dcat-br.github.io/dcat-br/docs/vocabularies/VCR-CE/index.html#termos).

Exemplo: para cobertura de dados a nível federal use a URI
https://dcat-br.github.io/dcat-br/docs/vocabularies/VCR-CE/FEDERAL

#### Propriedade `dcat:spatialResolutionInMeters`

Deve seguir o vocabulário controlado para cobertura espacial (VCR-CE) e
estar associado a uma URI que representa os termos disponíveis na
[documentação do VCR-CE](https://dcat-br.github.io/dcat-br/docs/vocabularies/VCR-CE/index.html#termos).

Exemplo: para granularidade de dados a nível municipal use a URI
https://dcat-br.github.io/dcat-br/docs/vocabularies/VCR-CE/MUNICIPAL

#### Propriedade `dcatbr:relacionadoODS`

Deve conter o valor `true` caso o conjunto tenha relação com Objetivos de
Desenvolvimento Sustentável e `false` caso contrário.

#### Propriedade `dcatbr:ods`

Deve conter um dos valores possíveis a seguir:

* Erradicação da Pobreza
* Fome Zero e Agricultura Sustentável
* Saúde e Bem-Estar
* Educação de Qualidade
* Igualdade de Gênero
* Água Limpa e Saneamento
* Energia Limpa e Acessível
* Trabalho Decente e Crescimento Econômico
* Indústria, Inovação e Infraestrutura
* Redução das Desigualdades
* Cidades e Comunidades Sustentáveis
* Consumo e Produção Sustentáveis
* Ação contra a Mudança Global do Clima
* Vida na Água
* Vida Terrestre
* Paz, Justiça e Instituições Eficazes
* Parcerias e Meios de Implementação

A propriedade pode ser definida mais de uma vez, indicando mais de um objetivo
de desenvolvimento sustentável associado ao conjunto.

#### Propriedade `dcatbr:dadosRacaEtnia`

Deve conter o valor `true` caso o conjunto possua dados de raça/etnia e `false`
caso contrário.

#### Propriedade `dcatbr:dadosGenero`

Deve conter o valor `true` caso o conjunto possua dados de gênero e `false`
caso contrário.

#### Propriedade `dcat:distribution`

Deve estar associada a um nó da classe `dcat:Distribution` indicando um recurso
pertencente ao conjunto de dados.

A propriedade pode ser definida mais de uma vez, quando o conjunto de dados
possui mais de um recurso.

### Propriedades dos recursos (`dcat:Distribution`)

| Propriedade RDF     | Classe RDF do Objeto Associado | Campo no Portal de Dados Abertos |
|---------------------|--------------------------------|----------------------------------|
| dcat:accessURL      | URI                            | URL                              |
| dcterms:format      | URI                            | Formato                          |
| dcterms:title       | Literal                        | Título                           |
| dcterms:type        | URI                            | Tipo do recurso                  |
| dcterms:description | Literal                        | Descrição                        |
| dcterms:temporal    | dcterms:PeriodOfTime           | Cobertura temporal               |
| dcat:byteSize       | Literal                        | Tamanho em bytes                 |
| spdx:checksum       | spdx:Checksum                  | Verificação de conteúdo          |

#### Propriedade `dcat:acessURL`

Deve conter a URL para download do arquivo em questão.

Ex: https://dadosabertos-download.cgu.gov.br/dados_e-agendas/dados_e-agendas.zip

#### Propriedade `dcterms:format`

Deve estar associada a uma URL de um *media type*
definido no site da IANA (https://www.iana.org/assignments/media-types/media-types.xhtml).

Exemplo: https://www.iana.org/assignments/media-types/application/pdf para um arquivo PDF.

Alternativamente, a propriedade também pode estar associada a um valor literal
indicando a extensão do arquivo. Exemplo: "PDF".

#### Propriedade `dcterms:title`

Deve conter um texto livre indicando o título do recurso.

#### Propriedade `dcterms:type`

Deve seguir o vocabulário controlado para tipo de recurso e estar associada a
uma URI que representa um tipo de recurso.

Consulte os valores possíveis na [documentação do vocabulário](https://dcat-br.github.io/dcat-br/docs/vocabularies/tipo-recurso/index.html#termos).

Exemplo: https://dcat-br.github.io/dcat-br/docs/vocabularies/tipo-recurso/DICIONARIO_DE_DADOS
para recurso do tipo dicionário de dados.

#### Propriedade `dcterms:description`

Deve conter um texto livre descrevendo o recurso.

#### Propriedade `dcterms:temporal`

Deve estar associada a um nó da classe [`dcterms:PeriodOfTime`](#classe-dctermsperiodoftime)
indicando a cobertura temporal do recurso, isto é, o período de tempo
representado pelos dados deste recurso específico.

#### Propriedade `dcat:byteSize`

Deve indicar o tamanho do arquivo em bytes.

#### Propriedade `spdx:checksum`

Deve estar associada a um nó da classe [`spdx:Checksum`](#classe-spdxchecksum)
indicando o hash do arquivo e o algoritmo utilizado.

### Classe `dcterms:PeriodOfTime`

| Propriedade RDF     | Classe RDF do Objeto Associado | Campo no Portal de Dados Abertos |
|---------------------|--------------------------------|----------------------------------|
| dcat:startDate      | Literal                        | Cobertura temporal início        |
| dcat:endDate        | Literal                        | Cobertura temporal fim           |

#### Propriedades `dcat:startDate` e `dcat:endDate`

Devem estar codificadas no padrão ISO 8601 (ano-mês-dia).

Exemplo: 2026-01-30 (indica o dia 30 de janeiro de 2026).

Referências:
* https://www.w3.org/TR/vocab-dcat-3/#Property:period_start_date
* https://www.w3.org/TR/vocab-dcat-3/#Property:period_end_date

### Classe `spdx:Checksum`

| Propriedade RDF     | Classe RDF do Objeto Associado | Campo no Portal de Dados Abertos |
|---------------------|--------------------------------|----------------------------------|
| spdx:algorithm      | URI                            | N/D                              |
| spdx:checksumValue  | Literal                        | N/D                              |

#### Propriedade `spdx:algorithm`

Deve conter uma URI referenciando um dos algoritmos de hash disponíveis em
https://spdx.org/rdf/terms.

Exemplo: http://spdx.org/rdf/terms#checksumAlgorithm_sha1 para o algoritmo
SHA-1.

Referência: https://spdx.org/rdf/terms/#d4e46

#### Propriedade `spdx:checksumValue`

Deve conter o valor binário do hash codificado em hexadecimal usando letras
minúsculas.

Exemplo: 2aae6c35c94fcfb415dbe95f408b9ce91ee846ed

Referência: https://spdx.org/rdf/terms/#d4e1053
