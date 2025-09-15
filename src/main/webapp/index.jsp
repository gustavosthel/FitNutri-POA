<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitNutri AI - Nutrição + Fitness Inteligente</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#6366F1', // Indigo
                        secondary: '#4F46E5', // Indigo escuro
                        accent: '#8B5CF6', // Roxo
                        success: '#10B981', // Verde
                        warning: '#F59E0B', // Amarelo
                        danger: '#EF4444', // Vermelho
                        neutral: '#F8FAFC', // Cinza muito claro
                        dark: '#1E293B' // Azul escuro
                    }
                }
            }
        }
    </script>
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="bg-white">
    <!-- Navbar -->
    <nav class="bg-white shadow-lg fixed w-full top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between items-center h-16">
                <div class="flex items-center">
                    <div class="flex-shrink-0">
                        <a href="index.jsp" class="text-2xl font-bold text-primary hover:text-secondary transition-colors">
                            💪 FitNutri AI
                        </a>
                    </div>
                </div>
                <div class="hidden md:block">
                    <div class="ml-10 flex items-baseline space-x-4">
                        <a href="index.jsp" class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors">Início</a>
                        <a href="goal-setup.jsp" class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors">Metas</a>
                        <a href="nutrition.jsp" class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors">Nutrição</a>
                        <a href="activity.jsp" class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors">Atividades</a>
                        <a href="balance.jsp" class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors">Balanço</a>
                        <a href="ai-recommendations.jsp" class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors">IA Coach</a>
                    </div>
                </div>
                <div class="md:hidden">
                    <button id="mobile-menu-btn" class="text-dark hover:text-primary">
                        <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
                        </svg>
                    </button>
                </div>
            </div>
        </div>
        <!-- Mobile menu -->
        <div id="mobile-menu" class="md:hidden hidden">
            <div class="px-2 pt-2 pb-3 space-y-1 sm:px-3 bg-white shadow-lg">
                <a href="index.jsp" class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left">Início</a>
                <a href="goal-setup.jsp" class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left">Metas</a>
                <a href="nutrition.jsp" class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left">Nutrição</a>
                <a href="activity.jsp" class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left">Atividades</a>
                <a href="balance.jsp" class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left">Balanço</a>
                <a href="ai-recommendations.jsp" class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left">IA Coach</a>
            </div>
        </div>
    </nav>

    <!-- Home Page -->
    <div id="home-page" class="page active pt-16">
        <!-- Hero Section -->
        <div class="gradient-bg text-white">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20">
                <div class="text-center">
                    <h1 class="text-4xl md:text-6xl font-bold mb-6">
                        <span class="text-white">FitNutri</span> <span class="text-yellow-300">AI</span>
                    </h1>
                    <p class="text-xl md:text-2xl mb-8 max-w-3xl mx-auto opacity-90">
                        Sistema de 5 Servlets integrados com APIs reais (Edamam, Google Fit, Fitbit, OpenAI) que cruza alimentação com gasto calórico para gerar recomendações IA personalizadas.
                    </p>
                    <div class="flex flex-col sm:flex-row gap-4 justify-center">
                        <a href="goal-setup.jsp" class="bg-white text-primary px-8 py-3 rounded-lg font-semibold hover:bg-neutral transition-colors">
                            🎯 Definir Metas
                        </a>
                        <a href="balance.jsp" class="border-2 border-white text-white px-8 py-3 rounded-lg font-semibold hover:bg-white hover:text-primary transition-colors">
                            ⚖️ Ver Balanço Calórico
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Features Section -->
        <div class="py-20 bg-neutral">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <h2 class="text-3xl md:text-4xl font-bold text-dark mb-4">5 Servlets Inteligentes</h2>
                    <p class="text-lg text-gray-600 max-w-2xl mx-auto">Sistema completo que integra nutrição e fitness com IA</p>
                </div>
                <div class="grid md:grid-cols-2 lg:grid-cols-3 gap-8">
                    <div class="bg-white p-8 rounded-xl card-shadow text-center hover:transform hover:scale-105 transition-all cursor-pointer" onclick="location.href='goal-setup.jsp'">
                        <div class="w-16 h-16 bg-primary rounded-full flex items-center justify-center mx-auto mb-6">
                            <span class="text-2xl">🎯</span>
                        </div>
                        <h3 class="text-xl font-semibold text-dark mb-4">Goal Setup Servlet</h3>
                        <p class="text-gray-600">Configure metas personalizadas: perder peso, manter forma ou ganhar massa muscular com cálculos precisos.</p>
                    </div>
                    <div class="bg-white p-8 rounded-xl card-shadow text-center hover:transform hover:scale-105 transition-all cursor-pointer" onclick="location.href='nutrition.jsp'">
                        <div class="w-16 h-16 bg-success rounded-full flex items-center justify-center mx-auto mb-6">
                            <span class="text-2xl">🥗</span>
                        </div>
                        <h3 class="text-xl font-semibold text-dark mb-4">Nutrition Analyzer Servlet</h3>
                        <p class="text-gray-600">Servlet integrado com Edamam e USDA APIs para análise nutricional precisa de milhares de alimentos.</p>
                    </div>
                    <div class="bg-white p-8 rounded-xl card-shadow text-center hover:transform hover:scale-105 transition-all cursor-pointer" onclick="location.href='activity.jsp'">
                        <div class="w-16 h-16 bg-warning rounded-full flex items-center justify-center mx-auto mb-6">
                            <span class="text-2xl">🏃</span>
                        </div>
                        <h3 class="text-xl font-semibold text-dark mb-4">Activity Tracker Servlet</h3>
                        <p class="text-gray-600">Servlet conectado com Google Fit e Fitbit APIs para rastreamento real de atividades e gasto calórico preciso.</p>
                    </div>
                    <div class="bg-white p-8 rounded-xl card-shadow text-center hover:transform hover:scale-105 transition-all cursor-pointer" onclick="location.href='balance.jsp'">
                        <div class="w-16 h-16 bg-accent rounded-full flex items-center justify-center mx-auto mb-6">
                            <span class="text-2xl">⚖️</span>
                        </div>
                        <h3 class="text-xl font-semibold text-dark mb-4">Balance Engine Servlet</h3>
                        <p class="text-gray-600">Cruza alimentação x gasto calórico em tempo real, calculando déficit/superávit para suas metas.</p>
                    </div>
                    <div class="bg-white p-8 rounded-xl card-shadow text-center hover:transform hover:scale-105 transition-all cursor-pointer" onclick="location.href='ai-recommendations.jsp'">
                        <div class="w-16 h-16 bg-danger rounded-full flex items-center justify-center mx-auto mb-6">
                            <span class="text-2xl">🤖</span>
                        </div>
                        <h3 class="text-xl font-semibold text-dark mb-4">AI Coach Servlet</h3>
                        <p class="text-gray-600">Servlet com OpenAI GPT-4 que gera recomendações inteligentes baseadas em seus dados reais de nutrição e atividade.</p>
                    </div>
                    <div class="bg-white p-8 rounded-xl card-shadow text-center">
                        <div class="w-16 h-16 bg-gray-300 rounded-full flex items-center justify-center mx-auto mb-6">
                            <span class="text-2xl">🔗</span>
                        </div>
                        <h3 class="text-xl font-semibold text-gray-500 mb-4">Servlets Internos</h3>
                        <p class="text-gray-500">• Base de dados nutricional<br>• Algoritmos MET<br>• Cálculos em tempo real<br>• Processamento local</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- How it Works -->
        <div class="py-20 bg-white">
            <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <h2 class="text-3xl md:text-4xl font-bold text-dark mb-4">Como Funciona</h2>
                    <p class="text-lg text-gray-600">Processo inteligente em 4 etapas</p>
                </div>
                <div class="grid md:grid-cols-4 gap-8">
                    <div class="text-center">
                        <div class="w-20 h-20 bg-primary rounded-full flex items-center justify-center mx-auto mb-4">
                            <span class="text-3xl text-white">1</span>
                        </div>
                        <h3 class="text-lg font-semibold text-dark mb-2">Defina Metas</h3>
                        <p class="text-gray-600">Configure objetivos personalizados baseados em seu perfil</p>
                    </div>
                    <div class="text-center">
                        <div class="w-20 h-20 bg-success rounded-full flex items-center justify-center mx-auto mb-4">
                            <span class="text-3xl text-white">2</span>
                        </div>
                        <h3 class="text-lg font-semibold text-dark mb-2">Monitore Consumo</h3>
                        <p class="text-gray-600">Registre alimentos e atividades físicas automaticamente</p>
                    </div>
                    <div class="text-center">
                        <div class="w-20 h-20 bg-warning rounded-full flex items-center justify-center mx-auto mb-4">
                            <span class="text-3xl text-white">3</span>
                        </div>
                        <h3 class="text-lg font-semibold text-dark mb-2">Análise IA</h3>
                        <p class="text-gray-600">Sistema cruza dados e calcula balanço calórico inteligente</p>
                    </div>
                    <div class="text-center">
                        <div class="w-20 h-20 bg-accent rounded-full flex items-center justify-center mx-auto mb-4">
                            <span class="text-3xl text-white">4</span>
                        </div>
                        <h3 class="text-lg font-semibold text-dark mb-2">Recomendações</h3>
                        <p class="text-gray-600">Receba sugestões personalizadas para atingir suas metas</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white py-12">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid md:grid-cols-4 gap-8">
                <div class="md:col-span-2">
                    <h3 class="text-2xl font-bold text-primary mb-4">💪 FitNutri AI</h3>
                    <p class="text-gray-300 mb-4">
                        Plataforma inteligente que cruza alimentação e atividade física para gerar recomendações personalizadas baseadas em suas metas de saúde.
                    </p>
                    <div class="text-sm text-gray-400">
                        <p>• 5 Servlets especializados</p>
                        <p>• Balanço calórico em tempo real</p>
                        <p>• IA Coach personalizado</p>
                    </div>
                </div>
                <div>
                    <h4 class="text-lg font-semibold mb-4">Servlets</h4>
                    <ul class="space-y-2">
                        <li><a href="goal-setup.jsp" class="text-gray-300 hover:text-primary transition-colors">Goal Setup</a></li>
                        <li><a href="nutrition.jsp" class="text-gray-300 hover:text-primary transition-colors">Nutrition Analyzer</a></li>
                        <li><a href="activity.jsp" class="text-gray-300 hover:text-primary transition-colors">Activity Tracker</a></li>
                        <li><a href="balance.jsp" class="text-gray-300 hover:text-primary transition-colors">Balance Engine</a></li>
                        <li><a href="ai-recommendations.jsp" class="text-gray-300 hover:text-primary transition-colors">AI Coach</a></li>
                    </ul>
                </div>
                <div>
                    <h4 class="text-lg font-semibold mb-4">APIs Integradas</h4>
                    <ul class="space-y-2 text-gray-300">
                        <li>🥗 Edamam Food API</li>
                        <li>📊 USDA FoodData Central</li>
                        <li>🏃 Google Fit API</li>
                        <li>⌚ Fitbit API</li>
                        <li>🤖 OpenAI GPT-4 API</li>
                    </ul>
                </div>
            </div>
            <div class="border-t border-gray-700 mt-8 pt-8 text-center">
                <p class="text-gray-300">&copy; 2024 FitNutri AI. Sistema completo com 5 Servlets Java integrados às principais APIs de nutrição, fitness e IA do mercado.</p>
            </div>
        </div>
    </footer>

    <script src="js/script.js"></script>
</body>
</html>