# Aplicação simples de Core Data em Swift

Esta aplicação permite adicionar Marcas (nome e slogan) e dentro de uma marca é possível adicionar Produtos (nome e preço). *Nesta versão não é possível remover ou alterar os dados salvos*

O modelo utilizado é o seguinte:

+---------------+                  +-----------------+

|     Marca     |                  |     Produto     |

|---------------|  <---------->>   +-----------------+

| nome          |                  | nome            |

| slogan        |                  | preco           |

|               |                  |                 |

| produtos      |                  | marca           |

+---------------+                  +-----------------+


### Trocando para outras versões
Este repositório possui alguns exemplos de uso de Core Data. Até o momento da escrita deste README existem 3 branchs com as seguintes caracterísitcas

*  **master**        - Vesão atual, contém uma aplicação que permite cadastrar e consultar Marcas e seus respectivos produtos
*  **v2.0**          - Versão que permite excluir e alterar as Marcas e Produtos
*  **v3.0_WatchKit** - Versão v2.0 com app para Apple Watch

Para alternar entre as versões em seu computador utilize o seguinte comando: `git checkout <nome da branch>`

```
git checkout master
git checkout v2.0
git checkout v3.0_WatchKit
```

Para saber mais sobre como usar branchs leia este guia: [Clique Aqui](http://git-scm.com/book/pt-br/v1/Ramificação-Branching-no-Git-Básico-de-Branch-e-Merge)
