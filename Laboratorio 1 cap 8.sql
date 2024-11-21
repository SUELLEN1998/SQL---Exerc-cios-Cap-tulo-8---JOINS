

--Laboratório 1 

--A – Utilizando subconsultas

--Realize as consultas adiante:

--1. Coloque o banco PEDIDOS em uso;
 use PEDIDOS

--2. Selecione os clientes que não compraram em Março de 2019;
 SELECT NOME 
FROM TB_CLIENTE 
WHERE CODCLI NOT IN (SELECT CODCLI 
               FROM TB_PEDIDO 
               WHERE YEAR(DATA_EMISSAO) = 2019
                 AND MONTH(DATA_EMISSAO) = 3)

--3. Selecione os produtos que nunca foram vendidos; 
SELECT *
 FROM TB_PRODUTO 
WHERE ID_PRODUTO NOT IN (SELECT ID_PRODUTO 
                         FROM TB_ITENSPEDIDO)

--4. Apresente os cargos que não possuem funcionários cadastrados;
 SELECT CARGO
 FROM TB_CARGO 
WHERE COD_CARGO  NOT IN (SELECT COD_CARGO 
                         FROM TB_EMPREGADO
       WHERE COD_CARGO IS NOT NULL)

	   
--5. Apresente os produtos vendidos em Abril de 2018 que não são da cor PRATA;
 SELECT * 
FROM TB_PEDIDO AS PED
 WHERE YEAR(DATA_EMISSAO) = 2018
  AND MONTH(DATA_EMISSAO) = 4
  AND NOT EXISTS (SELECT * 
       FROM TB_ITENSPEDIDO AS ITEM

	     INNER JOIN TB_COR AS COR 
      ON COR.CODCOR = ITEM.CODCOR
      WHERE NUM_PEDIDO = PED.NUM_PEDIDO
        AND COR.COR =’PRATA’)

		
--6. Apresente os produtos que foram vendidos em abril de 2017, menos CHAVE DESMONTADO;
 SELECT * 
FROM TB_PRODUTO
 WHERE ID_PRODUTO IN(SELECT ID_PRODUTO
                 FROM TB_PEDIDO AS PED
                 INNER JOIN TB_ITENSPEDIDO AS ITEM
     ON ITEM.NUM_PEDIDO = PED.NUM_PEDIDO
                 WHERE YEAR(DATA_EMISSAO)= 2017
                   AND MONTH(DATA_EMISSAO) = 4)
   AND DESCRICAO<>’CHAVEIRO DESMONTADO’
   ORDER BY DESCRICAO

   
--7. Apresente os vendedores que não venderam em Dezembro de 2012;
 SELECT *
 FROM TB_VENDEDOR AS VEND
 WHERE CODVEN NOT IN (SELECT DISTINCT CODVEN
                  FROM TB_PEDIDO AS PED
                  WHERE YEAR(DATA_EMISSAO)= 2012
                    AND MONTH(DATA_EMISSAO) = 12)

					
--8. Apresente os clientes que compraram em Fevereiro de 2014, produtos da cor AZUL;
 SELECT * 
FROM TB_CLIENTE 
WHERE CODCLI IN 
(
 SELECT CODCLI
 FROM TB_PEDIDO AS PED
 INNER JOIN TB_ITENSPEDIDO AS ITEM
 ON ITEM.NUM_PEDIDO = PED.NUM_PEDIDO
INNER JOIN TB_COR AS COR 
 ON COR.CODCOR = ITEM.CODCOR
 WHERE YEAR(DATA_EMISSAO)= 2014
 AND  MONTH(DATA_EMISSAO) = 2
 AND  COR.COR=’AZUL’)

 
--9. Apresente os empregados que não possuem dependentes e cargo que não seja Motorista;
 SELECT *
 FROM TB_EMPREGADO AS EMP
 WHERE NOT EXISTS (SELECT * 
                  FROM TB_DEPENDENTE 
      WHERE CODFUN=EMP.CODFUN)
 AND COD_CARGO NOT IN (SELECT COD_CARGO 
                      FROM TB_CARGO 
       WHERE CARGO=’Motorista’)
