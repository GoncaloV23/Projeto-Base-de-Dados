-- competicoes
-- participantes
-- equipas_participantes

CALL sp_criar_comp(23, "Mafra event", "8:30:00");
select * from competicoes;

call add_individual ("11111111", "Rui Barroso", "1995-02-04", "11111111", 7);
call add_individual ("11111112", "Gonçalo Vieira", "2003-02-04", "11111112", 7);
call add_individual ("11111113", "Francisco Silva", "2003-02-04", "11111113", 7);
select * from individuos;

insert into atletas (at_id, at_peso, at_altura, at_sexo)
values (32, 65.00, 1.80, 'M'), (33, 65.00, 1.80, 'M'), (34, 65.00, 1.80, 'F');
select * from atletas;

CALL sp_adicionar_participante(18, 32, NULL); -- F 
CALL sp_adicionar_participante(18, 33, NULL); -- V
CALL sp_adicionar_participante(18, 34, NULL); -- F
select * from participantes where comp_id = 18;

CALL sp_registar_resultado(18, 33, 3); -- F
CALL sp_registar_resultado(18, 33, 1); -- V
select * from participantes where comp_id = 18;

call sp_remover_comp(18, false);
call sp_remover_comp(18, true);
select * from participantes where comp_id = 18;
