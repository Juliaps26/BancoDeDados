create database concessionaria;

use concessionaria;

create table carros
(
	id_carros int primary key,
    nome_carro varchar(100),
    descricao varchar(100),
    preco numeric,
    categoria varchar(50),
    quant_estoque integer
);

insert into carros(id_carros, nome_carro, descricao, preco, categoria, quant_estoque)values
(1, "HB20", "Cinza, 4 portas", 66.699, "Hatch", 50),
(2, "Santana", "Azul, 4 portas", 17.118, "Sedan", 15),
(3, "Creta", "Branco, 5 portas", 112.690, "SUV", 50);

create table clientes
(
	cliente_id int primary key,
    nome_cliente varchar(100),
    cpf bigint,
    endereco varchar(200),
    telefone bigint,
    email_cliente varchar(50)
);

insert into clientes (cliente_id, nome_cliente, cpf, endereco, telefone, email_cliente)values
(1, "Julia Silva", 12345678-90, "Vila Menk - Carapicuíba", 11959449434, "juliasilva@gmail.com"),
(2, "Kaike Bueno", 09876543-21, "Cohab - Carapicuiba", 11975353670, "kaikebueno@gmail.com"),
(3, "Jael Gomes", 10293845-76, "Macarani - Bahia", 1972870187, "jaelgomes@gmail.com");

create table compras
(
	id int primary key,
    cliente_id integer, 
    data_compra date,
    total numeric,
    
    foreign key (cliente_id) references clientes(cliente_id)
);



insert into compras (id, cliente_id, data_compra, total)values
(1, 1, "2023-08-08", 66.699),
(2, 3, "2015-12-14", 17.118),
(3, 2, "1989-10-13", 112.690);

create table carros_compra
(
	id int primary key,
    compra_id integer,
    carro_id integer,
    quantidade integer,
    subtotal numeric,
    
    foreign key (compra_id) references compras (id),
    foreign key (carro_id) references carros (id_carros)
);

insert into carros_compra (id, compra_id, carro_id, quantidade, subtotal)values
(1, 1, 1, 4, 266.796),
(2, 2, 3, 2, 34.236),
(3, 3, 2, 3, 338.070);

create table estoque
(
	id int primary key,
    carro_id integer,
    quant_estoque integer,
    
    foreign key (carro_id) references carros (id_carros)
);

insert into estoque (id, carro_id, quant_estoque)values
(1, 1, 50),
(2, 2, 15),
(3, 3, 50);


-- Atividades

-- Escreva uma consulta para listar todos os carros disponíveis na loja.

select * from carros;


-- Recupere os detalhes de um carro específico usando seu ID. 
-- Selecionar a tabela carros especificando o carro usando where e seu id 

select * from carros where id_carros =1;

-- Mostre o nome, o CPF e o e-mail de todos os clientes cadastrados.

select nome_cliente,cpf,email_cliente from clientes;

-- Recupere os detalhes de uma compra específica, incluindo o nome do cliente, a data da compra e o total.
-- Selecionar a tabela o nome do cliente na tabela clientes, a data de compra, total em suas respectivas tabelas. Inner Join para conectar com a tabela compras, com a condição where para selecionar o cliente


select nome_cliente, data_compra, total from clientes as c inner join compras as co where nome_cliente="Kaike Bueno";

--  Liste os carros que estão em estoque, juntamente com a quantidade disponível.
select nome_carro, quant_estoque
from carros
where quant_estoque > 0;

-- Crie uma consulta para mostrar os clientes que compraram um determinado carro (usando o ID do carro).
SELECT nome_cliente
FROM clientes
INNER JOIN carros_compra ON cliente_id = carros_compra.id
WHERE carros_compra.carro_id = '1';
 --  (INCOMPLETA)
 
 -- Exiba o total de cada compra, juntamente com os nomes dos carros comprados, para um cliente específico.

-- Mostre os carros que foram comprados em uma determinada data.
select nome_carro,data_compra
from carros
inner join compras on carros.id_carros = compras.id
where compras.data_compra = '2023-08-08';


-- Recupere o total de vendas de cada cliente (nome e total) em ordem decrescente.

-- Exiba o nome do cliente que fez a compra mais cara até o momento.



-- Crie uma consulta para calcular a quantidade total de carros em estoque
select SUM(quant_estoque)
from carros;


-- Liste as compras feitas por um cliente específico, incluindo a data da compra e o total.
select data_compra, total
from compras as co
where co.cliente_id = '1'
order by co.data_compra;

-- Carros que nunca foram comprados
select nome_carro
from carros
left join compras on carros.id_carros = compras.id
where compras.id is null;

-- Mostre os clientes que ainda não fizeram nenhuma compra.
select nome_cliente
from clientes
left join carros_compra on cliente_id = carros_compra.id
where carros_compra.quantidade is null;


-- Atualizar dados da tabela
-- Utilizar o uptade , selecionar a tabela e oque quer mudar, usando where e o id para selecionar a coluna. Para verificar usar o select

UPDATE clientes
SET nome_cliente = 'Julia'
WHERE cliente_id = '1';

select * from clientes;

