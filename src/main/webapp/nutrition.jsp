<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FitNutri AI - Configuração de Metas</title>
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

    <!-- Nutrition Analyzer Page -->
    <div id="nutrition-analyzer-page" class="page active pt-16">
        <div class="min-h-screen bg-white">
            <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-20">
                <div class="text-center mb-12">
                    <h1 class="text-3xl md:text-4xl font-bold text-dark mb-4">🥗 Analisador Nutricional</h1>
                    <p class="text-lg text-gray-600">Servlet de processamento nutricional com base de dados interna</p>
                </div>
                
                <div class="grid lg:grid-cols-2 gap-8">
                    <!-- Food Search -->
                    <div class="bg-neutral rounded-2xl p-8 card-shadow">
                        <h3 class="text-xl font-semibold text-dark mb-6">Buscar Alimento</h3>
                        <div class="space-y-4">
                            <div>
                                <label class="block text-sm font-medium text-dark mb-2">Nome do Alimento</label>
                                <input type="text" id="food-search" placeholder="Ex: 100g peito de frango grelhado" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                            </div>
                            <div class="grid grid-cols-2 gap-4">
                                <div>
                                    <label class="block text-sm font-medium text-dark mb-2">Quantidade</label>
                                    <input type="number" id="food-quantity" value="100" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-dark mb-2">Unidade</label>
                                    <select id="food-unit" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                        <option value="g">gramas (g)</option>
                                        <option value="ml">mililitros (ml)</option>
                                        <option value="unit">unidade</option>
                                        <option value="cup">xícara</option>
                                        <option value="tbsp">colher de sopa</option>
                                    </select>
                                </div>
                            </div>
                            <button onclick="analyzeNutrition()" class="w-full bg-primary text-white py-3 rounded-lg font-semibold hover:bg-secondary transition-colors">
                                <span id="nutrition-btn-text">🔍 Processar com Servlet</span>
                                <div id="nutrition-loading" class="hidden flex items-center justify-center">
                                    <div class="loading w-5 h-5 border-2 border-white border-t-transparent rounded-full mr-2"></div>
                                    Servlet processando...
                                </div>
                            </button>
                            
                            <!-- Quick Search -->
                            <div class="grid grid-cols-2 gap-2 mt-4">
                                <button onclick="quickNutritionSearch('banana')" class="bg-gray-100 text-gray-700 py-2 px-4 rounded-lg text-sm hover:bg-gray-200 transition-colors">🍌 Banana</button>
                                <button onclick="quickNutritionSearch('frango grelhado')" class="bg-gray-100 text-gray-700 py-2 px-4 rounded-lg text-sm hover:bg-gray-200 transition-colors">🍗 Frango</button>
                                <button onclick="quickNutritionSearch('arroz integral')" class="bg-gray-100 text-gray-700 py-2 px-4 rounded-lg text-sm hover:bg-gray-200 transition-colors">🍚 Arroz</button>
                                <button onclick="quickNutritionSearch('salmão')" class="bg-gray-100 text-gray-700 py-2 px-4 rounded-lg text-sm hover:bg-gray-200 transition-colors">🐟 Salmão</button>
                            </div>
                        </div>
                    </div>

                    <!-- Nutrition Results -->
                    <div class="bg-neutral rounded-2xl p-8 card-shadow">
                        <h3 class="text-xl font-semibold text-dark mb-6">Análise Nutricional</h3>
                        <div id="nutrition-results">
                            <div class="text-center text-gray-500 py-12">
                                <div class="text-6xl mb-4">🍽️</div>
                                <p>Digite um alimento para ver a análise completa via Servlet</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Daily Log -->
                <div class="mt-12 bg-neutral rounded-2xl p-8 card-shadow">
                    <div class="flex justify-between items-center mb-6">
                        <h3 class="text-xl font-semibold text-dark">Registro Diário</h3>
                        <div class="text-sm text-gray-500" id="nutrition-date"></div>
                    </div>
                    <div id="daily-nutrition-log" class="space-y-4">
                        <!-- Will be populated by JavaScript -->
                    </div>
                    <div class="mt-6 grid md:grid-cols-4 gap-4 text-center">
                        <div class="bg-white p-4 rounded-lg">
                            <div class="text-2xl font-bold text-primary" id="total-calories">0</div>
                            <div class="text-sm text-gray-600">Calorias</div>
                        </div>
                        <div class="bg-white p-4 rounded-lg">
                            <div class="text-2xl font-bold text-blue-500" id="total-protein">0g</div>
                            <div class="text-sm text-gray-600">Proteínas</div>
                        </div>
                        <div class="bg-white p-4 rounded-lg">
                            <div class="text-2xl font-bold text-yellow-500" id="total-carbs">0g</div>
                            <div class="text-sm text-gray-600">Carboidratos</div>
                        </div>
                        <div class="bg-white p-4 rounded-lg">
                            <div class="text-2xl font-bold text-red-500" id="total-fat">0g</div>
                            <div class="text-sm text-gray-600">Gorduras</div>
                        </div>
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