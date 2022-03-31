REM O Programa linha de comando "wget.exe" com o qual este escript se baseia, não cumpre o que promete. 
REM Li toda a documentação, consultei fóruns, sites especializados linux... 
REM E fiz todas as combinações de comandos possíveis e testando. Tudo o que eu podia. 
REM Dizendo que baixa todo o site fazendo um "mirror", ou seja um clone e transformando em um site off line local.
REM Ele não transforma o site online em off line.
REM Diante deste fato, não tem mais o que fazer.
REM Então neste momento eu interrompo o desenvolvimento com muito pesar, decepção e frustração do TurBow.
REM Brasília, 29 De Março De 2022 as Hrs 19:15.

@echo off


setlocal enabledelayedexpansion


echo. 
echo. 
echo.-----------------------------------------------------------------
echo.-----------------------------------------------------------------
echo.-------------------------- [TurBow] -----------------------------
echo.-----------------------------------------------------------------
echo.-----------------------------------------------------------------
echo.-------------------- BAIXE SITES INTEIROS -----------------------
echo.-----------------------------------------------------------------
echo.-------- [MENU] COMPLETO, FACIL, SIMPLES E INTERATIVO -----------
echo.-----------------------------------------------------------------
echo.-----------------------------------------------------------------
echo.Versao 1.0.0 ----------------------------------------------------
echo.DeV: oSToN PraTa. -----------------------------------------------
echo.DaTa: BRaSiLia, 29 De MaRCo De 2022. ----------------------------
echo.LiNK Bio: https://linktr.ee/ostonprata --------------------------
echo.Repositorio/Help: https://github.com/ostonprata/TurBoy ----------
echo.-----------------------------------------------------------------
echo.-----------------------------------------------------------------
echo. 
echo. 


if exist "uRL-LiSTa.TXT" (
goto :arquivoExiste
) else (
goto :arquivoNaoExiste
)
:arquivoExiste
echo. 
echo.[1] CoNTiNuaR CoM a aNTiGa LiSTa eXiSTeNTe DaS uRL.
echo.[2] CRiaR uMa NoVa [SoBreSCReVeNDo a aNTiGa LiSTa] DaS uRL.
echo. 
set /p "primeiroMenuOpcao=OPCAO : "
if "%primeiroMenuOpcao%"=="1" (
goto :querAdicionarMais
)
del "uRL-LiSTa.TXT"
:arquivoNaoExiste
:adicionarMais
echo. 
set /p "urlLista=uRL Do CaNaL, ou Da PLayLiST, ou De ViDeo : "
echo.
echo %urlLista% >> "uRL-LiSTa.TXT"
:querAdicionarMais
echo. 
set /p "Pergunta=ACReSCeNTaR MaiS uRL? [s]im / [n]ao : "
if /i "%Pergunta%"=="s" (
goto :adicionarMais
)


echo. 
echo. 
cls
echo. 
echo. 


set "psCommand="(new-object -COM 'Shell.Application')^
.BrowseForFolder(0,'[AONDE BAIXAR...]',0,0x11).self.path""
for /f "usebackq delims=" %%a in (`powershell %psCommand%`) do (
	set "comandoPasta=%%a"
)


for /f "tokens=* delims= " %%b in (uRL-LiSTa.TXT) do (
	set "tempPlayList=%%b"


	set "linkDominio=%%b"
	set "limpezaLinkDominio1=!linkDominio:https://=!"
	set "limpezaLinkDominio2=!limpezaLinkDominio1:/=!"


	set "comandosParte01=wget.exe --continue --report-speed=bits --show-progress --progress=bar"
	set "comandosParte02=-e robots=off --no-cache --ignore-length --retry-on-host-error"
	set "comandosParte03=--tries=20 --waitretry=20 --wait=2 --random-wait"
	set "comandosParte04=!linkDominio!"
	set "comandosParte05=--user-agent="Mozilla/4.0 ^(compatible; MSIE 6.0; Windows NT 5.0^)""

rem	set "comandosParte06=--recursive --level=inf --no-parent --page-requisites --mirror --domains=!limpezaLinkDominio2!"
	set "comandosParte06=--mirror --no-parent --page-requisites --domains=!limpezaLinkDominio2!"

rem	set "comandosParte07=--no-directories --adjust-extension --convert-links --trust-server-names"
	set "comandosParte07=--adjust-extension --convert-links"

	set "comandosParte08=--directory-prefix=!comandoPasta!^\!limpezaLinkDominio2!"
	set "comandosParte09=--output-file=log-error.txt --rejected-log=log-url-rejeitados.txt"


	!comandosParte01! !comandosParte02! !comandosParte03! !comandosParte04! !comandosParte05! !comandosParte06! !comandosParte07! !comandosParte08! !comandosParte09!

	
)


:saidoPrograma
echo.
echo.
echo.[...FIM]
echo.
echo.


endlocal


pause


exit