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
                        <a href="groq-chat.jsp" class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors">IA Coach</a>
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
                <a href="groq-chat.jsp" class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left">IA Coach</a>
            </div>
        </div>
    </nav>

    <!-- Goal Setup Page -->
    <div id="goal-setup-page" class="page active pt-16">
        <div class="min-h-screen bg-neutral">
            <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-20">
                <div class="text-center mb-12">
                    <h1 class="text-3xl md:text-4xl font-bold text-dark mb-4">🎯 Configuração de Metas</h1>
                    <p class="text-lg text-gray-600">Servlet de definição de objetivos personalizados</p>
                </div>
                
                <div class="bg-white rounded-2xl p-8 card-shadow">
                    <div class="grid lg:grid-cols-2 gap-8">
                        <!-- Personal Info -->
                        <div>
                            <h3 class="text-xl font-semibold text-dark mb-6">Informações Pessoais</h3>
                            <div class="space-y-4">
                                <div class="grid grid-cols-2 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium text-dark mb-2">Idade</label>
                                        <input type="number" id="age" value="30" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-dark mb-2">Sexo</label>
                                        <select id="gender" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                            <option value="male">Masculino</option>
                                            <option value="female">Feminino</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="grid grid-cols-2 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium text-dark mb-2">Peso Atual (kg)</label>
                                        <input type="number" id="current-weight" value="75" step="0.1" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-dark mb-2">Altura (cm)</label>
                                        <input type="number" id="height" value="175" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                    </div>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-dark mb-2">Nível de Atividade</label>
                                    <select id="activity-level" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                        <option value="1.2">Sedentário (pouco ou nenhum exercício)</option>
                                        <option value="1.375">Levemente ativo (exercício leve 1-3 dias/semana)</option>
                                        <option value="1.55" selected>Moderadamente ativo (exercício moderado 3-5 dias/semana)</option>
                                        <option value="1.725">Muito ativo (exercício pesado 6-7 dias/semana)</option>
                                        <option value="1.9">Extremamente ativo (exercício muito pesado, trabalho físico)</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Goals -->
                        <div>
                            <h3 class="text-xl font-semibold text-dark mb-6">Objetivos</h3>
                            <div class="space-y-4">
                                <div>
                                    <label class="block text-sm font-medium text-dark mb-2">Meta Principal</label>
                                    <div class="space-y-2">
                                        <label class="flex items-center p-3 border rounded-lg cursor-pointer hover:bg-gray-50">
                                            <input type="radio" name="goal" value="weight-loss" class="mr-3" checked>
                                            <div>
                                                <div class="font-medium">🔥 Perder Peso</div>
                                                <div class="text-sm text-gray-600">Déficit calórico para queima de gordura</div>
                                            </div>
                                        </label>
                                        <label class="flex items-center p-3 border rounded-lg cursor-pointer hover:bg-gray-50">
                                            <input type="radio" name="goal" value="maintenance" class="mr-3">
                                            <div>
                                                <div class="font-medium">⚖️ Manter Peso</div>
                                                <div class="text-sm text-gray-600">Equilíbrio calórico para manutenção</div>
                                            </div>
                                        </label>
                                        <label class="flex items-center p-3 border rounded-lg cursor-pointer hover:bg-gray-50">
                                            <input type="radio" name="goal" value="muscle-gain" class="mr-3">
                                            <div>
                                                <div class="font-medium">💪 Ganhar Massa</div>
                                                <div class="text-sm text-gray-600">Superávit calórico para hipertrofia</div>
                                            </div>
                                        </label>
                                    </div>
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-dark mb-2">Peso Meta (kg)</label>
                                    <input type="number" id="target-weight" value="70" step="0.1" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                </div>
                                <div>
                                    <label class="block text-sm font-medium text-dark mb-2">Prazo (semanas)</label>
                                    <input type="number" id="timeline" value="12" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="mt-8 pt-8 border-t">
                        <button onclick="calculateGoals()" class="w-full bg-primary text-white py-4 rounded-lg font-semibold hover:bg-secondary transition-colors">
                            <span id="calc-btn-text">🧮 Calcular Metas Personalizadas</span>
                            <div id="calc-loading" class="hidden flex items-center justify-center">
                                <div class="loading w-5 h-5 border-2 border-white border-t-transparent rounded-full mr-2"></div>
                                Calculando...
                            </div>
                        </button>
                    </div>
                </div>

                <!-- Results -->
                <div id="goal-results" class="mt-8 hidden">
                    <!-- Will be populated by JavaScript -->
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
                        <li><a href="groq-chat.jsp" class="text-gray-300 hover:text-primary transition-colors">AI Coach</a></li>
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