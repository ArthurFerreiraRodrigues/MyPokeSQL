CREATE TABLE pk_mon(
    id INT PRIMARY KEY AUTO_INCREMENT,
    PokeDex INT,
    Name VARCHAR(50) NOT NULL,
    Type_1 VARCHAR(10) NOT NULL,
    Type_2 VARCHAR(10),
    Total INT,
    Hp INT,
    Attack INT,
    Defense INT,
    Sp_Atk INT,
    Sp_Def INT,
    Speed INT,
    Generation INT,
    Legendary BOOLEAN,
    FOREIGN KEY(Type_1) REFERENCES pk_types(type),
    FOREIGN KEY(Type_2) REFERENCES pk_types(type)
);