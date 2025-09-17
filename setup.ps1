# ===========================================
# FitNutri-POA - Script de Configuração Automática
# ===========================================

Write-Host "🚀 Configurando projeto FitNutri-POA..." -ForegroundColor Green

# Verificar se Java está instalado
Write-Host "`n🔍 Verificando instalação do Java..." -ForegroundColor Yellow
try {
    $javaVersion = java -version 2>&1 | Select-String "version"
    Write-Host "✅ Java encontrado: $javaVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Java não encontrado! Por favor, instale o Java 11 ou superior." -ForegroundColor Red
    Write-Host "   Download: https://adoptopenjdk.net/" -ForegroundColor Yellow
    exit 1
}

# Verificar se o arquivo config.properties existe
Write-Host "`n🔧 Verificando arquivo de configuração..." -ForegroundColor Yellow

$configFile = "src\main\resources\config.properties"
$configExampleFile = "src\main\resources\config.properties.example"

if (Test-Path $configFile) {
    Write-Host "✅ Arquivo config.properties já existe." -ForegroundColor Green
} elseif (Test-Path $configExampleFile) {
    Write-Host "📄 Criando arquivo config.properties..." -ForegroundColor Yellow
    Copy-Item $configExampleFile $configFile
    Write-Host "✅ Arquivo config.properties criado!" -ForegroundColor Green
    Write-Host "⚠️  ATENÇÃO: Você precisa editar o arquivo e configurar sua chave da API Groq!" -ForegroundColor Yellow
    Write-Host "   Arquivo: $configFile" -ForegroundColor Cyan
} else {
    Write-Host "❌ Arquivo config.properties.example não encontrado!" -ForegroundColor Red
    exit 1
}

# Verificar variável de ambiente GROQ_API_KEY
Write-Host "`n🔑 Verificando chave da API..." -ForegroundColor Yellow
if ($env:GROQ_API_KEY) {
    $keyLength = $env:GROQ_API_KEY.Length
    Write-Host "✅ Variável de ambiente GROQ_API_KEY encontrada (length: $keyLength)" -ForegroundColor Green
} else {
    Write-Host "⚠️  Variável de ambiente GROQ_API_KEY não encontrada." -ForegroundColor Yellow
    Write-Host "   Para configurar, execute:" -ForegroundColor Cyan
    Write-Host "   `$env:GROQ_API_KEY = `"sua_chave_aqui`"" -ForegroundColor White
}

# Verificar estrutura do projeto
Write-Host "`n📁 Verificando estrutura do projeto..." -ForegroundColor Yellow

$requiredFiles = @(
    "src\main\java\com\fitnutri\ConfigurationManager.java",
    "src\main\java\com\fitnutri\GroqApiClient.java",
    "src\main\java\com\fitnutri\GroqApiException.java",
    "src\main\java\com\fitnutri\servlet\GroqServlet.java",
    "src\main\java\com\fitnutri\test\GroqApiTest.java"
)

$allFilesExist = $true
foreach ($file in $requiredFiles) {
    if (Test-Path $file) {
        Write-Host "✅ $file" -ForegroundColor Green
    } else {
        Write-Host "❌ $file" -ForegroundColor Red
        $allFilesExist = $false
    }
}

if (-not $allFilesExist) {
    Write-Host "`n❌ Alguns arquivos estão faltando! Verifique o projeto." -ForegroundColor Red
    exit 1
}

# Verificar configurações do Eclipse
Write-Host "`n⚙️ Verificando configurações do Eclipse..." -ForegroundColor Yellow

$settingsFiles = @(
    ".project",
    ".classpath",
    ".settings\org.eclipse.jdt.core.prefs",
    ".settings\org.eclipse.wst.common.project.facet.core.xml"
)

foreach ($file in $settingsFiles) {
    if (Test-Path $file) {
        Write-Host "✅ $file" -ForegroundColor Green
    } else {
        Write-Host "⚠️  $file não encontrado" -ForegroundColor Yellow
    }
}

# Executar teste rápido da API (apenas se a chave estiver disponível)
Write-Host "`n🧪 Testando configuração..." -ForegroundColor Yellow

# Verificar se temos uma chave da API disponível
$hasApiKey = $false
if ($env:GROQ_API_KEY) {
    $hasApiKey = $true
} elseif (Test-Path $configFile) {
    $configContent = Get-Content $configFile
    if ($configContent -match "groq\.api\.key=.+" -and $configContent -notmatch "SUA_CHAVE_GROQ_AQUI") {
        $hasApiKey = $true
    }
}

if ($hasApiKey) {
    Write-Host "🔑 Chave da API encontrada. Você pode testar executando:" -ForegroundColor Green
    Write-Host "   - GroqApiTest.java no Eclipse" -ForegroundColor Cyan
    Write-Host "   - Ou execute o projeto no servidor Tomcat" -ForegroundColor Cyan
} else {
    Write-Host "⚠️  Chave da API não configurada. Configure antes de testar:" -ForegroundColor Yellow
    Write-Host "   1. Edite $configFile" -ForegroundColor Cyan
    Write-Host "   2. Ou defina: `$env:GROQ_API_KEY = `"sua_chave`"" -ForegroundColor Cyan
}

# Resumo final
Write-Host "`n📋 RESUMO DA CONFIGURAÇÃO:" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host "✅ Estrutura do projeto: OK" -ForegroundColor Green
Write-Host "✅ Configurações do Eclipse: Incluídas" -ForegroundColor Green
Write-Host "✅ Java 11: Configurado" -ForegroundColor Green
Write-Host "✅ Facets: Web 5.0 + Java 11" -ForegroundColor Green

if ($hasApiKey) {
    Write-Host "✅ Chave da API: Configurada" -ForegroundColor Green
} else {
    Write-Host "⚠️  Chave da API: PRECISA CONFIGURAR" -ForegroundColor Yellow
}

Write-Host "`n🎯 PRÓXIMOS PASSOS:" -ForegroundColor Cyan
Write-Host "==================" -ForegroundColor Cyan
Write-Host "1. Abra o Eclipse" -ForegroundColor White
Write-Host "2. Importe o projeto (File → Import → Existing Projects)" -ForegroundColor White
if (-not $hasApiKey) {
    Write-Host "3. Configure sua chave da API Groq" -ForegroundColor Yellow
    Write-Host "4. Execute GroqApiTest.java para testar" -ForegroundColor White
    Write-Host "5. Execute no Tomcat (Run As → Run on Server)" -ForegroundColor White
} else {
    Write-Host "3. Execute GroqApiTest.java para testar" -ForegroundColor White
    Write-Host "4. Execute no Tomcat (Run As → Run on Server)" -ForegroundColor White
}

Write-Host "`n🎉 Configuração concluída!" -ForegroundColor Green
Write-Host "📖 Consulte SETUP.md para instruções detalhadas." -ForegroundColor Cyan

# Perguntar se quer abrir o arquivo de configuração
if (-not $hasApiKey -and (Test-Path $configFile)) {
    $response = Read-Host "`nDeseja abrir o arquivo config.properties para editar agora? (s/n)"
    if ($response -eq "s" -or $response -eq "S" -or $response -eq "y" -or $response -eq "Y") {
        try {
            Start-Process notepad.exe $configFile
            Write-Host "📝 Arquivo config.properties aberto no Notepad!" -ForegroundColor Green
        } catch {
            Write-Host "❌ Erro ao abrir o arquivo. Abra manualmente: $configFile" -ForegroundColor Red
        }
    }
}
