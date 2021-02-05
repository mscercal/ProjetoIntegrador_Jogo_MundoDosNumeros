CREATE TABLE escola(
	codigo_escola SERIAL PRIMARY KEY NOT NULL,
	nome CHARACTER VARYING(50) NOT NULL,
	diretor CHARACTER VARYING(50) NOT NULL,
	CNPJ CHARACTER VARYING(20) NOT NULL
);
CREATE TABLE turma(
	codigo_turma SERIAL PRIMARY KEY NOT NULL,
	turno CHARACTER VARYING(20) NOT NULL,
	numero_turma CHARACTER VARYING(10) NOT NULL
);
CREATE TABLE endereco (
	codigo_endereco SERIAL PRIMARY KEY NOT NULL,
	codigo_usuario INTEGER NOT NULL REFERENCES usuario(codigo_usuario),
	estado CHARACTER VARYING(100) NOT NULL,
	cidade CHARACTER VARYING(100) NOT NULL,
	bairo CHARACTER VARYING(100) NOT NULL,
	rua CHARACTER VARYING(100) NOT NULL,
	numero CHARACTER VARYING(20) NOT NULL,
	complemento CHARACTER VARYING(20) NOT NULL,
	CEP CHARACTER VARYING(20) NOT NULL
);
CREATE TABLE usuario(
	codigo_usuario SERIAL PRIMARY KEY NOT NULL,
	nome CHARACTER VARYING(100) NOT NULL,
	data_nascimento DATE NOT NULL
);
CREATE TABLE professor(
	codigo_professor SERIAL PRIMARY KEY NOT NULL,
	codigo_usuario INTEGER NOT NULL REFERENCES usuario(codigo_usuario),
	CPF CHARACTER VARYING(14) NOT NULL	
);
CREATE TABLE aluno(
	codigo_aluno SERIAL PRIMARY KEY NOT NULL,
	codigo_usuario INTEGER NOT NULL REFERENCES usuario(codigo_usuario),
	codigo_turma INTEGER NOT NULL REFERENCES turma(codigo_turma),
	desempenho CHARACTER VARYING(50),
	media DECIMAL(4,2),
	serie INTEGER NOT NULL
);
CREATE TABLE dica(
	codigo_dica SERIAL PRIMARY KEY NOT NULL,
	conteudo_dica CHARACTER VARYING(500) NOT NULL
);
CREATE TABLE alternativa(
	codigo_alternativa SERIAL PRIMARY KEY NOT NULL,
	conteudo_alternativa CHARACTER VARYING(1000) NOT NULL,
	resposta_correta INTEGER NOT NULL
);
CREATE TABLE pergunta(
	codigo_pergunta SERIAL PRIMARY KEY NOT NULL,
	codigo_alternativa INTEGER NOT NULL REFERENCES alternativa(codigo_alternativa),
	conteudo_pergunta CHARACTER VARYING(500) NOT NULL,
	dificuldade CHARACTER VARYING(20) NOT NULL,
	serie INTEGER NOT NULL
);

ALTER TABLE dica ADD codigo_pergunta INTEGER REFERENCES pergunta(codigo_pergunta)
ALTER TABLE pergunta ADD codigo_dica INTEGER REFERENCES dica(codigo_dica)

CREATE TABLE escola_professor(
	codigo_escola INTEGER NOT NULL REFERENCES escola(codigo_escola),
	codigo_professor INTEGER NOT NULL REFERENCES professor(codigo_professor),
	CONSTRAINT escola_professor_pk PRIMARY KEY (codigo_escola,codigo_professor)
);
CREATE TABLE professor_turma(
	codigo_turma INTEGER NOT NULL REFERENCES turma(codigo_turma),
	codigo_professor INTEGER NOT NULL REFERENCES professor(codigo_professor),
	CONSTRAINT professor_turma_pk PRIMARY KEY (codigo_turma,codigo_professor)
);
CREATE TABLE aluno_pergunta(
	codigo_aluno INTEGER NOT NULL REFERENCES aluno(codigo_aluno),
	codigo_pergunta INTEGER NOT NULL REFERENCES pergunta(codigo_pergunta),
	CONSTRAINT aluno_pergunta_pk PRIMARY KEY (codigo_aluno,codigo_pergunta),
	resposta_correta INTEGER NOT NULL REFERENCES alternativa(codigo_alternativa) 
)