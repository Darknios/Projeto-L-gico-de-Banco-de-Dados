🛠️ Sistema de Banco de Dados – Oficina Mecânica
📌 Descrição do Projeto

Este projeto tem como objetivo modelar e implementar um Banco de Dados Relacional para uma Oficina Mecânica, contemplando desde a modelagem conceitual até a criação do script SQL e elaboração de consultas complexas.

O sistema permite gerenciar:

Clientes

Veículos

Mecânicos

Ordens de Serviço

Serviços realizados

O projeto foi desenvolvido aplicando boas práticas de modelagem relacional, integridade referencial e consultas SQL avançadas.

🗂️ Modelagem do Banco de Dados

O banco foi estruturado com as seguintes tabelas:

Cliente

Veiculo

Mecanico

OrdemServico

Servico

OS_Servico (tabela associativa N:N)

🔗 Relacionamentos

Um cliente pode possuir vários veículos.

Um veículo pode possuir várias ordens de serviço.

Um mecânico pode ser responsável por várias ordens.

Uma ordem pode conter vários serviços.

Um serviço pode estar presente em várias ordens.

🧱 Estrutura do Banco
Principais Recursos Implementados

✔ Chaves primárias (PRIMARY KEY)
✔ Chaves estrangeiras (FOREIGN KEY)
✔ Relacionamentos 1:N
✔ Relacionamentos N:N
✔ Integridade referencial
✔ Atributos derivados via consultas

🚀 Tecnologias Utilizadas

MySQL

SQL (DDL e DML)

Modelo Relacional
