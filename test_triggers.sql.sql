
CALL sp_adicionar_participante(10, 33, NULL); -- V
call sp_registar_resultado(10, 33, 9);

call sp_get_ticket(33, "Ericeira event", "Gonc@gmail.com", "Ótima viagem, muito confortável", 5);
call sp_get_ticket(33, "Ericeira event", "Gonc@gmail.com", "Ótima viagem, muito confortável", 5);

delete from participantes where comp_id = 10 and at_id = 33;

select * from tbl_logs where logs_in_id = 33;
select * from viajens where via_at_id = 33;
select * from lugar where lu_at_id = 33;