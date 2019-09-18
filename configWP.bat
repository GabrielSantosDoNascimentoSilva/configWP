@echo off
:MenuInicial
	cls
	echo MENU INICIAL
	echo Escolha uma opção:
	echo 1 - Clonar Site
	echo 2 - Acessar FTP/SSH
	echo 3 - Instalar Wordpress na maquina local
	echo 4 - Migrar Site de Hospedagem
	echo 5 - Menu para todos os sites
	echo 6 - Configurar Site - Menu Principal
	echo 0 - Sair
	set /p opc=Digite o Numero da Opção:

	if /I "%opc%" EQU "1" goto :ClonarSite
	if /I "%opc%" EQU "2" goto :AcessarFTPeSSH
	if /I "%opc%" EQU "3" goto :InstalarWordpressNoXAMP
	if /I "%opc%" EQU "4" goto :MigrarSite
	if /I "%opc%" EQU "5" goto :MenuConfigTodosSites
	if /I "%opc%" EQU "0" exit
:LogarNoSiteWordpress
	cls
	set /p opc=Qual o site da proxima tarefa?
	start chrome "%opc%" "%opc%/wp-admin" --incognito
:MenuConfigTodosSites
	cls
	echo MENU PRINCIPAL
	echo Escolha uma opção:
	echo 1 - Instalar Plugin em todos os sites
	echo 2 - Atualizar Plugins Premium em Todos os sites
	echo 3 - Criar Usuário para todos os sites
	echo 4 - Excluir Usuário para todos os sites
	echo 5 - Menu para todos os sites
	echo 7 - Conferir se Todos os sites estão online
	echo 0 - Sair
	set /p opc=Digite o Numero da Opção: 

	if /I "%opc%" EQU "1" goto :ClonarSite
	if /I "%opc%" EQU "2" goto :AcessarFTPeSSH
:MenuPrincipal
	cls
	set /p dominio=Qual site você deseja configurar? 
	
	echo MENU PRINCIPAL PARA CONFIGURAÇÕES NO SITE
	echo Escolha uma opção:
	echo 1 - Responder Briefing
	echo 2 - Colocar site no arquivo de Hosts (Para Editar enquanto está em propagação)
	echo 3 - Fazer as Configurações Iniciais do Wordpress
	echo 4 - Achar e Substituir Palavra/Código por SSH
	echo 5 - Ativar HTTPS
	echo 6 - Desativar HTTPS
	echo 7 - Fazer as Configurações Finais do Wordpress
	echo 8 - Criar Usuário
	echo 9 - Pegar Banco de Dados
	echo 10 - Instalar o Wp Smush pro e comprimir as imagens
	echo 11 - Fazer Backup, Jogar no Google Drive e fazer comentário de "Link do Backup"
	echo 0 - Voltar para o Menu Inicial
	set /p opc=Digite o Numero da Opção: 

	if /I "%opc%" EQU "0" goto :ResponderBriefing
	if /I "%opc%" EQU "1" goto :AcessarArquivoDeHosts
	if /I "%opc%" EQU "2" goto :ConfigPreTema
	if /I "%opc%" EQU "3" goto :DefinirCores
	if /I "%opc%" EQU "4" goto :ProcurarTermo
	if /I "%opc%" EQU "5" goto :AtivarHTTPS
	if /I "%opc%" EQU "6" goto :DesativarHTTPS
	if /I "%opc%" EQU "7" goto :ConfigFinal
	if /I "%opc%" EQU "8" goto :CriarUsuario
	if /I "%opc%" EQU "9" goto :AtivarHTTPS
	if /I "%opc%" EQU "10" goto :AtivarHTTPS
	if /I "%opc%" EQU "11" goto :FazerBackupEColocarNoGoogleDrive
	if /I "%opc%" EQU "12" goto :AtivarHTTPS
:ResponderBriefing
	cls
	set /p nome-do-site=Insira nome do site: 
	set /p slogan-do-site=Insira slogan do site: 
	set /p email-principal=Insira email principal: 
	set /p telefone-principal=Insira telefone: 
	set /p endereco=Insira endereço: 
	set /p logo=Insira logo: 
	set /p favicon=Insira favicon: 
	set /p cor-primaria=Insira Cor Primária: 
	set /p cor-secundaria=Insira Cor Secundária: 
	set /p blog=Vai Ter Blog? 
	set /p zip-do-tema=Insira slogan do zip do tema: 
	::upar o logo, telefone email, para  para construir o comming soon
	goto :MenuPrincipal
:AcessarFTPeSSH
	cls
	echo 1 - Hospedagem 1
	echo 2 - Hospedagem 2
	echo 3 - Hospedagem 3
	set /p opc=Qual o host de conexão?:

	if "%opc%" == "1" ( 
		start filezilla sftp://root:%senha%@%host%:22/../srv
	)
	if "%opc%" == "2" ( 
		start filezilla sftp://root:%senha%@%host%:22/../srv
	)
	if "%opc%" == "3" ( 
		start filezilla sftp://root:%senha%@%host%:22/../srv
	)
	goto :MenuPrincipal
	
:ConfigServidor
	:: Colocar no php.ini
		:: post_max_size = 800M 
		:: upload_max_filesize = 800M 
		:: max_execution_time = 5000 
		:: max_input_time = 5000 
		:: memory_limit = 1000M 
	:: Troca a senha do usuário FTP/SSH, coloca o PHP está na Versão 7.3, habilita o php de exibir logs de erros, e se o domínio estiver correto Ativar o Let’s Encrypt (SSL)

:AcessarArquivoDeHosts
	cls
	:: start notepad++ c:\windows\system32\drivers\etc\hosts
	echo %ip-do-host% %dominio% >> c:\windows\system32\drivers\etc\hosts
	goto :MenuPrincipal
:ClonarSite
	cls
	set /p modelo=Digite o domínio do site para clonar - Ex: desenvolvimentoemfoco.com.br: 
	sudo -u %usuario-do-site% wp plugin uninstall all-in-one-wp-migration --deactivate
	sudo -u %usuario-do-site% wp plugin install all-in-one-wp-migration --version=6.77 --activate
	::baixar o backup do modelo para a pasta do ai1wpm
	::wp ai1wm restore backup.wpress
	:: Trocar o Nome do antigo site para o novo
	sudo -u %usuario-do-site% wp search-replace '%modelo%' '%nome-do-site%'
	goto :MenuPrincipal
:ConfigPreTema
	cls
	:: Ativar o Modo DEBUG do Wordpress para indentificar e corrigir os erros mais rápidos
	sudo -u %usuario-do-site% wp config set WP_DEBUG true
	:: Em Configurações > Leitura > Marcar a Caixa "Evitar que mecanismos de busca indexem este site"
	sudo -u %usuario-do-site% wp option update blog_public 0
	:: Em Configurações > Geral > Alterar o Titulo do Site
	sudo -u %usuario-do-site% wp option update blogname "%nome-do-site%"
	:: Em Configurações > Geral > Alterar a Descrição do Site
	sudo -u %usuario-do-site% wp option update blogdescription "%slogan-do-dominio%"
	:: Em Configurações > Geral > Endereço de e-mail
	sudo -u %usuario-do-site% wp option update admin_email %admin-email%
	:: Em Configurações > Links Permanentes > Nome do Post
	sudo -u %usuario-do-site% wp rewrite structure /%postname%/
	
	:: Em Aparência > Temas > Só deixar um tema padrão do Wordpress e deleta os temas que não estão sendo utilizados
	sudo -u %usuario-do-site% wp theme delete twentyfourteen twentyfifteen twentysixteen twentyseventeen
	:: Em Plugins > Adicionar novo > Instala e Ativa e Configura os Plugins akismet loco-translate duplicate-post
	sudo -u %usuario-do-site% wp plugin install akismet loco-translate duplicate-post iwp-client --activate 
	::Se tiver plugin de tradução então instalar e ativar o gtranslate
	:: if [ Se o Construtor for Visual Composer ] 
	:: then
		:: Instalar os plugins Simple Like Page Plugin, Popup Maker, Contact Form , Masks Form Fields, Maintenance, Clipboard – Visual Composer e Slider Revolution
		sudo -u %usuario-do-site% wp plugin install simple-facebook-plugin popup-maker contact-form-7 masks-form-fields  maintenance --activate
		:: Clipboard – Visual Composer - https://www.ultrapackv2.com/item/codecanyon-visualcomposer-clipboard-visual-composer/
		:: Slider Revolution   https://www.ultrapackv2.com/item/codecanyon-variados-slider-revolution-responsive-wordpress-plugin/
		:: Configurar o Comming Soom
		:: wp option update maintenance COMMING-SOON-PADRAO
	::fi
	goto :MenuPrincipal
:FazerBackupEColocarNoGoogleDrive
	sudo -u %usuario-do-site% wp ai1wm backup
	goto :MenuPrincipal
:ConfigurarCommingSoon
	cls
	:: if [ Se o Construtor for Elementor ] 
	:: then
		:: Configurar o Comming Soom
		:: wp option update elementor COMMING-SOON-PADRAO
	::fi
	:: if [ Se For E-commerce ] 
	:: then
		:: Instala os plugins WooCommerce, WooCommerce PagSeguro, WooCommerce Correios e ativa
		sudo -u %usuario-do-site% wp plugin install woocommerce woocommerce-pagseguro woocommerce-correios  --activate
	::fi
	::  Em Configurações > Akismet Anti-Spam >  Colocar a chave API
	sudo -u %usuario-do-site% wp option update wordpress_api_key %wordpress_api_key%
	:: Em Usuários > Adicionar Novo > adiciona os usuários
	sudo -u %usuario-do-site% wp user create %nome-do-usuario% %email-do-usuario% --role=administrator --user_pass=%senha-do-usuario%

	::se tiver plugin de tradução então instalar e ativar o gtranslate
	:: if [ gtranslate ] 
	:: then
		sudo -u %usuario-do-site% wp plugin install gtranslate -- activate
	:: fi
	::se tiver site antigo em wordpress então instalar e ativar o wordpress-importer
	sudo -u %usuario-do-site% wp plugin install wordpress-importer --activate

	
	sudo -u %usuario-do-site% wp media import %imagens-para-o-site%
	
	:: Importa os posts dos sites e coloca e colocar o Nome do Site como Autor
	sudo -u %usuario-do-site% wp import %artigos% --authors=%nome-do-site%

	:: Importa os formulários de contato no site (Contact Form 7)
	sudo -u %usuario-do-site% wp import %formularios% --authors=%nome-do-site%
:AtivarHTTPS
	:: Checar se o site tem já tem certificado SSL
	:: Really Simple SSL: Se na Hospedagem o HTTPS/SSL está ativado e o site estiver no domínio certo então ativa o plugin > Em Configurações > SSL > Ativa o HTTPS/SSL
	sudo -u %usuario-do-site% wp plugin activate really-simple-ssl	
	sudo -u %usuario-do-site% wp plugin install really-simple-ssl  --activate
	sudo -u %usuario-do-site% wp rsssl activate_ssl
	:: Forçar o uso de HTTPS (Hospedagem)
	goto :MenuPrincipal
:DesativarHTTPS
	sudo -u %usuario-do-site% wp plugin install really-simple-ssl  --activate
	sudo -u %usuario-do-site% wp plugin activate really-simple-ssl
	sudo -u %usuario-do-site% mv force-deactivate.txt force-deactivate.php
	curl https://%dominio%/wp-content/plugins/really-simple-ssl/force-deactivate.php
	sudo -u %usuario-do-site% mv force-deactivate.php force-deactivate.txt
	goto :MenuPrincipal	
:ConfigPosTema
	cls
	::abrir o Tema do Site, Sites de Referência, Site Original(Se Tiver)
	start chrome %site-de-tema% %sites-de-referencia% %site-original%
	::descompactar o tema para ver se o tema está dentro do zip
	cd wp-content/themes
	unzip %tema-zip%
	:: Instalar ou criar um tema filho para a edição
	sudo -u %usuario-do-site% wp scaffold oceanwp oceanwp-child --parent_theme=oceanwp
	
	:: Loco Translate: Em Loco Translate > Themes > TEMA USADO >
	:: Se não tiver a linguagem do Português Brasileiro então:
		:: Vá em Nova Linguagem > Escolha a Ligua Português do Brasil >e Start translating
		:: Baixe o Arquivo .po > Vá para o site  https://translate.google.com/toolkit > Enviar > Adicione o conteúdo a ser traduzido > Coloque o arquivo .po > Escolha a linguagem > português (Brasil) > Avançar > Em Selecionar fornecedor de tradução, vá em Não, obrigado > Clique no Arquivo > Arquivo > Fazer Download > Renomeie o Aequivo .po para o mesmo nome anterior > Vá Até o FTP do Site > Na pasta wp-content/themes/TEMA/languages(Conferir) > Suba o novo arquivo .po traduzido para a pasta > Volte para o site > Atualize > Edite uma palavra > Salve > Teste no site

		:: Duplicate Post:  Em Configurações > Duplicate Post > Permissões > Ativar para estes tipos de posts > Marca Todas as Caixinhas
		
		:: WhatsApp Click to Chat - https://www.ultrapackv2.com/item/codecanyon-variados-whatsapp-click-to-chat-plugin-for-wordpress/ - Em WhatsApp > Adicionar nova conta > Coloque o Título(Ateindimento SITE), o Número do telefone, o Nome, o Título, a imagem destacada e Publica > Depois vá para WhatsApp > Widget Flutuando > coloque a conta "Atendimento" e salve > vá em Display Settings > coloque no Texto "Converse conosco no WhatsApp", na descrição "Olá! Clique em um de nossos representantes abaixo e entraremos em contato com você o mais breve possível.", a Posição da Caixa "Embaixo Esquerda e Salve
		
		:: WP Smush it Pro -  https://www.ultrapackv2.com/item/wpmudev-wp-smush-pro/ - Em Smush Pro > Configure o Setup Wizard para todas as opções e depois clique no botão Bulk Smush Now e deixe carregando
		:: WP Rocket - https://www.ultrapackv2.com/item/outros-plugins-wp-rocket/ - Em Configurações > WP Rocket > Marque Todas as Opções da guia "Cache", "Otimização de Arquivos", "Mídia" (Menos Desabilitar incorporações do WordPress), "Pré-Carregar", "Banco de Dados", "Heartbeat" e Salva.
			:: Se o Site Quebrou após configurar o WP Rocket, então faça testes desativando as caixinhas de "Otimização de Arquivo" e "Mídia"

	:: Instala, mas não ativa os Plugins: InfiniteWp
		:: Yoast – SEO Premium - https://www.ultrapackv2.com/item/yoast-seo-premium/
		:: Ithemes - https://www.ultrapackv2.com/item/outros-plugins-ithemes-security-pro/ - 
	:: Se o site for Seja Catálogo então, instala os plugins:
		:: YITH WooCommerce Request A Quote Premium - https://www.ultrapackv2.com/item/yith-woocommerce-request-a-quote-premium/
	:: Verifica se o Tema não Tem Vírus no site https://sitecheck.sucuri.net/
	:: Se tiver site antigo pega todas as imagens do site antigo com a extensão Image Downloader e pega todos os textos do site antigo    
	

:ConfigFinal
	cls
	sudo -u %usuario-do-site% wp db search 'br/login'
	:: Alterar os links provisórios no site para o link certo do site
	sudo -u %usuario-do-site% wp search-replace '%link-provisorio%' '%dominio%'

	:: Deletar todos os Backups existentes no All-in-One WP Migration
	:: rm * .wpress - Testar
	:: Deletar os Plugins Duplicate post, Maitenance, e outrosque não estão sendo utilizados
	sudo -u %usuario-do-site% wp plugin uninstall duplicate-post maintenance vc-clipboard
	:: Plugins > Desativar e Desinstalar o All in One Migration
	sudo -u %usuario-do-site% wp plugin uninstall all-in-one-wp-migration --deactivate
	:: Plugins > Adicionar novo > Fazer o Upload do All in One Migration na versão 6.77 e ativar
	sudo -u %usuario-do-site% wp plugin install all-in-one-wp-migration --version=6.77 --activate
	:: All in One Migration > Exportar e Baixar
	sudo -u %usuario-do-site% wp ai1wm backup
	:: Atualizar o Wordpress pra versão mais recente
	sudo -u %usuario-do-site% wp core update
	:: Plugins > Plugins Instalados > Atualizar todos os plugins free para a versão mais recente
	sudo -u %usuario-do-site% wp plugin update --all
	
	:: Testar E-mail de SPAM
	:: Nome: Gerador de Trafego
	:: E-mail: softwarewhatsgrupos@gmail.com
	:: Telefone: (11) 98165-1962
	:: Assunto: Dominando os buscadores

	:: Mensagem: Você sabia que um bom gerador de tráfego pode te colocar em primeiro lugar nas buscas em todo Brasil? Se não acredita pesquise 'Gerador de Trafego' e acesse o primeiro site orgânico (Que não seja anuncio), e saiba como funciona este processo.
	:: sendEmail -f %destinatario% -t %remetente% -u "E-mail de Teste" -s server_mail -xu user_from -xp passwd << FIMEMAIL - Testar
	
	:: Limpa o site para poder indexar no Google - Fazer um Backup e baixar antes de Fazer a limpeza
	:: Fazer Backup, baixar na maquina(posteriormente em pasta compartilhada zipada) e retirar os Backups do site
	:: Deletar os Formulários de Contato que não estão sendo utilizados 
	:: Deletar todas as imagens que não estão sendo utilizadas
	:: Tirar todos os Posts, páginas, comentários, produtos, etc que não estão sendo usados para rascunho
	:: Colocar o e-mail do cliente como destinatarios nos formulários de contato
	:: Limpar o cache depois de tudo
	
	::  Conferir e se não falta nada e testar os formulários de contato para ver se envia spam enviar para o cliente.

	:: Conferir os links para ver se vão para o lugar certo
	:: Ver se todos os botões estão iguais ou do mesmo estilo
	:: Conferir se os formulários de contato estão funcionando
	:: Conferir se não falta nenhum texto ou imagem
	:: Conferir acentos, vírgulas ou pontos nos textos
	:: Verificar as cores do fundo das sessões (caso pareça branco porém é cinza claro)
	:: Testar o Fluxo do cliente
	:: Ver a página 404
	:: Testar o site no Celular
	:: Ver se o slider está bom no celular
	:: Ver se o site está indexando no mobile -  https://search.google.com/test/mobile-friendly
	:: Ver se o menu está funcionando
	:: https://transparencyreport.google.com/safe-browsing/search
	:: https://www.thinkwithgoogle.com/intl/pt-br/feature/testmysite
	:: https://gtmetrix.com/
	:: https://www.semrush.com/
	:: Renomear todas as imagens colocando alt e title (Para SEO)
	:: Fazer a integração do Google Analytcs
	:: Integrar com o Google Search Console
	:: Configurar o Yoast SEO Pro
	:: Configurar o Pixel do Facebook
	:: Utilizar hierarquias em páginas para o SEO
	:: testar os textos do site com ferramenta de plagio
	
	:: Em Configurações > Leitura > Desarcar a Caixa "Evitar que mecanismos de busca indexem este site"
	sudo -u %usuario-do-site% wp option update blog_public 0
	goto :MenuPrincipal
:ReimportarBancoDeDados
	cls
	mysql -h %host-db% -u %usuario-db% -p%senha-db% %db%
	mysqldump -h %host-db% -u %usuario-db% -p%senha-db% %db% > backup.sql
	mysql -h %host-db% -u %usuario-db% -p%senha-db% --default_character_set utf8 %db% < backup.sql
	ALTER DATABASE ` %db%` CHARSET = UTF8 COLLATE = utf8_general_ci;
	:: https://forum.imasters.com.br/topic/478939-resolvido%C2%A0como-exibir-caracteres-especiais-gravados-no-banco/
	goto :MenuPrincipal