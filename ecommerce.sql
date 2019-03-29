
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
                telefone VARCHAR(50),
                endereco VARCHAR(50),
                email VARCHAR(255),
                idcidade INTEGER NOT NULL,
                CONSTRAINT idpessoa PRIMARY KEY (idpessoa)
);


ALTER SEQUENCE public.pessoa_idpessoa_seq OWNED BY public.pessoa.idpessoa;

CREATE TABLE public.pessoaJuridica (
                idPessoaJuridica INTEGER NOT NULL,
                cnpj CHAR(20) NOT NULL,
                CONSTRAINT idpessoajuridica PRIMARY KEY (idPessoaJuridica)
);


CREATE TABLE public.pessoaFisica (
                idPessoaFisica INTEGER NOT NULL,
                cpf CHAR(11) NOT NULL,
                rg VARCHAR(15) NOT NULL,
                dtNasc VARCHAR NOT NULL,
                CONSTRAINT idpessoafisica PRIMARY KEY (idPessoaFisica)
);


CREATE SEQUENCE public.movimento_idmov_seq;

CREATE TABLE public.movimento (
                idmov INTEGER NOT NULL DEFAULT nextval('public.movimento_idmov_seq'),
                dtvenda DATE NOT NULL,
                tipoMovimento BOOLEAN NOT NULL,
                idPessoaFisica INTEGER,
                idPessoaJuridica INTEGER,
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

ALTER TABLE public.pessoaFisica ADD CONSTRAINT pessoa_pessoaFisica_fk
FOREIGN KEY (idPessoaFisica)
REFERENCES public.pessoa (idpessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pessoaJuridica ADD CONSTRAINT pessoa_pessoaJuridica_fk
FOREIGN KEY (idPessoaJuridica)
REFERENCES public.pessoa (idpessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.movimento ADD CONSTRAINT pessoajuridica_movimento_fk
FOREIGN KEY (idPessoaJuridica)
REFERENCES public.pessoaJuridica (idPessoaJuridica)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.movimento ADD CONSTRAINT pessoaFisica_idvend_fk
FOREIGN KEY (idPessoaFisica)
REFERENCES public.pessoaFisica (idPessoaFisica)
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
('pessoaJuridicaa Ambev', 'Rua das Nações','34421515','beer@gmail.com',5),
('pessoaJuridicaa Adega Brasil', 'Rua do Irineu','34421515','bebidasCia@gmail.com',5),
('pessoaJuridicaa Spaipa', 'Rua Groove', '34221190','diversity@gmail.com',4),
('José Amado', 'Rua do ABC','30451120', 'amador@hotmail.com',1),
('Ana Maria', 'Rua João da Silva', '30456711','anamaria@outlook.com',1),
('João Desah Parecido', 'Avenida do Caneco','31459212', 'jao123@yahoo.com',2),
('Bruce Li', 'Rodovia BR 376', '34239763','libruce@hotmail.com',3),
('Josefina Lima', 'Rua Almirante', '34231121', 'jose@gmail.com', 1),
('Abrilina Décima', 'Rua do Nunca','34228712','abril1na@gmail.com',4),
('Amin Amou', 'Avenida Parigot', '31458231','amado@yahoo.com.br', 2),
('Jacinto Leite','Rua do Amanhã', '34239812','jacin123@gmail.com',1),
('Manoel Igualdade','Rua Amampá', '34231212','mano@gmail.com',1); 

INSERT INTO pessoaFisica(idPessoaFisica, cpf, rg, dtNasc) VALUES
(4,'81459143027','448806228','1998-12-11'),
(5,'94202065050','267840858','1982-05-10'),
(6,'16160812017','378112247','1970-04-09'),
(7,'02765336075','103573355','1998-11-03'),
(8,'53300858020','497873643','1995-01-02'),
(9,'51583614010','225069684','1994-02-06'),
(10,'49924003020','224492731','1930-11-05'),
(11,'98962117010','470223832','2002-04-12'),
(12,'97809538098','419428884','1940-12-12');

INSERT INTO pessoaJuridica(idpessoaJuridica, cnpj) VALUES
(1,'43.541.228/0001-00'),
(2,'35.763.037/0001-56'),
(3,'30.051.110/0001-43');

INSERT INTO movimento(dtvenda, tipoMovimento, idPessoaFisica, idPessoaJuridica) VALUES /*um dos id é null, pois ou é pessoaFisica, ou pessoaJuridica*/ 
/*True é uma venda, False é uma compra*/
('2018-11-20', True ,NULL,1), /*ULTIMO CAMPO FOI UMA COMPRA/VENDA DO pessoaJuridica*/
('2018-11-21', False ,NULL,1),
('2018-11-25', True ,NULL,2),
('2018-11-20', False ,NULL,2),
('2018-11-21', False ,NULL,3),
('2018-11-25', False ,NULL,3),
('2016-05-02', True ,4,NULL), /*PENULTIMA FOI UMA VENDA PARA pessoaFisica*/
('2018-11-04', True ,4,NULL),
('2018-11-05', True ,5,NULL),
('2018-11-04', True ,5,NULL),
('2018-11-05', True ,6,NULL),
('2018-11-04', True ,6,NULL);

INSERT INTO produto (nome, qtdeest, qtdemin, precovenda) /*Alterar produtos*/
VALUES ('HD externo 1 TB', 90, 20, 230.00),
       ('HD externo 2 TB', 48, 12, 400.50),
       ('HD externo 2 TB', 48, 12, 400.50),
       ('HD externo 2 TB', 48, 12, 400.50),
       ('HD externo 2 TB', 48, 12, 400.50),
       ('HD externo 2 TB', 48, 12, 400.50),
       ('HD externo 2 TB', 48, 12, 400.50),
       ('HD externo 2 TB', 48, 12, 400.50),
       ('HD externo 2 TB', 48, 12, 400.50),
       ('HD externo 2 TB', 48, 12, 400.50),
       ('HD externo 2 TB', 48, 12, 400.50),
       ('HD externo 2 TB', 48, 12, 400.50),
       ('HD externo 2 TB', 48, 12, 400.50),
       ('HD externo 2 TB', 48, 12, 400.50),
       ('HD externo 2 TB', 48, 12, 400.50),
       ('HD externo 2 TB', 48, 12, 400.50);

/*alterar tudo isso*/
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

/*SELECTS A SEREM ALTERADOS*/

/*Fazer um balanço financeiro MENSALMENTE para ter uma noção das DESPESAS em compras com o pessoaJuridica.*/
SELECT pessoa.nome"Nome da Empresa Juridica", movimento.dtvenda"Data da Compra", movimento.tipoMovimento, (itens_mov.preco*qtde)"Preço Total", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa INNER JOIN pessoaJuridica
ON pessoa.idpessoa = pessoaJuridica.idPessoaJuridica
INNER JOIN movimento
ON pessoaJuridica.idPessoaJuridica = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod
WHERE dtvenda BETWEEN '2018-11-01' AND '2018-11-30' AND tipomovimento = False;


/*Fazer um balanço financeiro MENSALMENTE para se ter uma noção da margem de lucro com Pessoas Físicas.*/
SELECT pessoa.nome"Nome da pessoa fisica", movimento.dtvenda"Data da Venda", (itens_mov.preco*qtde)"Preço", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa 
LEFT JOIN pessoaFisica
ON pessoa.idpessoa = pessoaFisica.idPessoaFisica
INNER JOIN movimento
ON pessoaFisica.idPessoaFisica = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod
WHERE dtvenda BETWEEN '2018-11-01' AND '2019-11-30';

/*Fazer um balanço financeiro MENSALMENTE para se ter uma noção da margem de lucro com Pessoas Juridicas.*/
SELECT pessoa.nome"Nome da pessoa juridica", movimento.dtvenda"Data da Venda",movimento.tipoMovimento, (itens_mov.preco*qtde)"Preço", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa 
INNER JOIN pessoaJuridica
ON pessoa.idpessoa = pessoaJuridica.idPessoaJuridica
INNER JOIN movimento
ON pessoaJuridica.idPessoaJuridica = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod
WHERE dtvenda BETWEEN '2018-11-01' AND '2019-11-30' AND tipoMovimento = True ;


/*Fazer um balanço financeiro DIARIAMENTE para ter um controle sobre as receitas com Pessoas Fisicas*/
SELECT pessoa.nome"Nome da Pessoa Fisica", movimento.dtvenda"Data da Venda", (itens_mov.preco*qtde)"Preço", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa INNER JOIN pessoaFisica
ON pessoa.idpessoa = pessoaFisica.idPessoaFisica
INNER JOIN movimento
ON pessoaFisica.idPessoaFisica = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod
WHERE dtvenda BETWEEN '2018-11-25' AND '2018-11-25';

/*Fazer um balanço financeiro DIARIAMENTE para ter um controle sobre as receitas com Pessoas Juridicas*/
SELECT pessoa.nome"Nome da Pessoa Fisica", movimento.dtvenda"Data da Venda", movimento.tipoMovimento, (itens_mov.preco*qtde)"Preço", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa INNER JOIN pessoaJuridica
ON pessoa.idpessoa = pessoaJuridica.idPessoaJuridica
INNER JOIN movimento
ON pessoaJuridica.idPessoaJuridica = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod
WHERE dtvenda BETWEEN '2018-11-25' AND '2018-11-25' AND tipoMovimento = True;


/*Fazer um balanço financeiro DIARIAMENTE para ter um controle sobre as despesas*/
SELECT pessoa.nome"Nome da PessoaJuridica", movimento.dtvenda"Data da Compra",movimento.tipoMovimento, (itens_mov.preco*qtde)"Preço Total", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa INNER JOIN pessoaJuridica
ON pessoa.idpessoa = pessoaJuridica.idPessoaJuridica
INNER JOIN movimento
ON pessoaJuridica.idPessoaJuridica = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod
WHERE dtvenda BETWEEN '2018-11-25' AND '2018-11-25' AND tipoMovimento = False; /*colocar itens */



/*Relação de todos os clientes -vendas- histórico*/
SELECT pessoa.nome"Nome do Cliente", movimento.dtvenda"Data da Venda", (itens_mov.preco*qtde)"Preço", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa INNER JOIN pessoaFisica
ON pessoa.idpessoa = pessoaFisica.idPessoaFisica
INNER JOIN movimento
ON pessoaFisica.idPessoaFisica = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod;

/*Relação de todos as Pessoas Juridicas -Compras- histórico*/
SELECT pessoa.nome"Nome da Pessoa Juridica", movimento.dtvenda"Data da Compra", (itens_mov.preco*qtde)"Preço Total", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa INNER JOIN pessoaJuridica
ON pessoa.idpessoa = pessoaJuridica.idPessoaJuridica
INNER JOIN movimento
ON pessoaJuridica.idPessoaJuridica = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod  AND tipoMovimento = False;

/*Relação de todos as Pessoas Juridicas -Vendas- histórico*/
SELECT pessoa.nome"Nome da Pessoa Juridica", movimento.dtvenda"Data da Compra", (itens_mov.preco*qtde)"Preço Total", itens_mov.qtde"Quantidade", produto.nome"Nome do Produto"
FROM pessoa INNER JOIN pessoaJuridica
ON pessoa.idpessoa = pessoaJuridica.idPessoaJuridica
INNER JOIN movimento
ON pessoaJuridica.idPessoaJuridica = movimento.idmov
INNER JOIN itens_mov
ON movimento.idmov = itens_mov.idmov_mov
INNER JOIN produto
ON itens_mov.idprod_mov = produto.idprod AND tipoMovimento = True;

/*Permitir a busca pela quantidade do produto em estoque, para se ter noção dos produtos armazenados*/
SELECT nome"Nome do Produto", qtdeEst"Quantidade em estoque" FROM produto;

/*Viabilizar a consulta por um determinado produto, para possíveis alterações futuras. */
SELECT nome"Nome do Produto", qtdeest"Quantidade em estoque", qtdemin"Quantidade Mínima",precovenda"Preço" FROM produto
WHERE nome LIKE '%H%'; 

/*Permitir fazer a busca de fornecedores pelo nome, para possíveis alterações futuras*/
SELECT pessoa.nome"Nome da PessoaJuridica",pessoa.telefone"Telefone",pessoa.endereco"Endereço",pessoa.email"Email",pessoaJuridica.cnpj"CNPJ",cidade.nome"Cidade",estado.nome"Estado"
FROM pessoa INNER JOIN pessoaJuridica
ON pessoa.idpessoa = pessoaJuridica.idPessoaJuridica
INNER JOIN cidade
ON pessoa.idcidade = cidade.idcidade
INNER JOIN estado
ON estado.idestado = cidade.idestado
WHERE pessoa.nome LIKE '%p%';

/*Permitir fazer a busca de clientes pelo nome, para possíveis alterações futuras*/
SELECT pessoa.nome"Nome da Pessoa",pessoa.telefone"Telefone",pessoa.endereco"Endereço",pessoa.email"Email", pessoaFisica.cpf"CPF", pessoaFisica.rg"RG",pessoaFisica.dtNasc"Data de Nasc",cidade.nome"Cidade",estado.nome"Estado"
FROM pessoa INNER JOIN pessoaFisica
ON pessoa.idpessoa = pessoaFisica.idPessoaFisica
INNER JOIN cidade
ON pessoa.idcidade = cidade.idcidade
INNER JOIN estado
ON estado.idestado = cidade.idestado
WHERE pessoa.nome LIKE '%a%';
