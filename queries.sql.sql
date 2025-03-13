-- 1.1. Lista de participantes masculinos
	Select in_cc as BI, in_nome as Nome, f_age(in_dnsc) as Idade
    from atletas inner join individuos on at_id = in_id
    where at_sexo = 'M';
    
-- 1.2. Lista de participantes femininos.
	Select in_cc as BI, in_nome as Nome, f_age(in_dnsc) as Idade
    from atletas inner join individuos on at_id = in_id
    where at_sexo = 'F';
    
-- 2.1. Lista de equipas que não participaram em qualquer prova
	Select eq_sigla as 'Sigla', eq_nome as 'Nome'
    from equipas
    where eq_sigla != all(select Sigla from v_equipas group by Sigla);
    
-- 2.2. Lista de equipas com mais de 5 membros
	select e_m.eq_sigla as Sigla, eq_nome as Nome, count(*) as Membros
    from equipas_membros as e_m inner join equipas as e on e.eq_sigla = e_m.eq_sigla
    group by e_m.eq_sigla
    having count(*) > 5
    order by count(*) DESC;

-- 3.1. Lista de competições e evento individuais 
	select comp_evento as Evento, comp_id as 'ID de Competição'
    from competicoes
    where comp_prova in (select pr_id
						from provas
                        where pr_coletividade = false);
                        
-- 3.2. Lista de competições do evento  coletivos
	select comp_evento as Evento, comp_id as 'ID de Competição'
    from competicoes
    where comp_prova in (select pr_id
						from provas
                        where pr_coletividade = true);

-- 4.1. Lista de alojamentos com mais de 100m^2
	select al_id as 'ID do alojamento',al_divisoes as Divisões, al_wc as 'Casas de Banho',
    al_CozinhaPart as 'Cozinha Partilhada', al_tipologia as Tipologia, al_area as Area
    from alojamentos
    where al_area > 100
    order by Area ASC;
    
-- 4.2. Lista de alojamentos sem cozinha partilhada
	select al_id as 'ID do alojamento',al_divisoes as Divisões, al_wc as 'Casas de Banho', 
    al_tipologia as Tipologia, al_area as Area
    from alojamentos
    where al_cozinhaPart = false;

-- 4.3. Lista de alojamentos com mais de 3 divisões
	select al_id as 'ID do alojamento',al_divisoes as Divisões, al_wc as 'Casas de Banho',
    al_CozinhaPart as 'Cozinha Partilhada', al_tipologia as Tipologia, al_area as Area
    from alojamentos
    where al_divisoes >3
    order by al_divisoes ASC;

-- 5. Lista de resultados de cada competição realçando os participantes que foram medalhados 
-- (3 primeiros de cada competição);
	Select Evento, Competição , Nome, Classificação
    from v_resultados
    where Classificação = 'Ouro' or Classificação = 'Prata' or Classificação = 'Bronze';

-- 6. Lista de participantes individuais que não participaram em qualquer competição;
	Select at_id as BI, in_nome as Nome, f_age(in_dnsc) as Idade
    from atletas inner join individuos on at_id = in_id
    where at_id != all (select at_id from participantes) 
	  and at_id != all (select at_id 
						from equipas_membros as m inner join equipas_participantes as p on m.eq_sigla = p.eq_sigla);
    

-- 7. Lista, organizada por tipologia, dos alojamentos com indicação da área média, mínima, 
-- máxima e desvio padrão;
	select al_tipologia as Tipologia, avg(al_area) as 'Area Media', min(al_area) as 'Area Minima', max(al_area) as 'Arae Maxima', variance(al_area) as 'Desvio Padrão'
    from alojamentos
    group by Tipologia
    order by Tipologia ASC;
		
-- 8.1. Lista com o idade média, mínima, máxima e desvio padrão dos participantes por evento
	select Evento, avg(in_idade) as 'Idade Media', min(in_idade) as 'Idade Minima', 
    max(in_idade) as 'Idade Maxima', variance(in_idade) as 'Desvio Padrão'
    from v_resultados inner join individuos on BI = in_cc
    group by Evento;
    
-- 8.2. Lista com o número médio, mínimo, máximo e desvio padrão dos participantes em cada 
-- competição por evento
	select comp_evento as Evento, avg(aux.numb) as 'Media de Participações', min(aux.numb) as 'Minimo de Participações', 
    max(aux.numb) as 'Maximo de Participações', variance(aux.numb) as 'Desvio Padrão'
    from competicoes inner join (select p.comp_id as 'id', count(p.at_id) as 'numb'
								from participantes as p 
								group by  p.comp_id) aux 
	on aux.id = comp_id
    group by comp_evento;

-- 9.1. Lista com o número médio, mínimo, máximo e desvio padrão dos participantes por 
-- competição Masculino
	select aux.id as 'ID Competição', avg(aux.numb) as 'Nº Medio', min(aux.numb) as 'Nº Minimo', 
    max(aux.numb) as 'Nº Maximo', variance(aux.numb) as 'Desvio Padrão'
    from    (select a.pr_id as id, count(p.at_id) as numb, p.comp_id
			from participantes as p inner join 
							(select pr_id, comp_id  
							from competicoes inner join provas on pr_id = comp_prova 
							where comp_prova = any(select pr_id from provas where pr_sexo = 'M')
							)as a on a.comp_id = p.comp_id
			group by a.pr_id
			) as aux
	group by aux.id
    order by aux.id;
    
-- 9.2. Lista com o número médio, mínimo, máximo e desvio padrão dos participantes por
-- prova Femenino
	select aux.id as 'ID Competição', avg(aux.numb) as 'Nº Medio', min(aux.numb) as 'Nº Minimo', 
    max(aux.numb) as 'Nº Maximo', variance(aux.numb) as 'Desvio Padrão'
    from    (select a.pr_id as id, count(p.at_id) as numb, p.comp_id
			from participantes as p inner join 
							(select pr_id, comp_id  
							from competicoes inner join provas on pr_id = comp_prova 
							where comp_prova = any(select pr_id from provas where pr_sexo = 'F')
							)as a on a.comp_id = p.comp_id
			group by a.pr_id
			) as aux
	group by aux.id
    order by aux.id;
    
-- 10. Lista de alojamentos cujo total de itens associados (micro-ondas, forno, A/C, etc.)
-- é superior a 4. A listagem deve ser ordenada e apresentar no topo os alojamentos com 
-- maior número de itens;
	select al_id as 'ID Alojamento', count(distinct it_nome) as'Nº de Itens'
    from alojamentos_itens
    group by al_id
    having count(distinct it_nome) > 4
    order by count(distinct it_nome) DESC;
    
-- 11. Top 5 das competiçôes com maior número de participantes;
	select p.comp_id as 'ID Competição', count(p.at_id) as 'Nº de Participantes'
	from participantes as p 
	group by  p.comp_id
    order by count(p.at_id) DESC
    limit 5;
    
-- 12. Lista dos 5 participantes com mais medalhas (seja a participação individual ou coletiva);
	select BI, Nome, count(*) as 'Nº de Medalhas'
	from (Select BI, Nome
		  from v_resultados
		  where Classificação = 'Ouro' or Classificação = 'Prata' or Classificação = 'Bronze') aux
	group by BI
    order by count(*) desc
    limit 5;
    
-- 13. Lista de todos as freguesias, conselhos e distritos a que pertencem
-- (Consulta adicional recorrendo a, pelo menos, 3 tabelas;)
	select fre_nome as Freguesia, con_nome as Conselho, ds_nome as Distrito
    from distritos inner join conselhos on ds_id = con_distrito
    inner join freguesias  on fre_conselho = con_id
    order by Distrito, Conselho, Freguesia asc;
    
-- 14. Lista de chefes que tenham mais de 4 funcionarios com mais de 30 anos 
-- (Consulta adicional recorrendo a, pelo menos, 3 tabelas que inclua WHERE e HAVING;)
	select i.in_cc as BI, i.in_nome as Nome, f.st_nif as 'Nº Fiscal', f.st_titulo as 'Titulo Profissional', count(r.st_id) as 'Nº de Subordinados'
    from staff_rank as r inner join staff as f on r.st_chefe_id = f.st_id
    inner join individuos as i on i.in_id = f.st_id
    where f_age(in_dnsc) > 30
    group by r.st_chefe_id
    having count(r.st_id)>4;
   

-- 15. Lista de individuos alojamentos e freguesias
select in_nome as Nome, al_tipologia as Alojamento, fre_nome as Freguesia
from individuos as i
inner join alojamentos as a on i.al_id = a.al_id
inner join freguesias as f on a.al_local = f.fre_id
order by Freguesia, Alojamento, Nome asc;

-- Listar, por atleta, as viagens das suas deslocações. As deslocações compostas por várias 
-- viagens, devem ser apresentadas segundo a “ordem” da viagem;
select in_nome as Nome, via_caminho as Comboios, via_preco as Preço
from viajens inner join atletas on via_at_id = at_id
			 inner join individuos on in_id = at_id;

-- Apresentar, por viagem, o número de atletas/participantes que reservaram deslocação;
select lu_com_id as Comboio, count(lu_at_id) as 'Numero de reservas'
from lugar
group by lu_com_id;

-- Obter a média das avaliações associadas a uma viagem;
select lu_com_id as Comboio, avg(via_avaliacao) as "Avaliação Media"
from lugar inner join viajens on lu_viajem = via_bilhete
group by lu_com_id;

-- Obter os comentários feitos a uma viagem (cronologicamente).
select par_com_id as Comboio, in_nome as nome, via_feedback as Comentario, via_res_data_hora as 'Data'
from viajens inner join parcerias on via_ev_nome = par_ev_nome
			 inner join atletas on via_at_id = at_id
			 inner join individuos on in_id = at_id
order by via_res_data_hora desc;
