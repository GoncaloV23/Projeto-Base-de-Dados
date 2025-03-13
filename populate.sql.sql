use projeto_bd;
insert into distritos (ds_nome) 
values ("Lisboa"), ("Setúbal");

insert into conselhos (con_nome, con_distrito) 
values ("Mafra", 1), ("Cascais", 1), ("Loures", 1), ("Odivelas", 1), ("Oeiras", 1), 
       ("Seixal", 2), ("Barreiro", 2), ("Sesimbra", 2), ("Almada", 2), ("Alcochete", 2);
       
insert into freguesias (fre_nome, fre_conselho)
values ("Ericeira", 1), ("Mafra", 1), ("Estoril", 2), ("Alcabideche", 2), ("Bucelas", 3), ("Lousa", 3), ("Caneças", 4), ("Ramada", 4), ("Queijas", 5), ("Algés", 5), 
       ("Corroios", 6), ("Amora", 6), ("Coina", 7), ("Palhais", 7), ("Castelo", 8), ("Santiago", 8), ("Cacilhas", 9), ("Caparica", 9), ("Samouco", 10), ("Alcochete", 10);
       
insert into itens (it_nome, it_desc, it_ip, it_dataHora)
values ("Microondas", "Máquina para aquecer comida", '12345678', now()),
       ("Televisão", "Máquina para ver filmes, séries...", '234567890', now()),
       ("Aspirador", "Máquina para aspirar lixo, sujidade", '345678901', now()),
       ("Rádio", "Máquina para ouvir noticias...", '456789012', now()),
       ("Lava Roupa", "Máquina para lavar roupa", '567890123', now()),
       ("Secador", "Máquina para secar o cabelo", '678901234', now()),
       ("Máquina de secar roupa", "Máquina para secar roupa", '789012345', now()),
       ("Computador", "Máquina para pesquisar, jogar, trabalhar...", '890123456', now()),
       ("Telemóvel fixo", "Máquina para ligar para a recepção", '901234567', now()),
       ("Interruptor", "Objeto para ligar/desligar a luz", '012345678', now()),
       ("Fechadura eletrónica", "Máquina para abrir a porta do quarto", '098765432', now()),
       ("Alarme", "Máquina para alertar", '987654321', now()),
       ("Camêras", "Máquina para gravar/vigiar", '876543210', now()),
       ("Alarme de incêndio", "Máquina para alertar em caso de incêndio", '765432109', now()),
       ("Tomadas", "Objeto para carregar/ligar eletrodomésticos", '654321098', now()),
       ("Fogão", "Máquina para cozinhar comida", '543210987', now()),
       ("Lava Louça", "Máquina para lavar a louça", '432109876', now()),
       ("Esquentador", "Máquina para definir a temperatura da água", '321098765', now()),
       ("Ar condicionado", "Máquina para refrescar o quarto", '210987654', now()),
       ("Aquecedor", "Máquina para aquecer o quarto", '109876543', now());
       
insert into tipologias (tip_nome, tip_desc)
values ("T2", "Casa com dois quartos"),
       ("T3", "Casa com três quartos"),
       ("Hotéis", "Quarto de hotél"),
       ("Villa", "Vivenda com piscina"),
       ("Vivenda", "Casa"),
       ("T1", "Casa com um quarto"),
       ("Apartamento", "Apartamento alugado"),
       ("PentHouse", "Apartamento do último andar, mais sufisticado/caro"),
       ("Suite", "Quarto com casa de banho privada"),
       ("Condominio", "Uma/Um vivenda/apartamento");
       
insert into alojamentos (al_divisoes, al_wc, al_cozinhaPart, al_area, al_coordenadas, al_morada, al_tipologia, al_local)
values (5, 1, 0, 41.30, "15 46 48", "Rua das Couves", "Apartamento", "4"),
       (5, 2, 0, 62.70, "41 49 88", "Rua das Cenouras", "T2", "5"),
       (9, 3, 0, 263.25, "75 16 32", "Rua dos Bróculos", "Vivenda", "1"),
       (7, 2, 0, 108.67, "93 36 78", "Rua das Almaredas", "PentHouse", "18"),
       (4, 2, 0, 65.10, "27 91 12", "Rua das Avarendas", "Suite", "20"),
       (11, 3, 0, 300.00, "97 65 23", "Rua das Cerveijas", "Villa", "19"),
       (6, 3, 0, 56.30, "89 23 43", "Rua Alberto Covilhena", "Apartamento", "17"),
       (5, 2, 0, 68.30, "17 36 49", "Rua das Sementes", "T3", "16"),
       (7, 2, 0, 200.12, "13 14 15", "Rua América", "Vivenda", "12"),
       (4, 2, 0, 98.45, "12 13 14", "Rua das Alvercas", "Suite", "14"),
       (6, 2, 0, 57.30, "01 45 65", "Rua dos Corajosos", "T2", "13"),
       (4, 2, 0, 40.20, "12 97 32", "Rua D.Afonso Henriques", "T1", "15"),
       (8, 2, 0, 156.30, "32 23 65", "Rua D.João IV", "PentHouse", "16"),
       (5, 2, 0, 50.30, "34 45 67", "Rua D.Pedro", "Apartamento", "9"),
       (7, 2, 0, 89.30, "16 75 98", "Rua das Couve Flor", "Condominio", "8"),
       (8, 3, 0, 100.89, "41 51 65", "Rua Nuno Jorbeirão", "PentHouse", "7"),
       (6, 2, 0, 89.23, "87 43 67", "Rua Maria Constantino", "T3", "6"),
       (4, 1, 0, 67.21, "13 15 15", "Rua José Costa", "T1", "3"),
       (9, 3, 0, 275.43, "54 76 98", "Rua dos Trabalhadores", "Vivenda", "2"),
       (8, 2, 1, 156.23, "25 66 56", "Rua das Mercadorias", "Condominio", "10");
       

insert into alojamentos_itens (al_id, it_nome)
values (1, "Alarme"), (1, "Aspirador"), (1, "Computador"), (1, "Fogão"), (1, "Esquentador"),
	   (2, "Alarme"), (2, "Fogão"), (2, "Esquentador"),
	   (3, "Alarme"), (3, "Camêras"), (3, "Fechadura eletrónica"), (3, "Aspirador"), (3, "Computador"),
       (4, "Alarme"), (4, "Telemóvel Fixo"), (4, "Tomadas"),
       (5, "Alarme"), (5, "Televisão"), (5, "Secador"),
       (6, "Alarme"), (6, "Rádio"), (6, "Microondas"),  (6, "Aspirador"), (6, "Computador"),
       (7, "Alarme"), (7, "Aquecedor"), (7, "Ar condicionado"), (7, "Aspirador"), (7, "Computador"),
       (8, "Alarme"), (8, "Aspirador"), (8, "Camêras"),
       (9, "Alarme"), (9, "Esquentador"), (9, "Fogão"), (9, "Aspirador"), (9, "Computador"),(9, "Rádio"), (9, "Televisão"), (9, "Microondas"),
       (10, "Alarme"), (10, "Fogão"), (10, "Fechadura eletrónica"),
       (11, "Alarme"), (11, "Interruptor"), (11, "Lava Roupa"), (11, "Aspirador"), (11, "Computador"),(11, "Rádio"), (11, "Televisão"),
       (12, "Alarme"), (12, "Lava Louça"), (12, "Máquina de secar roupa"),
       (13, "Alarme"), (13, "Microondas"), (13, "Rádio"), (13, "Aspirador"), (13, "Computador"),(13, "Esquentador"),
       (14, "Alarme"), (14, "Telemóvel fixo"), (14, "Televisão"),
       (15, "Alarme"), (15, "Tomadas"), (15, "Fechadura eletrónica"),
       (16, "Alarme"), (16, "Ar condicionado"), (16, "Esquentador"),
       (17, "Alarme"), (17, "Rádio"), (17, "Televisão"), (17, "Aspirador"), (17, "Computador"),
       (18, "Alarme"), (18, "Microondas"), (18, "Interruptor"),
       (19, "Alarme"), (19, "Máquina de secar roupa"), (19, "Lava Roupa"), (19, "Aspirador"), (19, "Computador"),(19, "Rádio"), (19, "Televisão"),
       (20, "Alarme"), (20, "Lava Louça"), (20, "Computador");

insert into servicos (se_produto, se_desc)
values ("Sala de Jogos", "Sala onde se pode jogar alguns jogos de mesa, de arcade..."),
       ("Ginásio", "Local para treinar musculação, cardio..."), 
       ("Lavandaria", "Lavar a roupa"), 
       ("Campo de Ténis", "Campo para jogar ténis"), 
       ("Aluguer de Viaturas", "Alugar viaturas para conduzir"), 
       ("Spa", "Local para relaxar"), 
       ("Pastelaria", "Compra de bolos"), 
       ("Bares", "Local para beber e lazer"), 
       ("Restaurantes", "Local para comer as refeições do dia"), 
       ("Atividades", "Ginástica, dança, natação..."),
       ("Porteiro", "Pessoa que supervisiona quem entra e sai do local"),
       ("Piscina", "Local para nadar"), 
       ("Terraço", "Cobertura plana de um edifício, constituindo plataforma acessível"), 
       ("Jardim", "Espaço ao ar livre, para a exibição, cultivação e apreciação de plantas..."), 
       ("Varanda", "Transição gradual entre os espaços internos e os espaços externos"), 
       ("Sotão", "Compartimento entre o telhado e o último andar de um edifício"), 
       ("Porão", "Pavimento inferior de um edifício, situado abaixo do nível do solo ou da rua e destinado geralmente a arrumações ou habitação"),
       ("Jacuzzi", "Banheira de hidromassagem"),
       ("Garagem", "Lugar para abrigar veículos ou automóveis."),
       ("Campo de Futebol", "Campo para jogar futebol");
       
insert into fornecedores (fo_nome, fo_desc)
values ("FaxFornice", "Sala de jogos"),
       ("Xtreme", "Ginásio"),
       ("FastSupplies", "Lavandaria"),
       ("UPS", "Campo de Ténis"),
       ("SupQuick", "Aluguer de Viaturas"),
       ("CTT", "Spa"),
       ("Lagga", "Pastelaria"),
       ("SuppliesAndDemand", "Bar"),
       ("Express", "Restaurantes"),
       ("Froggies", "Atividades"),
       ("AirSupplies", "Porteiro"),
       ("FastAndQuick", "Piscina"),
       ("SubwaySup", "Terraço"),
       ("GroundExpress", "Jardim"),
       ("Snackies", "Varanda"),
       ("Monplies", "Sotão"),
       ("Deliveries", "Porão"),
       ("MisFast", "Jacuzzi"),
       ("QuickExpress", "Garagem"),
       ("Paroties", "Campo de Futebol");
       
insert into servicos_precos (fo_nome, se_produto, tip_nome, se_preco)
values ("FaxFornice", "Sala de jogos", "Vivenda", 15000.00),
       ("Xtreme", "Ginásio", "Suite", 10000.00),
       ("FastSupplies", "Lavandaria", "Apartamento", 5000.00),
       ("UPS", "Campo de Ténis", "Condominio", 7500.00),
       ("SupQuick", "Aluguer de Viaturas", "PentHouse", 9000.00),
       ("CTT", "Spa", "PentHouse", "12500.00"),
       ("Lagga", "Pastelaria", "Condominio", 35000.00),
       ("SuppliesAndDemand", "Bares", "PentHouse", 25000.00),
       ("Express", "Restaurantes", "PentHouse", 56000.00),
       ("Froggies", "Atividades", "Villa", 4000.00),
       ("AirSupplies", "Porteiro", "Villa", 3500.00),
       ("FastAndQuick", "Piscina", "Vivenda", 24000.00),
       ("SubwaySup", "Terraço", "T3", 12500.00),
       ("GroundExpress", "Jardim", "Vivenda", 7800.00),
       ("Snackies", "Varanda", "T1", 2500.00),
       ("Monplies", "Sotão", "T3", 4600.00),
       ("Deliveries", "Porão", "T2", 5000.00),
       ("MisFast", "Jacuzzi", "Vivenda", "1250.00"),
       ("QuickExpress", "Garagem", "T2", 6000.00),
       ("Paroties", "Campo de Futebol", "Villa", 12500.00);
       
insert into alojamentos_servicos (al_id, se_produto)
values (3, "Sala de jogos"),
       (5, "Ginásio"),
       (1, "Lavandaria"),
       (15, "Campo de Ténis"),
       (13, "Aluguer de Viaturas"),
       (16, "Spa"),
       (20, "Pastelaria"),
       (4, "Bares"),
       (4, "Restaurantes"),
       (6, "Atividades"),
       (6, "Porteiro"),
       (9, "Piscina"),
       (8, "Terraço"),
       (3, "Jardim"),
       (18, "Varanda"),
       (17, "Sotão"),
       (2, "Porão"),
       (9, "Jacuzzi"),
       (11, "Garagem"),
       (6, "Campo de Futebol");
    
call add_individual ("12345678", "Rui Alverca", "2000-01-09", "909435432", 1);
call add_individual ("23456789", "Mariana Silva", "2003-11-12", "985446453", 1);
call add_individual ("34567890", "Pedro Henrique", "2003-10-17", "971254348", 1);
call add_individual ("45678901", "Arthur Gonçalves", "2001-12-06", "964358723", 1);
call add_individual ("56789012", "João Pedro", "2003-02-19", "938098732", 1);
call add_individual ("67890123", "Joana Silveiro", "2002-01-20", "928685454", 2);
call add_individual ("78901234", "João Gabriel", "2003-12-25", "912345687", 2);
call add_individual ("89012345", "Carlos Eduardo", "2003-07-28", "952342788", 2);
call add_individual ("90123456", "Vitor Hugo", "2003-06-11", "948923981", 2);
call add_individual ("01234567", "Sara Guilherme", "2002-08-21", "953242376", 2);
call add_individual ("09876543", "Maria Henrique", "2001-12-16", "931235456", 3);
call add_individual ("98765432", "Pedro Lucas", "2000-09-17", "924353443", 3);
call add_individual ("87654321", "Vitor Gabriel", "2001-05-03", "903294823", 3);
call add_individual ("76543210", "João Paulo", "2002-04-02", "975643278", 3);
call add_individual ("65432109", "Marco Rodrigues", "2000-03-01", "912347654", 3);
call add_individual ("54321098", "Ana Paula", "2000-04-10", "965643532", 4);
call add_individual ("43210987", "Oscar Alho", "2002-06-09", "912324556", 4);
call add_individual ("32190876", "Paulo Dentro", "2001-01-18", "990127432", 4);
call add_individual ("21098765", "Eva Gina", "2000-04-08", "976543210", 4);
call add_individual ("10987654", "Zeca Galhão", "2001-08-08", "987654321", 4);
call add_individual ("34678876", "Miguel Pastel", "1989-04-03", "945376432", 1);
call add_individual ("90953445", "Mónica Raco", "1986-07-01", "932434324", 2);
call add_individual ("23435634", "Marco Alteres", "1995-02-01", "913475631", 3);
call add_individual ("78764353", "Seixo Malho", "1992-08-10", "937265234", 4);
call add_individual ("48598433", "Oscar Pastéis", "1990-06-09", "908976542", 5);
call add_individual ("23083856", "Catarina Mora", "1980-01-18", "978654329", 6);
call add_individual ("02358354", "Eva Marco", "1988-04-08", "900234567", 7);
call add_individual ("28450365", "Zé Marrão", "1993-08-08", "928762376", 8);
call add_individual ("28450366", "João Marrão", "2002-08-01", "928762378", 8);
call add_individual ("28450367", "Maria Marrão", "2003-02-08", "928762377", 8);
call add_individual ("28450300", "Gonçalo Silva", "2003-02-04", "928762370", 7);
	
insert into atletas (at_id, at_peso, at_altura, at_sexo)
values (1, 65.00, 1.80, 'M'),
       (2, 78.00, 1.87, 'F'),
       (3, 68.00, 1.84, 'M'),
       (4, 69.00, 1.75, 'M'),
       (5, 60.00, 1.77, 'M'),
       (6, 85.00, 1.90, 'F'),
       (7, 90.00, 1.97, 'M'),
       (8, 87.00, 1.88, 'M'),
       (9, 73.00, 1.81, 'M'),
       (10, 80.00, 1.82, 'F'),
       (11, 79.00, 1.88, 'F'),
       (12, 65.00, 1.78, 'M'),
       (13, 65.00, 1.79, 'M'),
       (14, 61.00, 1.73, 'M'),
       (15, 78.00, 1.78, 'M'),
       (16, 89.00, 1.91, 'F'),
       (17, 78.00, 1.85, 'M'),
       (18, 75.00, 1.87, 'M'),
       (19, 69.00, 1.81, 'F'),
       (20, 66.00, 1.79, 'M'),
       (21, 75.00, 1.85, 'M'),
       (29, 70.00, 1.85, 'M'),
       (30, 60.00, 1.75, 'F'),
       (31, 80.00, 1.86, 'M');
       
insert into treinadores (tr_id, tr_titulo)
values (21, "Treinador Principal"),
	   (22, "Treinador Principal"),
       (23, "Treinador Principal"),
       (24, "Treinador Principal");
       
insert into staff (st_id, st_nif, st_titulo)
values (5, "199888777", "Ensino secundário"),
       (13, "188777999", "Ensino secundário"),
       (15, "122333111", "Ensino superior"),
       (16, "177555444", "Ensino superior"),
       (19, "299888777", "Ensino secundário"),
       (20, "288777999", "Ensino secundário"),
       (22, "222333111", "Ensino secundário"),
       (24, "277555444", "Ensino superior"),
       (25, "399888777", "Ensino superior"),
       (26, "388777999", "Ensino secundário"),
       (27, "322333111", "Ensino secundário"),
       (28, "377555444", "Ensino superior");

insert into staff_rank values	(27,28), (26,28), (5,27),
								(13,26), (15,27), (16,26),
                                (19,27), (20,26), (22,27), 
                                (24,26), (25,27);

insert into equipas (eq_sigla, eq_nome, tr_id)
values ("OGV", "Os Grandiosos Vitoriosos", 21),
	   ("GHG", "Grandes Honrados Guerreiros", 22),
       ("VFC", "Vitoria FC", 23),
       ("PFC", "Paz FC", 24);
       
insert into equipas_membros (eq_sigla, at_id)
values ("OGV", 1),
       ("OGV", 2),
       ("OGV", 3),
       ("OGV", 4),
       ("OGV", 5),
       ("GHG", 6),
       ("GHG", 7),
       ("GHG", 8),
       ("GHG", 9),
       ("GHG", 10),
       ("VFC", 11),
       ("VFC", 12),
       ("VFC", 13),
       ("VFC", 14),
       ("VFC", 15),
       ("PFC", 16),
       ("PFC", 17),
       ("PFC", 18),
       ("PFC", 19),
       ("PFC", 20),
       ("PFC", 29),
       ("PFC", 30);
       
       
insert into modalidades (mod_nome, mod_desc)
values ("100 metros Crawl", "Nadar 100 metros seguidos em estilo Crawl"),
	   ("200 metros Crawl", "Nadar 200 metros seguidos em estilo Crawl"),
       ("400 metros Crawl", "Nadar 400 metros seguidos em estilo Crawl"),
       ("800 metros Crawl", "Nadar 800 metros seguidos em estilo Crawl"),
       ("1500 metros Crawl", "Nadar 1500 metros seguidos em estilo Crawl"),
       ("100 metros Costas", "Nadar 100 metros seguidos em estilo Costas"),
       ("200 metros Costas", "Nadar 200 metros seguidos em estilo Costas"),
       ("100 metros Bruços", "Nadar 100 metros seguidos em estilo Bruços"),
       ("200 metros Bruços", "Nadar 200 metros seguidos em estilo Bruços"),
       ("100 metros Mariposa", "Nadar 100 metros seguidos em estilo Mariposa"),
       ("200 metros Mariposa", "Nadar 200 metros seguidos em estilo Mariposa"),
       ("200 metros Medley", "Nadar 200 metros seguidos em estilo Medley"),
       ("400 metros Medley", "Nadar 400 metros seguidos em estilo Medley"),
       ("Saltos para a água", "Mergulhar de diferentes alturas para a água"),
       ("Natação Sincronizada", "Dança e atuações na água"),
       ("Polo aquático", "Voleibol na água"),
       ("Mergulho", "Competição de submersão na água"),
       ("Natação em águas abertas", "Nadar em rios, lagos...");
	
insert into provas (pr_coletividade, pr_escalao, pr_sexo, pr_modalidade)
values (false, 21, 'F', "100 metros Crawl"),
	   (false, 21, 'M', "200 metros Crawl"),
       (false, 22, 'F', "100 metros Crawl"),
	   (false, 22, 'M', "200 metros Crawl"),
       (false, 19, 'F', "100 metros Crawl"),
	   (false, 19, 'M', "200 metros Crawl"),
       (true, 22, 'U', "1500 metros Crawl"),
       (false, 21, 'M', "200 metros Costas"),
       (false, 21, 'F', "100 metros Costas"),
       (false, 21, 'F', "100 metros Bruços"),
       (false, 21, 'M', "200 metros Bruços"),
       (false, 21, 'F', "100 metros Mariposa"),
       (false, 21, 'M', "200 metros Mariposa"),
       (false, 21, 'F', "200 metros Medley"),
       (false, 21, 'M', "400 metros Medley"),
       (false, 22, 'M', "200 metros Costas"),
       (false, 22, 'F', "100 metros Costas"),
       (false, 22, 'F', "100 metros Bruços"),
       (false, 22, 'M', "200 metros Bruços"),
       (false, 22, 'F', "100 metros Mariposa"),
       (false, 22, 'M', "200 metros Mariposa"),
       (false, 22, 'F', "200 metros Medley"),
       (false, 22, 'M', "400 metros Medley"),
       (false, 22, 'U', "Saltos para a água"),
       (true, 22, 'U', "Natação Sincronizada"),
       (true, 22, 'U', "Polo aquático"),
       (false, 22, 'U', "Mergulho"),
       (true, 22, 'U', "Natação em águas abertas");

call create_evento("Ericeira event", "1", "2022-07-20 08:30:00", "2022-07-27 08:30:00", 28);
call create_evento("Mafra event", "2", "2022-07-29 08:30:00", "2022-08-07 08:30:00", 28);
call create_evento("Estoril event", "3", "2022-08-12 08:30:00", "2022-08-22 08:30:00", 28);
call create_evento("Corroios event", "11", "2022-08-20 08:30:00", "2022-08-30 08:30:00", 27);
call create_evento("Cacilhas event", "17", "2022-08-26 08:30:00", "2022-09-05 08:30:00", 26);
call create_evento("Alcochete event", "20", "2022-09-29 08:30:00", "2022-10-08 08:30:00", 26);

       
insert into funcoes (fu_nome, fu_descricao)
values ("Segurança", "Guardar, assegurar a segurança"),
       ("Cozinhar", "Preparar as refeições"),
       ("Arbitrar", "Arbitrar as competições"),
       ("Salva Vidas", "Em caso de afogos ou acidentes"),
       ("Limpeza", "Limpa os estabelecimentos"),
       ("Comentador", "Comenta durante os eventos"),
       ("Dj", "Põe música durante os eventos");
       
insert into trabalhos (tr_evento, tr_nome, tr_staff_id)-- 5,13,15,16,19,20,22,24,25,/26,27,28
values ("Ericeira event", "Segurança", 5),
	   ("Ericeira event", "Segurança", 13),
       ("Ericeira event", "Cozinhar", 15),
       ("Ericeira event", "Arbitrar", 16),
       ("Ericeira event", "Salva Vidas", 19),
       ("Ericeira event", "Limpeza", 20),
       ("Ericeira event", "Limpeza", 22),
       ("Ericeira event", "Comentador", 25),
       ("Ericeira event", "Dj", 24),
       ("Mafra event", "Segurança", 13),
	   ("Mafra event", "Segurança", 5),
	   ("Mafra event", "Cozinhar", 16),
       ("Mafra event", "Arbitrar", 15),
       ("Mafra event", "Salva Vidas", 20),
       ("Mafra event", "Limpeza", 19),
       ("Mafra event", "Limpeza", 22),
       ("Mafra event", "Comentador", 25),
       ("Mafra event", "Dj", 24),
       ("Estoril event", "Segurança", 15),
	   ("Estoril event", "Segurança", 13),
       ("Estoril event", "Cozinhar", 5),
       ("Estoril event", "Arbitrar", 22),
       ("Estoril event", "Salva Vidas", 19),
       ("Estoril event", "Limpeza", 20),
       ("Estoril event", "Limpeza", 16),
       ("Estoril event", "Comentador", 25),
       ("Estoril event", "Dj", 24),
       ("Corroios event", "Segurança", 5),
	   ("Corroios event", "Segurança", 13),
       ("Corroios event", "Cozinhar", 15),
       ("Corroios event", "Arbitrar", 16),
       ("Corroios event", "Salva Vidas", 19),
       ("Corroios event", "Limpeza", 20),
       ("Corroios event", "Limpeza", 22),
       ("Corroios event", "Comentador", 25),
       ("Corroios event", "Dj", 24),
       ("Alcochete event", "Segurança", 5),
	   ("Alcochete event", "Segurança", 13),
       ("Alcochete event", "Cozinhar", 15),
       ("Alcochete event", "Arbitrar", 16),
       ("Alcochete event", "Salva Vidas", 19),
       ("Alcochete event", "Limpeza", 20),
       ("Alcochete event", "Limpeza", 22),
       ("Alcochete event", "Comentador", 25),
       ("Alcochete event", "Dj", 24),
	   ("Cacilhas event", "Segurança", 5),
	   ("Cacilhas event", "Segurança", 13),
       ("Cacilhas event", "Cozinhar", 15),
       ("Cacilhas event", "Arbitrar", 16),
       ("Cacilhas event", "Salva Vidas", 19),
       ("Cacilhas event", "Limpeza", 20),
       ("Cacilhas event", "Limpeza", 22),
       ("Cacilhas event", "Comentador", 25),
       ("Cacilhas event", "Dj", 24);

insert into linhas values(NULL, "01-02-03-04-05-06-07-08-09-10"),
                         (NULL, "11-12-13-14-15-16-17-18-19-20"),
                         (NULL, "01-11");

insert into comboios values (NULL, 1, "Regional", 1, 100),
							(NULL, 2, "Regional", 1, 100),
                            (NULL, 3, "InterRegional", 2.5, 300);
                            
insert into parcerias values(NULL, 1, "Ericeira event", 10),
							(NULL, 3, "Ericeira event", 15),
							(NULL, 1, "Mafra event", 10),
                            (NULL, 1, "Estoril event", 10),
                            (NULL, 2, "Corroios event", 5),
                            (NULL, 3, "Corroios event", 20),
                            (NULL, 2, "Cacilhas event", 5),
                            (NULL, 2, "Alcochete event", 10);
                                      
-- viajens sp_get_ticket(in atleta_id varchar(8), in evento_nome varchar(30), email varchar(100), feedback varchar(500), avaliacao int)

call sp_get_ticket(1, "Ericeira event", "rui@gmail.com", "Ótima viagem, muito confortável", 3);
call sp_get_ticket(2, "Ericeira event", "Mariana@gmail.com", "Ótima viagem, muito confortável", 4);
call sp_get_ticket(3, "Ericeira event", "Pedro@gmail.com", "Ótima viagem, muito confortável", 5);
call sp_get_ticket(4, "Ericeira event", "Arthur@gmail.com", "Ótima viagem, muito confortável", 1);
call sp_get_ticket(5, "Corroios event", "Joao@gmail.com", "Ótima viagem, muito confortável", 3);
call sp_get_ticket(6, "Corroios event", "Joana@gmail.com", "Ótima viagem, muito confortável", 4);
call sp_get_ticket(7, "Estoril event", "gabriel@gmail.com", "Ótima viagem, muito confortável", 5);
call sp_get_ticket(8, "Estoril event", "carlos@gmail.com", "Ótima viagem, muito confortável", 5);
call sp_get_ticket(9, "Estoril event", "vitor@gmail.com", "Ótima viagem, muito confortável", 1);
call sp_get_ticket(10, "Alcochete event", "sara@gmail.com", "Ótima viagem, muito confortável", 5);
call sp_get_ticket(11, "Alcochete event", "maria@gmail.com", "Ótima viagem, muito confortável", 4);
call sp_get_ticket(12, "Alcochete event", "lucas@gmail.com", "Ótima viagem, muito confortável", 2);
call sp_get_ticket(13, "Alcochete event", "vitgabi@gmail.com", "Ótima viagem, muito confortável", 3);

-- competicoes
-- participantes
-- equipas_participantes
CALL sp_criar_comp(1, "Alcochete event", "8:30:00");
CALL sp_criar_comp(2, "Alcochete event", "8:30:00");
CALL sp_criar_comp(3, "Corroios event", "8:30:00");
CALL sp_criar_comp(4, "Corroios event", "8:30:00");
CALL sp_criar_comp(5, "Estoril event", "8:30:00");
CALL sp_criar_comp(6, "Estoril event", "8:30:00");
CALL sp_criar_comp(8, "Mafra event", "8:30:00");
CALL sp_criar_comp(9, "Mafra event", "8:30:00");
CALL sp_criar_comp(10, "Ericeira event", "8:30:00");
CALL sp_criar_comp(11, "Ericeira event", "8:30:00");

CALL sp_criar_comp(27, "Estoril event", "8:30:00");-- U
CALL sp_criar_comp(24, "Cacilhas event", "8:30:00");-- U

CALL sp_criar_comp(26, "Ericeira event", "8:30:00");-- T
CALL sp_criar_comp(25, "Estoril event", "8:30:00");-- T
CALL sp_criar_comp(26, "Estoril event", "8:30:00");-- T
CALL sp_criar_comp(7, "Cacilhas event", "8:30:00");-- T
CALL sp_criar_comp(28, "Cacilhas event", "8:30:00");-- T


CALL sp_adicionar_participante(1, 2, NULL);-- F-21
CALL sp_adicionar_participante(1, 6, NULL);
CALL sp_adicionar_participante(1, 10, NULL);
CALL sp_adicionar_participante(1, 11, NULL);
CALL sp_adicionar_participante(1, 30, NULL);

CALL sp_adicionar_participante(2, 29, NULL);-- M-21
CALL sp_adicionar_participante(2, 17, NULL);
CALL sp_adicionar_participante(2, 14, NULL);
CALL sp_adicionar_participante(2, 4, NULL);

CALL sp_adicionar_participante(3, 11, NULL);-- F-22
CALL sp_adicionar_participante(3, 16, NULL);
CALL sp_adicionar_participante(3, 19, NULL);
CALL sp_adicionar_participante(3, 30, NULL);
CALL sp_adicionar_participante(3, 2, NULL);


CALL sp_adicionar_participante(4, 1, NULL);-- M-22
CALL sp_adicionar_participante(4, 4, NULL);
CALL sp_adicionar_participante(4, 12, NULL);
CALL sp_adicionar_participante(4, 13, NULL);
CALL sp_adicionar_participante(4, 15, NULL);
CALL sp_adicionar_participante(4, 29, NULL);

CALL sp_adicionar_participante(5, 30, NULL);-- F-19
CALL sp_adicionar_participante(5, 2, NULL);

CALL sp_adicionar_participante(6, 3, NULL);-- M-19
CALL sp_adicionar_participante(6, 5, NULL);
CALL sp_adicionar_participante(6, 7, NULL);
CALL sp_adicionar_participante(6, 8, NULL);
CALL sp_adicionar_participante(6, 9, NULL);

CALL sp_adicionar_participante(7, 4, NULL);-- M-21
CALL sp_adicionar_participante(7, 13, NULL);
CALL sp_adicionar_participante(7, 14, NULL);
CALL sp_adicionar_participante(7, 17, NULL);
CALL sp_adicionar_participante(7, 18, NULL);
CALL sp_adicionar_participante(7, 20, NULL);

CALL sp_adicionar_participante(8, 2, NULL);-- F-21
CALL sp_adicionar_participante(8, 6, NULL);
CALL sp_adicionar_participante(8, 10, NULL);
CALL sp_adicionar_participante(8, 11, NULL);

CALL sp_adicionar_participante(9, 2, NULL);-- F-21
CALL sp_adicionar_participante(9, 6, NULL);
CALL sp_adicionar_participante(9, 20, NULL);
CALL sp_adicionar_participante(9, 11, NULL);
CALL sp_adicionar_participante(9, 30, NULL);

CALL sp_adicionar_participante(10,  4, NULL);-- M-21
CALL sp_adicionar_participante(10,  13, NULL);
CALL sp_adicionar_participante(10,  29, NULL);
CALL sp_adicionar_participante(10,  20, NULL);
CALL sp_adicionar_participante(10,  18, NULL);
CALL sp_adicionar_participante(10,  17, NULL);
CALL sp_adicionar_participante(10,  14, NULL);
CALL sp_adicionar_participante(10,  3, NULL);

CALL sp_adicionar_participante(11, 1, NULL);-- U-22
CALL sp_adicionar_participante(11, 3, NULL);
CALL sp_adicionar_participante(11, 5, NULL);
CALL sp_adicionar_participante(11, 6, NULL);
CALL sp_adicionar_participante(11, 8, NULL);
CALL sp_adicionar_participante(11, 11, NULL);
CALL sp_adicionar_participante(11, 13, NULL);
CALL sp_adicionar_participante(12, 14, NULL);
CALL sp_adicionar_participante(12, 16, NULL);
CALL sp_adicionar_participante(12, 21, NULL);
CALL sp_adicionar_participante(12, 29, NULL);
CALL sp_adicionar_participante(12, 30, NULL);
CALL sp_adicionar_participante(12, 1, NULL);
CALL sp_adicionar_participante(12, 2, NULL);
CALL sp_adicionar_participante(12, 4, NULL);
CALL sp_adicionar_participante(12, 7, NULL);
CALL sp_adicionar_participante(12, 9, NULL);

CALL sp_adicionar_participante(13, 1, "OGV");
CALL sp_adicionar_participante(13, 1, "GHG");
CALL sp_adicionar_participante(13, 1, "VFC");
CALL sp_adicionar_participante(14, 4, "OGV");
CALL sp_adicionar_participante(14, 4, "GHG");
CALL sp_adicionar_participante(15, 7, "OGV");
CALL sp_adicionar_participante(15, 7, "GHG");
CALL sp_adicionar_participante(15, 7, "VFC");
CALL sp_adicionar_participante(16, 8, "OGV");
CALL sp_adicionar_participante(16, 8, "VFC");
CALL sp_adicionar_participante(17, 11, "OGV");
CALL sp_adicionar_participante(17, 11, "GHG");
CALL sp_adicionar_participante(17, 11, "VFC");
CALL sp_adicionar_participante(17, 11, "PFC");


CALL sp_registar_resultado_equipa(13, "OGV", 1);
CALL sp_registar_resultado_equipa(13, "GHG", 2);
CALL sp_registar_resultado_equipa(13, "VFC", 3);
CALL sp_registar_resultado_equipa(14, "OGV", 2);
CALL sp_registar_resultado_equipa(14, "GHG", 1);
CALL sp_registar_resultado_equipa(15, "OGV", 3);
CALL sp_registar_resultado_equipa(15, "GHG", 2);
CALL sp_registar_resultado_equipa(15, "VFC", 1);
CALL sp_registar_resultado_equipa(16, "OGV", 1);
CALL sp_registar_resultado_equipa(16, "VFC", 2);
CALL sp_registar_resultado_equipa(17, "OGV", 4);
CALL sp_registar_resultado_equipa(17, "GHG", 3);
CALL sp_registar_resultado_equipa(17, "VFC", 2);
CALL sp_registar_resultado_equipa(17, "PFC", 1);


CALL sp_registar_resultado(11, 1, 1);
CALL sp_registar_resultado(11, 3, 3);
CALL sp_registar_resultado(11, 5, 2);
CALL sp_registar_resultado(11, 6, 4);
CALL sp_registar_resultado(11, 8, 6);
CALL sp_registar_resultado(11, 11, 5);
CALL sp_registar_resultado(11, 13, 7);
CALL sp_registar_resultado(12, 14, 3);
CALL sp_registar_resultado(12, 16, 4);
CALL sp_registar_resultado(12, 21, 2);
CALL sp_registar_resultado(12, 29, 5);
CALL sp_registar_resultado(12, 30, 1);
CALL sp_registar_resultado(12, 1, 7);
CALL sp_registar_resultado(12, 2, 8);
CALL sp_registar_resultado(12, 4, 6);
CALL sp_registar_resultado(12, 7, 9);

CALL sp_registar_resultado(1, 2, 1);-- F-21
CALL sp_registar_resultado(1, 6, 2);
CALL sp_registar_resultado(1, 10, 3);
CALL sp_registar_resultado(1, 11, 4);
CALL sp_registar_resultado(1, 30, 5);

CALL sp_registar_resultado(2, 29, 1);-- M-21
CALL sp_registar_resultado(2, 17, 2);
CALL sp_registar_resultado(2, 14, 3);
CALL sp_registar_resultado(2, 4, 4);

CALL sp_registar_resultado(3, 11, 1);-- F-22
CALL sp_registar_resultado(3, 16, 2);
CALL sp_registar_resultado(3, 19, 3);
CALL sp_registar_resultado(3, 30, 4);
CALL sp_registar_resultado(3, 2, 5);


CALL sp_registar_resultado(4, 1, 2);-- M-22
CALL sp_registar_resultado(4, 4, 3);
CALL sp_registar_resultado(4, 12, 5);
CALL sp_registar_resultado(4, 13, 4);
CALL sp_registar_resultado(4, 15, 1);
CALL sp_registar_resultado(4, 29, 6);

CALL sp_registar_resultado(5, 30, 1);-- F-19
CALL sp_registar_resultado(5, 2, 2);

CALL sp_registar_resultado(6, 3, 2);-- M-19
CALL sp_registar_resultado(6, 5, 1);
CALL sp_registar_resultado(6, 7, 4);
CALL sp_registar_resultado(6, 8, 3);
CALL sp_registar_resultado(6, 9, 5);

CALL sp_registar_resultado(7, 4, 6);-- M-21
CALL sp_registar_resultado(7, 13, 4);
CALL sp_registar_resultado(7, 14, 3);
CALL sp_registar_resultado(7, 17, 2);
CALL sp_registar_resultado(7, 18, 1);
CALL sp_registar_resultado(7, 20, 5);

CALL sp_registar_resultado(8, 2, 1);-- F-21
CALL sp_registar_resultado(8, 6, 2);
CALL sp_registar_resultado(8, 10, 3);
CALL sp_registar_resultado(8, 11, 4);

CALL sp_registar_resultado(9, 2, 1);-- F-21
CALL sp_registar_resultado(9, 6, 3);
CALL sp_registar_resultado(9, 20, 2);
CALL sp_registar_resultado(9, 11, 4);

CALL sp_registar_resultado(10,  4, 2);-- M-21
CALL sp_registar_resultado(10,  13, 1);
CALL sp_registar_resultado(10,  29, 3);
CALL sp_registar_resultado(10,  20, 4);
CALL sp_registar_resultado(10,  18, 5);
CALL sp_registar_resultado(10,  17, 6);
CALL sp_registar_resultado(10,  14, 7);
CALL sp_registar_resultado(10,  3, 8);

