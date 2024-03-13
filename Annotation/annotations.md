# Primeiros estudos

## Primeiros Comandos

1. Subindo um container para testes  
    - Cópia do repositório da <https://github.com/fabianysousa> nele consta diversos exemplos básicos de comandos SQL.
    - Subi um container com MySQL 8.0 para criação da database e teste dos comandos.
    - `docker pull mysql` para baixar a imagem do MySQL 
    - `docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag` comando para subir o container com a imagem baixada anteriormente, nele consta o `name` do container a senha de root `-e MYSQL_ROOT_PASSWORD=my-secret-pw` e a versão do MySQL que você irá utilizar `mysql:tag`
    
2. Explicações sobre transact-SQL (T-SQL)
    - Transact-SQL(T-SQL) é linguagem utilizada na construção de aplicações que manipulam dados, logo, compreender o seu funcionamento pode ajudar a criar consultas melhores e pode facilitar a sua compreensão de como corrigir uma consulta que não está retornando os resultados desejados. Nesse repositório explico e exemplifico brevemente cada um dos comandos DQL, DML, DDL, DCL, DTL, utilizando o PostgreSQL.
        - **DQL (Data Query Language):** Linguagem de Consulta de dados. São os comandos de consulta.
            - **SELECT**
            ```
            SELECT * FROM tipos_produtos;

            SELECT p.id AS Código, p.descricao AS Descricao, p.preco AS Preço, p.id_tipo_produto AS Codigo_produto FROM produtos AS p;
            ```
        - **DML (Data Manipulation Language):** Linguagem de Manipulação de Dados. São os comandos que interagem com os dados dentro das tabelas.
            - **INSERT**
            ```
            INSERT INTO tipos_produtos (descricao) VALUES ('Computadores');
            ```
            - **DELETE**
            ```
            DELETE FROM tipos_produtos WHERE id = 2;
            ```
            - **UPDATE**
            ```
            UPDATE produtos SET descricao = 'Notebook',  preco = '2800' WHERE id = 2;
            ```
        - **DDL (Data Definition Language):** Definição de Dados. São os comandos que interagem com os objetos do banco.
            - **CREATE**
            ```
            CREATE DATABASE secao03;

            CREATE USER estagiario PASSWORD '123456';

            CREATE TABLE tipos_produtos (
	        id SERIAL PRIMARY KEY,
	        DESCRICAO CHARACTER VARYING(50) NOT NULL
            );
            ```
            - **ALTER**
            ```
            ALTER TABLE tipos_produtos ADD peso DECIMAL(8,2);
            ```
            - **DROP**
            ```
            DROP DATABASE secao03;

            DROP USER estagiario;

            DROP TABLE produtos;
            ```
        - **DCL (Data Control Language):** São os comandos para controlar a parte de segurança do banco de dados.
            - **GRANT**
            ```
            GRANT ALL ON empresas TO estagiario;
            
            GRANT USAGE, SELECT ON SEQUENCE empresas_id_seq TO estagiario;
            
            GRANT SELECT ON empresas TO estagiario;
            ```
            - **REVOKE**
            ```
            REVOKE ALL ON empresas FROM estagiario;
            
            REVOKE USAGE, SELECT ON SEQUENCE empresas_id_seq FROM estagiario;
            ```
        - **DTL (Data Transaction Language):** São os comandos para controle de transação.
            - **BEGIN TRANSACTION**
            ```
            BEGIN TRANSACTION;

            INSERT INTO tipos_produtos (descricao) VALUES ('Equipamentos');
            INSERT INTO tipos_produtos (descricao) VALUES ('Nobreak');

            COMMIT;
            ```
            - **COMMIT TRANSACTION**
            - **ROLLBACK TRANSACTION**
            ```
            BEGIN TRANSACTION;

            INSERT INTO tipos_produto (descricao) VALUES ('Tipo A');
            INSERT INTO tipos_produto (descricao) VALUES ('Tipo B');

            ROLLBACK;
            ```

## Outros testes