DROP DATABASE IF EXISTS projeto_BD ;
create DATABASE projeto_BD;
USE projeto_BD;

CREATE TABLE distritos(
	ds_id int auto_increment primary key,
    ds_nome varchar(30)
);
CREATE TABLE conselhos(
	con_id int auto_increment primary key,
	con_nome varchar(30),
    con_distrito int,
    foreign key (con_distrito) references distritos(ds_id)
);
CREATE TABLE freguesias(
	fre_id int auto_increment primary key,
	fre_nome varchar(30),
    fre_conselho int,
    foreign key (fre_conselho) references conselhos(con_id)
);

CREATE TABLE tipologias(
	tip_nome varchar(30) primary key, 
	tip_desc varchar(200) default('Sem descrição') not null
);

CREATE TABLE alojamentos(
	al_id int auto_increment primary key,
    al_divisoes int not null default(0),
    al_wc int not null default(0),
    al_cozinhaPart bool not null default(1),
    al_area double not null check(al_area > 0),
    al_coordenadas varchar(8) not null unique,
    al_morada varchar(200) not null unique,
    al_tipologia varchar(30) ,
    al_local int,
    foreign key (al_tipologia) references tipologias(tip_nome),
    foreign key (al_local) references freguesias(fre_id)   
);
CREATE TABLE itens(
	it_nome varchar(30) primary key,
	it_desc varchar(200) default('Sem descrição') not null,
	it_ip char(16) not null unique,
	it_dataHora datetime not null
);

CREATE TABLE servicos(
	se_produto varchar(30) primary key,
    se_desc varchar(200) default('Sem descrição') not null
);
CREATE TABLE fornecedores(
	fo_nome varchar(30) primary key,
    fo_desc varchar(200) default('Sem descrição') not null
);

CREATE TABLE servicos_precos(
	fo_nome varchar(30),
    se_produto varchar(30),
    tip_nome varchar(30),
    se_preco double check(se_preco>=0) not null,
    primary key (fo_nome, se_produto, tip_nome),
    foreign key (fo_nome) references fornecedores(fo_nome),
    foreign key (se_produto) references servicos(se_produto),
    foreign key (tip_nome) references tipologias(tip_nome)
);
CREATE TABLE alojamentos_itens(
	al_id int,
    it_nome varchar(30),
    primary key (al_id, it_nome),
    foreign key (it_nome) references itens(it_nome),
    foreign key (al_id) references alojamentos(al_id)
);
CREATE TABLE alojamentos_servicos(
	al_id int,
    se_produto varchar(30),
	primary key (al_id, se_produto),
    foreign key (al_id) references alojamentos(al_id),
    foreign key (se_produto) references servicos(se_produto)
);

CREATE TABLE individuos(
	in_id int auto_increment primary key,
	in_cc char(8) unique,
    in_nome varchar(50) not null, 
    in_dnsc date not null, 
    in_idade int,
    in_telemovel char(9) unique, 
    al_id int,
    foreign key (al_id) references alojamentos(al_id)
);
CREATE TABLE atletas(
	 at_id int primary key, 
     at_peso double not null check(at_peso>0), 
     at_altura double not null check(at_altura>0),  
     at_sexo char(1) not null default('I') check(at_sexo='M' or at_sexo='F' or at_sexo='I'),
    foreign key (at_id) references individuos(in_id)
);
CREATE TABLE treinadores(
	tr_id int primary key,
    tr_titulo varchar(60) not null default('Sem titulo profissional'),
    foreign key (tr_id) references individuos(in_id)
);
CREATE TABLE staff(
	st_id int primary key,
    st_nif char(9) not null unique,
    st_titulo varchar(60) not null default('Sem titulo profissional'),
    foreign key (st_id) references individuos(in_id)
);
CREATE TABLE staff_rank(
	st_id int primary key,
    st_chefe_id int,
    foreign key (st_id) references staff(st_id),
    foreign key (st_chefe_id) references staff(st_id)
);

CREATE TABLE equipas(
	eq_sigla char(3) primary key,
    eq_nome varchar(30) not null unique,
    tr_id int,
    foreign key (tr_id) references treinadores (tr_id)
);
CREATE TABLE equipas_membros(
	eq_sigla char(3),
    at_id int,
	primary key (eq_sigla, at_id),
    foreign key (eq_sigla) references equipas(eq_sigla),
    foreign key (at_id) references atletas(at_id)
);
CREATE TABLE modalidades(
	mod_nome varchar(30) primary key,
    mod_desc varchar(200) default('Sem descrição') not null 
);
CREATE TABLE provas(
	pr_id int auto_increment primary key, 
    pr_coletividade bool not null, 
    pr_escalao int not null, 
    pr_sexo char(1) not null check(pr_sexo='M' or pr_sexo='F' or pr_sexo='U'),  
    pr_modalidade varchar(30),
    foreign key (pr_modalidade) references modalidades(mod_nome)
);
CREATE TABLE eventos(
	ev_nome varchar(30) primary key,
    ev_local int ,
    ev_data_inicio datetime not null, 
    ev_data_fim datetime not null,
    ev_duracao int, -- dias
    ev_estado bool default(0), 
    ev_organizador_id int,
    foreign key (ev_local) references freguesias(fre_id),
    foreign key (ev_organizador_id) references staff(st_id)
);
CREATE TABLE competicoes(
	comp_id int auto_increment primary key, 
    comp_hora time not null,
    comp_evento varchar(30),
    comp_prova int,
    foreign key (comp_evento) references eventos(ev_nome),
    foreign key (comp_prova) references provas(pr_id)
);

CREATE TABLE participantes(
	comp_id int,
    at_id int,
    pa_lugar int default(-1),-- (-1) representa sem classificação ainda
    primary key(comp_id, at_id),
    foreign key (comp_id) references competicoes(comp_id), 
    foreign key (at_id) references atletas (at_id)
);
CREATE TABLE equipas_participantes(
	comp_id int,
    eq_sigla char(10),
    pa_lugar int default(-1),-- (-1) representa sem classificação ainda
    primary key(comp_id, eq_sigla),
    foreign key (comp_id) references competicoes(comp_id), 
    foreign key (eq_sigla) references equipas(eq_sigla)
);
CREATE TABLE funcoes(
	fu_nome varchar(30) primary key, 
    fu_descricao varchar(200) default('Sem descrição') not null
);

CREATE TABLE trabalhos(
	tr_evento varchar(30),
    tr_nome varchar(30),
    tr_staff_id int,
    primary key(tr_evento, tr_nome, tr_staff_id),
    foreign key (tr_evento) references eventos(ev_nome),
    foreign key (tr_nome) references funcoes(fu_nome),
    foreign key (tr_staff_id) references staff(st_id)
);

CREATE TABLE  linhas(
	li_id int primary key auto_increment, 
    li_caminho varchar(100)
);

CREATE TABLE  comboios(
	com_id int primary key auto_increment, 
    com_li_id int,
	com_tipo varchar(50) not null,
	com_preco double not null,
	com_lugares int not null,
    foreign key (com_li_id) references linhas (li_id)
);

CREATE TABLE parcerias(
	par_id int auto_increment primary key,
    par_com_id int,
    par_ev_nome varchar(30),
    par_desconto int,
    unique (par_com_id, par_ev_nome),
    foreign key (par_com_id) references comboios(com_id),
    foreign key (par_ev_nome) references eventos(ev_nome)
);



CREATE TABLE  viajens(
	via_bilhete varchar(9) primary key,
	via_at_id int,
    via_ev_nome varchar(30),
	via_preco double not null,
	via_email varchar(100),
	via_feedback varchar(500),
	via_avaliacao int,
	via_res_data_hora datetime not null,
	via_data_hora datetime not null,
	via_caminho varchar(20) not null,
	foreign key (via_at_id) references atletas(at_id),
    foreign key (via_ev_nome) references eventos(ev_nome)
 );
CREATE TABLE  lugar( 
    lu_viajem varchar(9),
    lu_com_id int,
    lu_at_id int,
    lu_lugar int not null,
    primary key (lu_viajem, lu_com_id, lu_at_id),
    foreign key (lu_viajem) references viajens(via_bilhete),
    foreign key (lu_com_id) references comboios(com_id),
    foreign key (lu_at_id) references atletas(at_id)
);
CREATE TABLE  devolucoes(
	dev_evento varchar(30) , 
    dev_via_id varchar(9), 
    dev_dinheiro_devolvido double,
    primary key (dev_evento, dev_via_id),
    foreign key (dev_via_id) references viajens(via_bilhete),
    foreign key (dev_evento) references eventos(ev_nome)
);

CREATE TABLE  tbl_logs(
	logs_id int auto_increment primary key,
    logs_date_time datetime ,
	logs_in_id int not null,
	logs_comp_id int not null,
    logs_new_rank int not null,
 	logs_old_rank int not null
);