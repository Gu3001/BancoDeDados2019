
/*Increment 2, de dois em dois
min = valor min
max = valor max
start 150
cycle = while
vídeo aula da kessia

nestval, incrementa
intdefault = valor padrão no campo
nextval(“id_teste”) = proximo valor
*/
/* AULA 1 - Auto incremento com CREATE SEQUENCE*/

CREATE SEQUENCE idTeste;
CREATE TABLE teste(
idTeste INT DEFAULT nextval('idTeste') PRIMARY KEY,
nome VARCHAR(100) NOT NULL
);
INSERT INTO teste(nome) VALUES
('Maria'),
('João');


/*AULA 2*/
/*tipo definidos pelos usuários - UDF - composição de dados, DDL, Verificar na aba tipos*/
CREATE TYPE endereco AS (rua VARCHAR(100), numero VARCHAR(5), bairro VARCHAR(30)); /*ATRIBUSTOS QUE COMPÕE ENDEREÇO*/

CREATE TABLE pessoa(
idpessoa INT NOT NULL PRIMARY KEY,
nome VARCHAR(80) NOT NULL,
endereco endereco
)

INSERT INTO pessoa VALUES
(1,'José', ('Rua A','123','Centro') ),
(2,'Maria', ('Rua B','456','Centro') );

/*AULA 3 - INTEGRIDADE DE DOMINIO, dados que serão permitidos alterar, excluir e editar da tabela, criando dominios*/
/*validando o CPF, RESTRIÇÕES DE INTEGRIDADE
~' ' = possui
^\d  = inciar com números 
{11} = limite de 11 números
$    = finaliza
add = adiciona regra, atributos, índices e etc
*/
CREATE DOMAIN cpfCheck TEXT CONSTRAINT regraCpf CHECK(VALUE ~'^\d{11}$')/*vai avaliar se tem 11 dígitos e se tem só números*/
ALTER TABLE pessoa ADD cpf cpfCheck; /*adicionou o cpf com regra*/

INSERT INTO pessoa VALUES(3,'Lenon',('Rua c', 123, 'Centro'), '12312312312');
