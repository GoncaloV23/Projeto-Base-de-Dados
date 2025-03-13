USE projeto_bd;

-- Criação de, pelo menos, 5 views;
-- Criação de, pelo menos, 2 stored functions;
-- Criação de, pelo menos, 10 stored procedures;
-- Criação de, pelo menos, 2 triggers.

-- Functions
delimiter //
drop function if exists f_Classification//
create function  f_Classification(x int)
	returns varchar(30)
    deterministic
BEGIN 
	case
		when x = 1 then return 'Ouro';
        when x = 2 then return 'Prata';
        when x = 3 then return 'Bronze';
        when x = -1 then return 'Sem classificação';
        when x >3 then return 'Abaixo do pódio';
        else  return 'Sem classificação';
	end case;
END//

drop function if exists f_Age//
create function f_Age(x date)
returns int
deterministic
BEGIN
	return year(curdate()) - year(x);
END//



-- Identificar se um atleta já procedeu à aquisição de um bilhete para a sua deslocação a 
-- um evento específico;
drop function if exists f_hasTicket//
create function f_hasTicket(evento_nome varchar(30), atleta_id int)
returns boolean
deterministic
BEGIN
declare hasTicket boolean;
	
    if atleta_id = any (select via_at_id from viajens where via_ev_nome = evento_nome)
    then
		set hasTicket = true;
        else set hasTicket = false;
    end if;
    
    return hasTicket;
END//


-- Obter o nº de bilhetes adquiridos para uma comboio específico.
drop function if exists f_trainTickets//
create function f_trainTickets(train_id int)
returns int
deterministic
BEGIN
	declare count int default 0;
    set count = (select count(lu_at_id) 
				from lugar
				where lu_com_id = train_id 
				group by lu_com_id);
	if count is null then set count = 0;end if;
	return count;
END//

-- Obter o caminho mais adequado entre 2 locais.
drop function if exists f_trainPath//
create function f_trainPath(origin int, destination int)
returns varchar(100)
deterministic
BEGIN
	declare result, orig, dest, cur_local, linha, temp varchar(100);
    declare comboio_id, linha_id, v, x int default 0;
    declare li_found, aux boolean default false;
    declare c cursor for (select li_caminho from linhas order by li_id desc);
    declare continue handler for not found set v = 1;
    
    if origin<10 then 
		set orig = concat("0", origin); 
        else set orig = concat("", origin);
	end if;
	if destination<10 then 
		set dest = concat("0", destination); 
        else set dest = concat("", destination);
	end if;
     
    if origin < destination then 
		set temp = orig;
        set orig = dest;
        set dest = temp;
        set aux = true;
	end if;
    
    set linha_id = (select li_id from linhas where INSTR(li_caminho, orig)>0 and INSTR(li_caminho, dest)>0 limit 1) ;
    if linha_id != 0 then 
		set v = 1;
		set comboio_id = (select com_id 
						from comboios inner join linhas on com_li_id = li_id
						where li_id = linha_id 
						-- order by com_preco asc 
						limit 1);
		set result = concat("",comboio_id); 
	end if;
    
    open c;
    l1: loop
		fetch c into linha;
		if v=1 then leave l1;end if;
		if INSTR(linha, orig)>0 then
           -- set result = orig; 
			
			set comboio_id = (select com_id 
								  from comboios inner join linhas on com_li_id = li_id
								  where li_caminho = linha 
								  order by com_preco asc 
								  limit 1);
			set result = concat("",comboio_id);
			
            set x = 2;
            while x<length(linha) and not li_found do
				set cur_local = right(left(linha,x),2);
				set linha_id = (select li_id from linhas where INSTR(li_caminho, cur_local)>0 and INSTR(li_caminho, linha) != 1 limit 1);
                if linha_id != 0 then 
					set comboio_id = (select com_id 
									  from comboios 
                                      where com_li_id = linha_id 
                                      order by com_preco asc 
                                      limit 1);
					set result = concat(result,"-",comboio_id);
                    set linha = (select li_caminho from linhas where li_id = linha_id);
                    set x = 2-3;
				end if;
                if INSTR(linha, dest)>0 then 
					set v = 1;
                    set li_found = true;
				end if;
                set x = x+3;                
			end while;
        end if;
	end loop l1;
    close c;
	
    if aux then set result = REVERSE (result);end if;
	return result;
END//
delimiter ;

-- Views
-- resultados
drop view if exists v_Resultados;
create view v_Resultados as
	select  i.in_cc as BI, i.in_nome as Nome, f_Classification(p.pa_lugar) as Classificação,
			c.comp_id as Competição, prov.pr_modalidade as Modalidade, concat('sub ',f_Age(i.in_dnsc)) as Escalão,
			prov.pr_sexo as Sexo, c.comp_evento as Evento
    from participantes as p
    inner join individuos as i on in_id = at_id
    inner join competicoes as c on p.comp_id = c.comp_id
    inner join provas as prov on prov.pr_id = comp_prova
    order by c.comp_evento and prov.pr_modalidade;
	
-- atletas
drop view if exists v_Atletas;
create view v_Atletas as
	select in_cc as BI, in_nome as Nome, at_peso as Peso, at_altura as Altura,
    at_sexo as Sexo, f_Age(in_dnsc) as Idade
    from atletas
    inner join individuos on in_id = at_id
    order by Nome;
    
-- equipas - participações
drop view if exists v_Equipas;
create view v_Equipas as
	select e.eq_sigla as Sigla, e.eq_nome as Nome, f_Classification(pa_lugar) as Classificação, 
    p.comp_id as Competição, ev_nome as Evento
    from competicoes as c
    inner join equipas_participantes as p on c.comp_id = p.comp_id
    inner join eventos on ev_nome = c.comp_evento
    right join equipas as e on p.eq_sigla = e.eq_sigla
    order by Evento;
  
-- View que mostra todas as provas de cada evento
drop view if exists v_provas_por_evento; 
create view v_provas_por_evento as
	select ev_nome as Evento, pr_modalidade as Modalidade, concat('sub ',pr_escalao) as Escalão, pr_sexo as Sexo
    from eventos
    inner join competicoes on ev_nome = comp_evento
    inner join provas on comp_prova = pr_id
    order by Evento;
    
-- View para informação dos produtos de um alojamento
drop view if exists v_alojamentos_info;
create view v_alojamentos_info as
	select a.al_id as ID, a.al_tipologia as Tipologia, a_s.se_produto as Produto, p.se_preco as Preço
    from alojamentos as a
    inner join alojamentos_servicos as a_s on a.al_id = a_s.al_id
    inner join servicos as s on a_s.se_produto = s.se_produto
    inner join servicos_precos as p on p.se_produto = s.se_produto
    order by a.al_id;
    
-- Procedures
delimiter //
-- SP1
-- Cria uma nova competição num evento determinado
drop procedure if exists sp_criar_comp//
create procedure sp_criar_comp(in prova int, in evento varchar(30), in hora time) 
BEGIN 
	insert into competicoes values(Null, hora, evento, prova);
END//

-- SP2
-- Adiciona um atleta à lista de atletas/equipas que irão competir na competição indicada
drop procedure if exists sp_adicionar_participante//
create procedure sp_adicionar_participante(in id_comp int, in atleta_id int, in sigla char(3)) 
BEGIN 
	declare comp_sexo char(1) default 'U';
	declare v, membro, max_idade int default 0;
    declare comp_coletiva bool;
	declare c cursor for (select at_id from equipas_membros where eq_sigla = sigla);
    declare continue handler for not found set v = 1;
    
    set comp_coletiva = (select pr_coletividade 
                        from competicoes as c inner join provas as p on c.comp_prova = p.pr_id
                        where comp_id = id_comp);
    
    set comp_sexo = (select pr_sexo from competicoes inner join provas on comp_prova = pr_id where comp_id = id_comp);
    set max_idade = (select pr_escalao from competicoes inner join provas on comp_prova = pr_id where comp_id = id_comp);
    
	if sigla is not null then
		if comp_coletiva then 
			insert into equipas_participantes (comp_id, eq_sigla)values(id_comp, sigla);
			open c;
            l1: loop
				fetch c into membro;
				if v=1 then leave l1;end if;
                insert into participantes (comp_id, at_id)values(id_comp, membro);
			end loop l1;
            close c;
		end if;
        
	else  if (comp_sexo = (select at_sexo from atletas where at_id = atleta_id) or comp_sexo = 'U') 
			  and max_idade >= (select in_idade from individuos where in_id = atleta_id) then
              
		insert into participantes (comp_id, at_id)values(id_comp, atleta_id);
	end if;
	end if;
    
END//

-- SP3
-- Regista o resultado do participante na competição indicada
drop procedure if exists sp_registar_resultado//
create procedure sp_registar_resultado(in id_comp int, in participante_id int, posicao int) 
BEGIN 
declare e condition for SQLSTATE '44900';
declare exit handler for SQLSTATE '44900' select "Erro ao atualizar a posição";
	if (posicao > 0 
    and posicao <=    (select count(at_id) 
					   from participantes 
                       where comp_id = id_comp 
					   group by comp_id) 
                       
	and posicao!= all (select pa_lugar 
						from participantes 
                        where comp_id = id_comp)
	)then
		update participantes set pa_lugar = posicao
		where comp_id = id_comp and at_id = participante_id;
	else 
		signal e;
    end if;
END//

-- SP4
-- Regista o resultado da equipa e seus participantes na competição indicada
drop procedure if exists sp_registar_resultado_equipa//
create procedure sp_registar_resultado_equipa(in id_comp int,  in sigla char(3), posicao int) 
BEGIN 
declare v, membro int default 0;
declare e condition for SQLSTATE '44900';
declare c cursor for (select at_id from equipas_membros where eq_sigla = sigla);
declare continue handler for not found set v = 1;
declare exit handler for e select "Erro ao atualizar as posições de equipas";

	if (posicao > 0 
    and posicao <=    (select count(eq_sigla) 
					   from equipas_participantes 
                       where comp_id = id_comp 
					   group by comp_id) 
                       
	and posicao!= all (select pa_lugar 
						from equipas_participantes 
                        where comp_id = id_comp)
	)then
		update equipas_participantes set pa_lugar = posicao
		where comp_id = id_comp and eq_sigla = sigla;
        open c;
        l1: loop
			fetch c into membro;
            update participantes set pa_lugar = posicao
            where comp_id = id_comp and at_id = membro;
			if v=1 then leave l1;end if;
        end loop l1;
        close c;
	else 
		signal e;
    end if;
END//

-- SP5
-- Remove a competição identificada no parâmetro, nas seguintes circunstâncias:
-- a. Caso não existam resultados associados à competição (ou outros registos que sejam dependentes);
-- b. Caso existam resultados associados à competição e tenha sido enviado "True" no parâmetro force;
-- c. Caso contrário, devolve um erro.
drop procedure if exists sp_remover_comp//
create procedure sp_remover_comp(in id_comp int, in forc bool) 
BEGIN 
declare v, atleta int default 0;
declare sigla char(3);
declare err condition for SQLSTATE '45000';
declare c1 cursor for (select at_id from participantes where comp_id = id_comp);
declare c2 cursor for (select eq_sigla from equipas_participantes where comp_id = id_comp);
declare continue handler for not found set v = 1;
declare exit handler for err 
	BEGIN 	
		select "Prova tem resultados associados."; 		
	END;


	if id_comp = any (select distinct Competição from v_resultados) then
		if forc then
        open c1;
        l1: loop
			fetch c1 into atleta;
            delete from participantes where comp_id = id_comp and at_id = atleta;
			if v=1 then leave l1;end if;
        end loop l1;
        set v = 0;
        close c1;
		
        open c2;
        l2: loop
			fetch c2 into sigla;
            delete from equipas_participantes where comp_id = id_comp and eq_sigla = sigla;
			if v=1 then leave l2;end if;
        end loop l2;
        close c2;	
			
			delete from competicoes where comp_id = id_comp;
            
		else signal err;
		end if;
	else delete from competicoes where comp_id = id_comp;
	end if;

END//

-- SP6
-- Cria uma nova prova com uma cópia de todos os dados existentes na prova indicada como parâmetro
drop procedure if exists sp_clonar_prova//
create procedure sp_clonar_prova(in id_prova int) 
BEGIN 
	insert into provas (pr_coletividade, pr_escalao, pr_sexo, pr_modalidade)
    select pr_coletividade, pr_escalao, pr_sexo, pr_modalidade from provas where pr_id = id_prova;
END//

-- SP7
-- Adiciona um individuo
drop procedure if exists add_individual//
CREATE PROCEDURE add_individual(cc char(10), nome varchar(30), birthdate date, phone char(9), al_id int)
BEGIN 
	declare age int;
    set age= YEAR(CURRENT_DATE()) - YEAR(birthdate);
    insert into individuos values(NULL, cc, nome, birthdate, age, phone, al_id);
END//

-- SP8
-- Cria um evento
drop procedure if exists create_evento//
CREATE PROCEDURE create_evento(in evento  varchar(30), in local_id int, in data_inicio date, in data_final date, in organizador_id int)
BEGIN 
	declare duracao int;
    set duracao = TIMESTAMPDIFF(day, data_inicio, data_final);
    insert into eventos (ev_nome, ev_local, ev_data_inicio, ev_data_fim, ev_organizador_id, ev_duracao)
    values(evento, local_id, data_inicio, data_final, organizador_id, duracao);
END//


-- SP9
-- Remove relações entre empregados
-- Recebe como parametros o BI do empregado e um bool se true então
-- remove todos os registo que tanhão esse BI como chefe
-- se false remove o registo que tenhão esse BI como subordinado 
drop procedure if exists sp_remove_staff_rank//
create procedure sp_remove_staff_rank(in staf_id int, in boss bool) 
BEGIN 
	declare v int default 0;
	declare aux_id , aux_boss int;
	declare c cursor for table staff_rank;
	declare continue handler for not found set v = 1;
    
	if boss then
		open c;
		l1: loop 
			fetch c into aux_id , aux_boss;
			
            if aux_boss = staf_id then 
				delete from staff_rank where st_id = aux_id;
            end if;
            
			if v=1 then 
				leave l1; 
			end if;
		end loop l1;
		close c;
    else delete from staff_rank where st_id = staf_id;
    end if;
END//

-- SP10
-- Calcular o Atleta com melhores resultados num evento
-- (mais 1º lugares em competições individuais e coletivas)
drop procedure if exists sp_get_best_atlete//
create procedure sp_get_best_atlete(out best_atlete_id int) BEGIN
set best_atlete_id = (select at_id as ID
						from participantes 
						where pa_lugar = 1 
						group by at_id 
						order by count(at_id) desc 
						limit 1);
END//

-- SP11
--  Remover Atleta
drop procedure if exists sp_remove_atlete//
create procedure sp_remove_atlete(in atleta_id int) BEGIN 
	declare v, x, comboio int default 0;
    declare caminho, evento, bilhete varchar(60);
    declare c cursor for (select via_bilhete, via_caminho, via_ev_nome from viajens where via_at_id = atleta_id);
    declare continue handler for not found set v = 1;
    
    delete from participantes where at_id = atleta_id; 
    delete from equipas_membros where at_id = atleta_id;
    
    open c;
	l1: loop 
		fetch c into bilhete, caminho, evento;
		if v=1 then 
			leave l1; 
		end if;
    
		set x = 1;
		while x <= length(caminho) do
			set comboio = cast(right(left(caminho,x),1) as unsigned);
			delete from lugar where lu_viajem = bilhete and lu_com_id = comboio and lu_at_id = atleta_id;
			set x = x+2; 
		end while;
		delete from devolucoes where dev_evento = evento and dev_via_id = bilhete;
		delete from viajens where via_bilhete = bilhete;
    end loop l1;
    close c;
    
    delete from atletas where at_id = atleta_id; 
END//

-- SP12
--  Remover Equipa
drop procedure if exists sp_remove_team//
create procedure sp_remove_team(in team_sigla varchar(3)) BEGIN
    delete from equipas_participantes where eq_sigla = team_sigla;
    delete from equipas_membros where eq_sigla = team_sigla;
    delete from equipas where eq_sigla = team_sigla;
END//

-- SP13
--  atletas por freguesia Atleta
drop procedure if exists sp_fre_atletes//
create procedure sp_fre_atletes(in freguesia int) BEGIN 
	select in_nome as Nomes
    from individuos
    where al_id = any (
		select al_id 
        from alojamentos inner join freguesias on al_local = fre_id 
        where fre_id = freguesia);
END//

-- SP14
--  Dado um evento e um atleta, e com base nas localizações do evento e da morada do 
-- atleta/participante, efetuar a compra de um bilhete. O nº bilhete e o lugar devem ser 
-- gerados aleatoriamente. O preço deve constar da informação da viagem;
drop procedure if exists sp_get_ticket//
create procedure sp_get_ticket(in atleta_id varchar(8), in evento_nome varchar(30), email varchar(100), feedback varchar(500), avaliacao int) BEGIN 
	declare atleta_location, evento_local, comboio_id, x, lugar_numb int;
    declare preco double default 0;
    declare trip_path, bilhete varchar(20);
	declare reserva_data, via_data datetime;
    declare exit handler for sqlstate '45000' begin select "Erro ao reservar o bilhete"; end;
    
    set atleta_location = (
		select al.al_local 
        from individuos as i inner join alojamentos as al on i.al_id = al.al_id
        where i.in_id = atleta_id
    );
    set evento_local = (select ev_local from eventos where ev_nome = evento_nome);
    set x=0;
    set bilhete = "";
    while x<9 do 
		set bilhete = concat(bilhete,right(left("123456789ABCDEFGHIJKLMNOPRSTUVWXYZ",cast((rand()*100%34)+1 as unsigned)),1));
        set x = x + 1;
    end while;
	set reserva_data = now();
	set via_data = (select ev_data_inicio from eventos where ev_nome = evento_nome);
	set trip_path = f_trainPath(atleta_location, evento_local);
	
	set x = 1;
    WHILE x <= length(trip_path) DO
			set comboio_id = cast(right(left(trip_path,x),1) as unsigned);
			set preco = preco + (select com_preco from comboios where com_id = comboio_id);
            set x = x + 2;
	END WHILE;

	insert into viajens values (bilhete, atleta_id, evento_nome, preco, email, feedback, avaliacao, reserva_data, via_data, trip_path);
    
    
    set x = 1;
    while x <= length(trip_path) do
		set comboio_id = cast(right(left(trip_path,x),1) as unsigned);
        set lugar_numb = f_trainTickets(comboio_id) + 1;
        insert into lugar values(bilhete, comboio_id, atleta_id, lugar_numb);
		set x = x+2;
    end while; 
    
END//

-- SP15
--  Dado um evento, proceder à devolução do valor de desconto a todos os atletas que 
-- utilizaram a parceria CP-Comboios;
drop procedure if exists sp_rembolse//
create procedure sp_rembolse(in evento_nome varchar(30)) BEGIN 
    declare v, desconto, comboio_id, atleta, x int default 0;
    declare dinh_devolvido double;
    declare bilhete, caminho varchar(10);
	declare c cursor for (select via_bilhete, via_at_id, via_caminho from viajens where via_ev_nome = evento_nome);
    declare continue handler for not found set v = 1;
    
		open c;
		l1: loop 
			fetch c into bilhete, atleta, caminho;
            if v=1 then 
				leave l1; 
			end if;
            set dinh_devolvido = 0;
            set x = 1;
			while x <= length(caminho) do
				set comboio_id = cast(right(left(caminho,x),1) as unsigned);
                set desconto = (select par_desconto from parcerias where par_ev_nome = evento_nome and par_com_id = comboio_id);
                if desconto is null then set desconto = 0; end if;
                set dinh_devolvido = dinh_devolvido + ((select com_preco from comboios where com_id = comboio_id)*(desconto/100));
			    set x = x+2; 
			end while;
			if bilhete != all (select dev_via_id from devolucoes where dev_evento = evento_nome) then
				insert into devolucoes values (evento_nome, bilhete, dinh_devolvido);
            end if;
		end loop l1;
		close c;
END//

-- SP16
-- Ao cancelar uma viagem, deve ser enviado um email a cada atleta que tem bilhete.
drop procedure if exists sp_cancel_trip//
create procedure sp_cancel_trip(in comboio_id int) BEGIN 
	declare v, atleta, comboio, x int default 0;
	declare email, bilhete, evento, caminho varchar(100);
	declare c cursor for (select lu_viajem, lu_at_id
						 from lugar
                         where lu_com_id = comboio_id);
	declare continue handler for not found set v = 1;
    
	open c;
		l1: loop 
			fetch c into bilhete, atleta;
            if v=1 then 
				leave l1; 
			end if;
            
            set email = (select via_email from viajens where via_at_id = atleta);
            select concat(email,": Comboio-", comboio_id,"\nBilhete - ", bilhete," cancelado.")as 'Email enviado';
            
            set evento = (select dev_evento from devolucoes where dev_via_id = bilhete);
            set caminho = (select via_caminho from viajens where via_bilhete = bilhete);
            set x = 1;
			while x <= length(caminho) do
				set comboio = cast(right(left(caminho,x),1) as unsigned);
				delete from lugar where lu_viajem = bilhete and lu_com_id = comboio and lu_at_id = atleta;
                set x = x+2; 
			end while;
            delete from devolucoes where dev_evento = evento and dev_via_id = bilhete;
            delete from viajens where via_bilhete = bilhete;
            
			
		end loop l1;
		close c;
END//

-- Triggers

-- result_change – Regista na tabela de tbl_logs (a criar na base de dados), pelos menos, os seguintes 
-- dados:
-- o Data e hora da operação;
-- o Identificação do atleta/equipa;
-- o Identificação da prova;
-- o Resultado anterior;
-- o Novo resultado;
-- o Posição (1º, 2º, …).
drop trigger if exists result_change //
create trigger result_change
before update
on participantes
for each row BEGIN 
	declare date_time datetime;
    set date_time = now();
	insert into tbl_logs values(NULL, date_time, old.at_id, old.comp_id, new.pa_lugar, old.pa_lugar);
END//


-- • Outro trigger (nome e características a definir pelo grupo) que mantenha um log atualizado com 
-- informação sobre os resultados removidos da base de dados.
drop trigger if exists result_delete //
create trigger result_delete
before delete
on participantes
for each row BEGIN 
	declare date_time datetime;
    set date_time = now();
	insert into tbl_logs values(NULL, date_time, old.at_id, old.comp_id, -1, old.pa_lugar);
END//

-- • Não permitir que um atleta adquira mais que um bilhete para um mesmo evento; Não permitir ultrapassar o nº de lugares disponíveis para um comboio.
drop trigger if exists check_viajens //
create trigger check_viajens
	before insert
on viajens
for each row BEGIN 
	declare lugar_numb, tickets_count, comboio_id, atleta_id, x int;
    declare bilhete varchar(9);
    declare evento varchar(30);
    
    set atleta_id = new.via_at_id;
    set bilhete = new.via_bilhete;
    
	if f_hasTicket(new.via_ev_nome, new.via_at_id) = 1 then
		signal sqlstate '45000';
	end if;
        
    set x = 1;
    while x <= length(new.via_caminho) do
		set comboio_id = cast(right(left(new.via_caminho,x),1) as unsigned);
        set lugar_numb = f_trainTickets(comboio_id) + 1;
		if lugar_numb > (select com_lugares from comboios where com_id = comboio_id) then
            signal sqlstate '45000';
		end if;
		set x = x+2;
    end while; 
END//
delimiter ;