﻿

CREATE SEQUENCE public.produto_idprod_seq;

CREATE TABLE public.produto (
                idprod INTEGER NOT NULL DEFAULT nextval('public.produto_idprod_seq'),
                nome VARCHAR(80) NOT NULL,
                qtdeest INTEGER NOT NULL,
                qtdemin INTEGER NOT NULL,
                precovenda NUMERIC(6,2) NOT NULL,
                CONSTRAINT idprod PRIMARY KEY (idprod)
);


ALTER SEQUENCE public.produto_idprod_seq OWNED BY public.produto.idprod;

CREATE SEQUENCE public.estado_idestado_seq_1;

CREATE TABLE public.estado (
                idestado INTEGER NOT NULL DEFAULT nextval('public.estado_idestado_seq_1'),
                nome VARCHAR(50) NOT NULL,
                sigla CHAR(2) NOT NULL,
                CONSTRAINT idestado PRIMARY KEY (idestado)
);


ALTER SEQUENCE public.estado_idestado_seq_1 OWNED BY public.estado.idestado;

CREATE SEQUENCE public.cidade_idcidade_seq;

CREATE TABLE public.cidade (
                idcidade INTEGER NOT NULL DEFAULT nextval('public.cidade_idcidade_seq'),
                nome VARCHAR(50) NOT NULL,
                idestado INTEGER NOT NULL,
                CONSTRAINT idcidade PRIMARY KEY (idcidade)
);


ALTER SEQUENCE public.cidade_idcidade_seq OWNED BY public.cidade.idcidade;

CREATE SEQUENCE public.pessoa_idpessoa_seq;

CREATE TABLE public.pessoa (
                idpessoa INTEGER NOT NULL DEFAULT nextval('public.pessoa_idpessoa_seq'),
                nome VARCHAR(100) NOT NULL,
                telefone VARCHAR(20),
                endereco VARCHAR(50),
                email VARCHAR(255),
                idcidade INTEGER NOT NULL,
                CONSTRAINT idpessoa PRIMARY KEY (idpessoa)
);


ALTER SEQUENCE public.pessoa_idpessoa_seq OWNED BY public.pessoa.idpessoa;

CREATE TABLE public.fornecedor (
                idPessoaFornecedor INTEGER NOT NULL,
                cnpj CHAR(20) NOT NULL,
                CONSTRAINT idpessoafornecedor PRIMARY KEY (idPessoaFornecedor)
);


CREATE TABLE public.cliente (
                idPessoaCliente INTEGER NOT NULL,
                cpf CHAR(11) NOT NULL,
                rg VARCHAR(15) NOT NULL,
                dtNasc VARCHAR NOT NULL,
                CONSTRAINT idpessoacliente PRIMARY KEY (idPessoaCliente)
);


CREATE SEQUENCE public.movimento_idmov_seq;

CREATE TABLE public.movimento (
                idmov INTEGER NOT NULL DEFAULT nextval('public.movimento_idmov_seq'),
                dtvenda DATE NOT NULL,
                idfornecedor INTEGER,
                idcliente INTEGER,
                CONSTRAINT idmov PRIMARY KEY (idmov)
);


ALTER SEQUENCE public.movimento_idmov_seq OWNED BY public.movimento.idmov;

CREATE TABLE public.itens_mov (
                idmov_mov INTEGER NOT NULL,
                idprod_mov INTEGER NOT NULL,
                qtde INTEGER NOT NULL,
                preco NUMERIC(6,2) NOT NULL,
                CONSTRAINT iditens_mov PRIMARY KEY (idmov_mov, idprod_mov)
);


ALTER TABLE public.itens_mov ADD CONSTRAINT idprod_itens_venda_fk
FOREIGN KEY (idprod_mov)
REFERENCES public.produto (idprod)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cidade ADD CONSTRAINT estado_cidade_fk
FOREIGN KEY (idestado)
REFERENCES public.estado (idestado)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pessoa ADD CONSTRAINT cidade_pessoa_fk
FOREIGN KEY (idcidade)
REFERENCES public.cidade (idcidade)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.cliente ADD CONSTRAINT pessoa_cliente_fk
FOREIGN KEY (idPessoaCliente)
REFERENCES public.pessoa (idpessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.fornecedor ADD CONSTRAINT pessoa_fornecedor_fk
FOREIGN KEY (idPessoaFornecedor)
REFERENCES public.pessoa (idpessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.movimento ADD CONSTRAINT fornecedor_idvend_fk
FOREIGN KEY (idcliente)
REFERENCES public.fornecedor (idPessoaFornecedor)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.movimento ADD CONSTRAINT cliente_idvend_fk
FOREIGN KEY (idfornecedor)
REFERENCES public.cliente (idPessoaCliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.itens_mov ADD CONSTRAINT idvend_itens_venda_fk
FOREIGN KEY (idmov_mov)
REFERENCES public.movimento (idmov)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

INSERT INTO estado(nome, sigla) VALUES
('PARANÁ','PR'),
('SÃO PAULO','SP'),
('RIO DE JANEIRO','RJ');

INSERT INTO cidade(nome,idestado) VALUES
('Maringá', 1),
('Paranavaí', 1),
('Marilena', 1),
('Campinas', 2),
('Petrópolis', 3);


INSERT INTO pessoa(nome,telefone, endereco, email, idcidade) VALUES
('Fornecedora Ambev', 'Rua das Nações','34421515','beer@gmail.com',5),
('Fornecedora Adega Brasil', 'Rua do Irineu','34421515','bebidasCia@gmail.com',5),
('Fornecedora Spaipa', 'Rua Groove', '34221190','diversity@gmail.com',4),
('José Amado', 'Rua do ABC','30451120', 'amador@hotmail.com',1),
('Ana Maria', 'Rua João da Silva', '30456711','anamaria@outlook.com',1),
('João Desah Parecido', 'Avenida do Caneco','31459212', 'jao123@yahoo.com',2),
('Bruce Li', 'Rodovia BR 376', '34239763','libruce@hotmail.com',3),
('Josefina Lima', 'Rua Almirante', '34231121', 'jose@gmail.com', 1),
('Abrilina Décima', 'Rua do Nunca','34228712','abril1na@gmail.com',4),
('Amin Amou', 'Avenida Parigot', '31458231','amado@yahoo.com.br', 2),
('Jacinto Leite','Rua do Amanhã', '34239812','jacin123@gmail.com',1),
('Manoel Igualdade','Rua Amampá', '34231212','mano@gmail.com',1); /*Arrumar----------------------*/

INSERT INTO cliente(idPessoaCliente, cpf, rg, dtNasc) VALUES
(4,'81459143027','448806228','1998-12-11'),
(5,'94202065050','267840858','1982-05-10'),
(6,'16160812017','378112247','1970-04-09'),
(7,'02765336075','103573355','1998-11-03'),
(8,'53300858020','497873643','1995-01-02'),
(9,'51583614010','225069684','1994-02-06'),
(10,'49924003020','224492731','1930-11-05'),
(11,'98962117010','470223832','2002-04-12'),
(12,'97809538098','419428884','1940-12-12');

INSERT INTO fornecedor(idpessoaFornecedor, cnpj) VALUES
(1,'43.541.228/0001-00'),
(2,'35.763.037/0001-56'),
(3,'30.051.110/0001-43');

INSERT INTO movimento(dtvenda, idfornecedor, idcliente) VALUES /*um dos id é null, pois ou é cliente, ou fornecedor*/ 

('2018-11-20',NULL,1), /*ULTIMO CAMPO FOI UMA COMPRA DO FORNECEDOR*/
('2018-11-21',NULL,1),
('2018-11-25',NULL,2),
('2018-11-20',NULL,2),
('2018-11-21',NULL,3),
('2018-11-25',NULL,3),
('2016-05-02',4,NULL), /*PENULTIMA FOI UMA VENDA PARA CLIENTE*/
('2018-11-04',4,NULL),
('2018-11-05',5,NULL),
('2018-11-04',5,NULL),
('2018-11-05',6,NULL),
('2018-11-04',6,NULL);
 


INSERT INTO produto (nome, qtdeest, qtdemin, precovenda)
VALUES ('Skol 300 Ml', 96, 24, 3.00),
       ('Skol 350 Ml', 48, 12, 3.50),
       ('Skol 600 Ml', 144, 48, 6.50),
       ('Skol 650 Ml', 144, 48, 7.50),
       ('Skol 1 L', 48, 12, 7.00),
       ('Brahma 300 Ml', 96, 24, 3.00),
       ('Brahma 350 Ml', 48, 12, 3.00),
       ('Brahma 600 ML', 144, 48, 6.50),
       ('Brahma 650 Ml', 144, 48, 7.50),
       ('Brahma 1 L', 48, 12, 10.00),
       ('Subzero 350 Ml', 36, 12, 3.00),
       ('Subzero 600 Ml', 120, 24, 5.00),
       ('Subzero 650 Ml', 120, 24, 6.00),
       ('Subzero 1 L', 36, 12, 6.50),
       ('Brahma Extra 600 Ml', 48, 24, 6.50),
       ('Brahma Extra 650 Ml', 48, 24, 7.50),
       ('Antartica Original 600 Ml', 48, 24, 8.00),
       ('Antartica Original 650 Ml', 48, 24, 9.00),
       ('Budweiser 600 Ml', 48, 24, 6.50),
       ('Budweiser 650 Ml', 48, 24, 7.50),
       ('Guaraná Antartica 2 L', 12, 6, 7.00),
       ('Guaraná Antartica 350 Ml', 12, 6, 3.00),
       ('Guaraná Antartica 290 Ml', 48, 24, 3.00),
       ('Coca Cola 290 Ml', 72, 24, 3.00),
       ('Coca Cola 350 Ml', 24, 2, 3.50),
       ('Coca Cola 600 Ml', 24, 12, 4.50),
       ('Coca Cola 1 L', 24, 12, 5.00),
       ('Coca Cola 2 L', 12, 6, 8.00),
       ('Tubaina Funada 2 L', 12, 6, 6.00),
       ('Tubaina Funada 600 Ml', 48, 24, 3.00),
       ('Sodinha', 72, 24, 2.00),
       ('Guaraná Funada 2 L', 12, 6, 6.00),
       ('Fanta 290 Ml', 72, 24, 3.00),
       ('Fanta 350 Ml', 24, 12, 3.50),
       ('Fanta 2 L', 12, 6, 7.00),
       ('Agua Tonica 290 Ml', 48, 24, 3.00),
       ('Brahma Sem Álcool 350 Ml', 20, 2, 4.00),
       ('Brahma Sem Álcool 350 Ml', 20, 2, 5.00),
       ('H2OH Limoneto 500 Ml', 16, 3, 4.50),
       ('H2OH Limoneto 550 Ml', 16, 3, 5.50),
       ('Dose de Pinga', 10, 2, 1.50),
       ('Paçoca', 30, 2, 0.50),
       ('Canudinho Doce de Leite', 30, 2, 0.50),
       ('Amendoim Salgado Pacote', 24, 2, 2.00);

INSERT INTO itens_mov(idmov_mov,idprod_mov,qtde,preco) VALUES
(1,1,20,'3.00'), /*Atenção repita o preço do produto, pois ficará no histórico, a tabela produto pode ter seus preços alterados*/
(1,2,10,'3.50'),
(2,3,20,'6.50'),
(2,4,30,'7.50'),
(3,5,30,'7.00'),
(3,6,20,'3.00'),
(4,7,2,'3.00'),
(4,8,2,'6.50'),
(5,9,2,'7.50'),
(5,10,2,'10.00'),
(6,11,2,'3.00'),
(6,12,2,'5.00');

/*Fazer um balanço financeiro MENSALMENTE para ter uma noção das despesas em compras com o fornecedor.*/
SELECT pessoa.nome"Nome da Fornecedora", movimento.dtvenda"Data da Compra", (itens_mov.preco*qtde)"Preço Total", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa INNER JOIN fornecedor
ON pessoa.idpessoa = fornecedor.idPessoaFornecedor
INNER JOIN movimento
ON fornecedor.idPessoaFornecedor = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod
WHERE dtvenda BETWEEN '2018-11-01' AND '2018-11-30';

/*Fazer um balanço financeiro MENSALMENTE para se ter uma noção da margem de lucro.*/
SELECT pessoa.nome"Nome do Cliente", movimento.dtvenda"Data da Venda", (itens_mov.preco*qtde)"Preço", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa INNER JOIN cliente
ON pessoa.idpessoa = cliente.idPessoaCliente
INNER JOIN movimento
ON cliente.idPessoaCliente = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod
WHERE dtvenda BETWEEN '2018-11-01' AND '2018-11-30';

/*Fazer um balanço financeiro DIARIAMENTE para ter um controle sobre as receitas*/
SELECT pessoa.nome"Nome do Cliente", movimento.dtvenda"Data da Venda", (itens_mov.preco*qtde)"Preço", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa INNER JOIN cliente
ON pessoa.idpessoa = cliente.idPessoaCliente
INNER JOIN movimento
ON cliente.idPessoaCliente = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod
WHERE dtvenda BETWEEN '2018-11-25' AND '2018-11-25';


/*Fazer um balanço financeiro DIARIAMENTE para ter um controle sobre as despesas*/
SELECT pessoa.nome"Nome da Fornecedora", movimento.dtvenda"Data da Compra", (itens_mov.preco*qtde)"Preço Total", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa INNER JOIN fornecedor
ON pessoa.idpessoa = fornecedor.idPessoaFornecedor
INNER JOIN movimento
ON fornecedor.idPessoaFornecedor = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod
WHERE dtvenda BETWEEN '2018-11-25' AND '2018-11-25';



/*Relação de todos os clientes -vendas- histórico*/
SELECT pessoa.nome"Nome do Cliente", movimento.dtvenda"Data da Venda", (itens_mov.preco*qtde)"Preço", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa INNER JOIN cliente
ON pessoa.idpessoa = cliente.idPessoaCliente
INNER JOIN movimento
ON cliente.idPessoaCliente = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod;

/*Relação de todos os Fornecedores -Compras- histórico*/
SELECT pessoa.nome"Nome da Fornecedora", movimento.dtvenda"Data da Compra", (itens_mov.preco*qtde)"Preço Total", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa INNER JOIN fornecedor
ON pessoa.idpessoa = fornecedor.idPessoaFornecedor
INNER JOIN movimento
ON fornecedor.idPessoaFornecedor = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod;

/*Permitir a busca pela quantidade do produto em estoque, para se ter noção dos produtos armazenados*/
SELECT nome"Nome do Produto", qtdeEst"Quantidade em estoque" FROM produto;

/*Viabilizar a consulta por um determinado produto, para possíveis alterações futuras. */
SELECT nome"Nome do Produto", qtdeest"Quantidade em estoque", qtdemin"Quantidade Mínima",precovenda"Preço" FROM produto
WHERE nome LIKE '%Br%'; 

/*Permitir fazer a busca de fornecedores pelo nome, para possíveis alterações futuras*/
SELECT pessoa.nome"Nome da Fornecedora",pessoa.telefone"Telefone",pessoa.endereco"Endereço",pessoa.email"Email",fornecedor.cnpj"CNPJ",cidade.nome"Cidade",estado.nome"Estado"
FROM pessoa INNER JOIN fornecedor
ON pessoa.idpessoa = fornecedor.idPessoaFornecedor
INNER JOIN cidade
ON pessoa.idcidade = cidade.idcidade
INNER JOIN estado
ON estado.idestado = cidade.idestado
WHERE pessoa.nome LIKE '%For%';

/*Permitir fazer a busca de clientes pelo nome, para possíveis alterações futuras*/
SELECT pessoa.nome"Nome da Pessoa",pessoa.telefone"Telefone",pessoa.endereco"Endereço",pessoa.email"Email", cliente.cpf"CPF", cliente.rg"RG",cliente.dtNasc"Data de Nasc",cidade.nome"Cidade",estado.nome"Estado"
FROM pessoa INNER JOIN cliente
ON pessoa.idpessoa = cliente.idPessoaCliente
INNER JOIN cidade
ON pessoa.idcidade = cidade.idcidade
INNER JOIN estado
ON estado.idestado = cidade.idestado
WHERE pessoa.nome LIKE '%a%';

