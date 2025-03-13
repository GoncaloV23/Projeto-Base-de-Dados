-- teste sp_remover_comp
-- 1 e 2 pertence a Alcochete event 
select * from competicoes where comp_evento = "Alcochete event" ;
call sp_remover_comp(1, true);
call sp_remover_comp(2, false);
select * from competicoes where comp_evento = "Alcochete event" ;

select * from competicoes where comp_evento = "Cacilhas event" ;
CALL sp_criar_comp(1, "Cacilhas event", "8:30:00");
select * from competicoes where comp_evento = "Cacilhas event" ;
Call sp_remover_comp(19, false);
select * from competicoes where comp_evento = "Cacilhas event" ;

-- teste sp_remove_staff_rank
select * from staff_rank;
call sp_remove_staff_rank(20, false) ;
call sp_remove_staff_rank(24, true) ;
select * from staff_rank;

call sp_remove_staff_rank(27, true);
select * from staff_rank;

-- teste sp_get_best_atlete
set @best_at = 0;
call sp_get_best_atlete(@best_at);
select @best_at;
select at_id, count(*) as 'Nº de Medalhas'
	from participantes
	group by at_id
    order by count(*) desc
    limit 3;

-- teste sp_remove_atlete
call sp_remove_atlete(2);
call sp_get_best_atlete(@best_at);
select @best_at;

-- teste sp_remove_team
select * from equipas;
call sp_remove_team("GHG");
select * from equipas;

-- teste sp_fre_atletes
call sp_fre_atletes(1);
call sp_fre_atletes(4);

-- teste sp_get_ticket
call sp_get_ticket(20, "Ericeira event", "joaoguilherme@gmail.com", "Ótima viagem, muito confortável", 5);
call sp_get_ticket(20, "Ericeira event", "joaoguilherme@gmail.com", "Ótima viagem, muito confortável", 5);
select * from viajens;

-- teste sp_rembolse
call sp_rembolse("Ericeira event");
call sp_rembolse("Corroios event");
select * from devolucoes;
call sp_rembolse("Estoril event");
call sp_rembolse("Alcochete event");
select * from devolucoes;

-- teste sp_cancel_trip
select * from viajens;
select * from lugar;
select * from devolucoes;
call sp_cancel_trip(1) ;
select * from viajens;
select * from lugar;
select * from devolucoes;

call sp_cancel_trip(2) ;
call sp_cancel_trip(3) ;
select * from viajens;
select * from lugar;
select * from devolucoes;