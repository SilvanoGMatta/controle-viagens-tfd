# Publica as alteracoes no GitHub (add + commit + push)
# Uso:  .\publicar.ps1 "mensagem do commit"   (mensagem e opcional)

$ErrorActionPreference = "Stop"
Set-Location -LiteralPath $PSScriptRoot

# Mensagem: usa o argumento, ou gera uma com data/hora
$msg = if ($args.Count -gt 0 -and $args[0].Trim()) { $args[0] } else { "Atualiza sistemas em " + (Get-Date -Format "dd/MM/yyyy HH:mm") }

# Ha algo para enviar?
$pendente = git status --porcelain
if (-not $pendente) {
    Write-Host "Nada para publicar - tudo ja esta atualizado." -ForegroundColor Yellow
    Read-Host "Pressione ENTER para fechar"
    exit 0
}

Write-Host "Alteracoes encontradas:" -ForegroundColor Cyan
git status --short

git add -A
git commit -m $msg
git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Publicado com sucesso!" -ForegroundColor Green
    Write-Host "Site: https://silvanogmatta.github.io/controle-viagens-tfd/" -ForegroundColor Green
    Write-Host "(aguarde ~1 minuto e use Ctrl+F5 no navegador)"
} else {
    Write-Host "Falha no push. Verifique a conexao e o login do GitHub." -ForegroundColor Red
}

Read-Host "Pressione ENTER para fechar"
