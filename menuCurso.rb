def menuCurso(lista_cursos, lista_disciplinas)
	menu = 0
	while(menu != 6) do
		puts "\nCursos"
		puts "Digite o numero correspondente ao comando desejado"
		puts "----------------------------------------------------"
		puts "1 - Listar Cursos"
		puts "2 - Adicionar Curso"
		puts "3 - Alterar dados de um Curso"
		puts "4 - Remover Curso"
		puts "5 - Alterar disciplinas de um curso"
		puts "6 - Voltar"
		puts "----------------------------------------------------"

		menu = gets.to_i
		#Le um inteiro

		system "clear"
		#limpar a tela do terminal

		case menu
		when 1
			if (lista_cursos.size == 0)
				puts "Não há cursos cadastrados."
			else
				lista_cursos.each {|curso| curso.imprime()}
			end
		when 2
			puts "Adicionar curso"
			puts "Digite o nome: "
			nome = gets
			puts "Digite o código: "
			codigo = gets.to_i
			puts "Digite a duracao: "
			duracao = gets.to_i
			curso = Curso.new(codigo,nome,duracao)
			lista_cursos << curso
		when 3
			puts "Alterar dados de um curso"
			puts "Digite o nome do curso: "
			nome = gets
			puts "Digite o codigo do curso: "
			codigo = gets.to_i
			encontrou = false
			lista_cursos.each {|curso|
				if (curso.codigo == codigo && curso.nome == nome)
					puts "Curso encontrado!"
					puts "Digite o novo nome: "
					curso.nome = gets
					puts "Digite o novo codigo: "
					curso.codigo = gets.to_i
					puts "Digite a nova duracao: "
					curso.duracao = gets
					puts "Dados alterados com sucesso!"
					encontrou = true
				end
			}
			if encontrou == false
				puts "Curso nao encontrado."
			end

		when 4
			puts "Remover curso"
			puts "Nome do curso: "
			nome = gets
			puts "Codigo do curso: "
			codigo = gets.to_i
			curso = Curso.new(codigo, nome, 0) #duracao 0 apenas para cumprir o construtor
			begin
				lista_cursos.delete(curso) { raise NotFoundError.new } #se nao existir, retorna o bloco e levanta a excecao
				puts "Curso excluído."
			rescue NotFoundError => e
				puts e.message
			end

		when 5
			puts "Alterar disciplinas de um curso"
			puts "Nome do curso para ser alterado: "
			nome = gets
			puts "Codigo do curso para ser alterado: "
			codigo = gets.to_i
			procura = Curso.new(codigo, nome, 0)
			encontrado = false
			lista_cursos.each { |curso|
				if procura == curso
					procura = curso
					encontrado = true
					break
				end
			}
			if encontrado
				menuDisciplinaCurso(procura, lista_disciplinas)
				#puts "Curso atual: 	#{procura.nome} | #{procura.codigo}"
				#puts "Digite o semestre no qual as disciplinas serão alteradas: "
				#semestre = gets.to_i
				#menuDisciplina(procura.disciplinas[semestre -1 ])
			else
				puts "Item não encontrado."
			end
		when 6
			puts "Voltar"
		else
			puts "Opçao inválida."
		end
	end
end