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
XML, o JSON-LD e o Turtle. (TODO colocar alguma ref)

## O padrão DCAT

O padrão DCAT define tipos de classes adequadas para catálogos de dados. Classes
são tipos de nós no grafo RDF. O padrão também define as propriedades dessas
classes, que são usadas como predicados no grafo RDF. Com isso é possível atribuir
valores às propriedades dessas classes, formando o catálogo.

Veja a especificação completa do padrão DCAT em [Data Catalog Vocabulary](https://www.w3.org/TR/vocab-dcat-3/).

## O perfil DCAT-BR

O perfil DCAT-BR é uma especificação sobre as classes `dcat:Dataset`, que
representa um conjunto de dados e a classe `dcat:Distribution`, que representa
um recurso (arquivo) do conjunto de dados. O perfil define as propriedades
que essas classes devem ter e os valores possíveis.

As tabelas a seguir mostram as propriedades definidas pelo perfil DCAT-BR para
as duas classes:

### Propriedades do cojunto de dados (classe `dcat:Dataset`)

| Propriedade RDF        | Classe RDF do Objeto Associado | Referência                   | Campo no Portal de Dados Abertos       |
|------------------------|--------------------------------|------------------------------|----------------------------------------|
| dct:title              | Literal                        | Texto livre                  | Título                                 |
| dct:description        | Literal                        | Texto livre                  | Descrição                              |
| dcat:license           | URI                            | Ver detalhes abaixo          | Licença de Uso                         |
| dct:accrualPeriodicity | Literal                        | Ver valores possíveis abaixo | Periodicidade de Atualização           |
| dct:accessRights       | Literal                        | Ver valores possíveis abaixo | Observância Legal                      |
| dct:publisher          | Literal                        | Texto livre                  | Área técnica responsável pelo dado     |
| dcat:contactPoint      | vcard:Organization             | Ver detalhes abaixo          | E-mail da área técnica responsável     |
| dcat:keyword           | Literal                        | Texto livre                  | Palavras-chave                         |
| adms:version           | Literal                        | Texto livre                  | Versão                                 |
| dcat:theme             | Literal                        | Ver valores possíveis abaixo | Tema associado ao conjunto de dados    |
| dcat:distribution      | dcat:Distribution              | Ver seção abaixo             | Recurso associado ao conjunto de dados |

#### Formato do campo licença de uso

A propriedade `dcat:license` deve estar associada a uma URL de alguma licença
definida em https://opendefinition.org/licenses.

Exemplo: https://opendefinition.org/licenses/cc-by-sa/ para a licença Creative
Commons Atributtion Share-Alike.

#### Valores possíveis para periodicidade de atualização

A propriedade `dct:accrualPeriodicity` deve estar associada a um dos valores
literais abaixo, indicando a frequência que os dados são atualizados:
* DIARIA
* SEMANAL
* QUINZENAL
* MENSAL
* TRIMESTRAL
* QUADRIMESTRAL
* SEMESTRAL
* ANUAL
* SOB\_DEMANDA
* OUTRAS

#### Valores possíveis para observância legal

A propriedade `dct:accessRights` deve estar associada a um dos valores literais
abaixo, indicando se o dado é público, restrito ou sigiloso de acordo com os
dispositivos legais indicados:
* Público
* Restrito - Direito Autoral (Lei nº 9.610/1998)
* Restrito - Informação Pessoal (Art. 31 da Lei nº 12.527/2011)
* Restrito - Propriedade Intelectual (software) (Lei nº 9.609/1998)
* Restrito - Protocolo pendente de análise de restrição (Art. 6º, III, da Lei nº 12.527/2011)
* Restrito - Restrição de Acesso a Documento Preparatório (Art. 7º, §3º, da Lei nº 12.527/2011)
* Restrito - Segredo de Justiça no Processo Civil (Art. 189 da Lei 13.105/2015)
* Restrito - Segredo de Justiça no Processo Penal (Art. 201, §6º, do Decreto-Lei 3.689/1941)
* Restrito - Segredo Industrial (Lei nº 9.279/1996)
* Restrito - Sigilo Comercial (Sociedades Anônimas) (Art. 155, § 2º da Lei nº 6.404/1976)
* Restrito - Sigilo Contábil (Art. 1.190 da Lei nº 10.406/2002)
* Restrito - Sigilo de nome, imagem, qualificação e demais info (Art. 5º, II da Lei 12.850/13)
* Restrito - Sigilo do Inquérito Policial (Art. 20 do Decreto-Lei 3.689/1941)
* Restrito - Sigilo do Procedimento Admin. Disciplinar em Curso (Art. 150 da Lei nº 8.112/1990)
* Restrito - Sigilo dos autos (Art. 7° da Resolução CNMP n° 23/2007)
* Restrito - Sigilo Empresarial (Art. 169 da Lei nº 11.101/2005)
* Restrito - Sigilo Funcional - SFC (Art. 26, §3º, da Lei nº 10.180/2001)
* Restrito - Sigilo por Possibilidade de Risco ou Dano (Art. 45 do Decreto nº 7.845/2012)
* Restrito - Sigilo Procedimento Admin. de Responsabilização (Art. 5º do Decreto nº 11.129/2022)
* Restrito - Sigilo Profissão do Advogado (Art. 7°, inciso II, da Lei n°11.767/2008)
* Sigiloso - Documento Preparatório - Sigiloso (Art. 7º, § 3º, da Lei nº 12.527/2001)
* Sigiloso - Informação Pessoal Sensível (Art. 31 da Lei nº 12.527/2011)
* Sigiloso - Reserva do Processo Ético (Art. 13 do Decreto nº 6.029/2007 e Art. 14 da Reso)
* Sigiloso - Segredo de Justiça no Processo Civil (Art. 189 da Lei 13.105/2015)
* Sigiloso - Segredo de Justiça no Processo Penal (Art. 201, §6º, do Decreto-Lei 3.689/1941)
* Sigiloso - Sigilo Bancário (Art. 1º da Lei Complementar nº 105/2001b)
* Sigiloso - Sigilo Fiscal (Art. 198, caput, da Lei nº 5.172/1966)
* Sigiloso - Sigilo de Acordo de Leniência (Art. 31, §1º, do Decreto nº 8.420/2015)
* Sigiloso - Sigilo de PAD em curso p/ servidores da CGU (Art. 150 da Lei nº 8.112/1990)
* Sigiloso - Sigilo do Inquérito Policial (Art. 20 do Decreto-Lei 3.689/1941)
* Sigiloso - Sigilo dos autos (Art. 7° da Resolução CNMP n° 23/2007)
* Sigiloso - Sigilo Funcional - SFC (Art. 26, §3º, da Lei nº 10.180/2001)
* Sigiloso - Sigilo Procedimento Administ. de Responsabilização (Art. 5º do Decreto nº 11.129/2022)
* Sigiloso - Sigilo Profissão de Advogado (Art. 7°, inciso II, da Lei n°11.767/2008)

#### Formato do e-mail da área técnica responsável

A propriedade `dcat:contactPoint` deve estar associada a um nó da classe
Organization (`vcard:Organization`) da ontologia vCard (ver https://www.w3.org/TR/vcard-rdf/#d4e2121).

O nó deve conter a propriedade `vcard:hasEmail` associado ao endereço de e-mail
da área responsável pelo dado.

#### Valores possíves para os temas

A propriedade `dcat:theme` deve estar associada a um dos valores possíveis abaixo:
* Abastecimento
* Administração
* Agropecuária, Pesca e Extrativismo
* Comércio e Serviços
* Comunicações
* Cultura
* Defesa Nacional
* Economia e Finanças
* Educação
* Energia
* Esporte e Lazer
* Habitação
* Indústria
* Infraestrutura e Fomento
* Meio Ambiente
* Pesquisa e Desenvolvimento
* Planejamento e Gestão
* Previdência Social
* Proteção Social
* Relações Internacionais
* Saneamento
* Saúde
* Segurança e Ordem Pública
* Trabalho
* Transportes
* Urbanismo

A propriedade pode ser definida mais de uma vez, indicando mais de um tema associado.

### Propriedades dos recursos (`dcat:Distribution`)

| Propriedade RDF | Classe RDF do Objeto Associado | Referência                   | Campo no Portal de Dados Abertos |
|-----------------|--------------------------------|------------------------------|----------------------------------|
| dcat:accessURL  | URI                            | URL para download do arquivo | URL                              |
| dct:format      | URI                            | Ver detalhes abaixo          | Formato                          |
| dct:title       | Literal                        | Texto livre                  | Título                           |
| dct:type        | Literal                        | Ver valores possíveis abaixo | Tipo do recurso                  |
| dct:description | Literal                        | Texto livre                  | Descrição                        |

#### Detalhes do campo formato

A propriedade `dct:format` deve estar associada a uma URL de um *media type*
definido no site da IANA (https://www.iana.org/assignments/media-types/media-types.xhtml).

Exemplo: https://www.iana.org/assignments/media-types/application/pdf para um arquivo PDF.

Alternativamente, a propriedade também pode estar associada a um valor literal
indicando a extensão do arquivo. Exemplo: "PDF".

#### Valores possíveis para o tipo

A propriedade `dct:type` deve estar associada a um dos valores possíveis abaixo:
* DADOS
* DICIONARIO_DE_DADOS
* DOCUMENTACAO
* API
* OUTRO