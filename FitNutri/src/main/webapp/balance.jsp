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
                        <a href="index.html" class="text-2xl font-bold text-primary hover:text-secondary transition-colors">
                            💪 FitNutri AI
                        </a>
                    </div>
                </div>
                <div class="hidden md:block">
                    <div class="ml-10 flex items-baseline space-x-4">
                        <a href="index.html" class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors">Início</a>
                        <a href="goal-setup.html" class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors">Metas</a>
                        <a href="nutrition.html" class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors">Nutrição</a>
                        <a href="activity.html" class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors">Atividades</a>
                        <a href="balance.html" class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors">Balanço</a>
                        <a href="ai-recommendations.html" class="nav-link text-dark hover:text-primary px-3 py-2 rounded-md text-sm font-medium transition-colors">IA Coach</a>
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
                <a href="index.html" class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left">Início</a>
                <a href="goal-setup.html" class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left">Metas</a>
                <a href="nutrition.html" class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left">Nutrição</a>
                <a href="activity.html" class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left">Atividades</a>
                <a href="balance.html" class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left">Balanço</a>
                <a href="ai-recommendations.html" class="nav-link block text-dark hover:text-primary px-3 py-2 rounded-md text-base font-medium w-full text-left">IA Coach</a>
            </div>
        </div>
    </nav>

    <!-- Balance Engine Page -->
    <div id="balance-engine-page" class="page active pt-16">
        <div class="min-h-screen bg-white">
            <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-20">
                <div class="text-center mb-12">
                    <h1 class="text-3xl md:text-4xl font-bold text-dark mb-4">⚖️ Motor de Balanço Calórico</h1>
                    <p class="text-lg text-gray-600">Servlet que cruza alimentação x gasto calórico em tempo real</p>
                </div>
                
                <!-- Real-time Balance -->
                <div class="bg-gradient-to-r from-primary to-accent rounded-2xl p-8 text-white mb-8">
                    <div class="text-center">
                        <h2 class="text-2xl font-bold mb-4">Balanço Calórico Atual</h2>
                        <div class="grid md:grid-cols-3 gap-8">
                            <div>
                                <div class="text-4xl font-bold mb-2" id="consumed-calories">1,247</div>
                                <div class="text-sm opacity-90">Calorias Consumidas</div>
                            </div>
                            <div>
                                <div class="text-4xl font-bold mb-2" id="burned-calories">423</div>
                                <div class="text-sm opacity-90">Calorias Queimadas</div>
                            </div>
                            <div>
                                <div class="text-4xl font-bold mb-2" id="net-balance">+824</div>
                                <div class="text-sm opacity-90">Balanço Líquido</div>
                            </div>
                        </div>
                        <div class="mt-6">
                            <div class="bg-white bg-opacity-20 rounded-full h-4 mb-2">
                                <div id="balance-bar" class="bg-white rounded-full h-4 transition-all duration-500" style="width: 62%"></div>
                            </div>
                            <div class="text-sm opacity-90">Meta diária: 2000 kcal</div>
                        </div>
                    </div>
                </div>

                <div class="grid lg:grid-cols-2 gap-8">
                    <!-- Balance Analysis -->
                    <div class="bg-neutral rounded-2xl p-8 card-shadow">
                        <h3 class="text-xl font-semibold text-dark mb-6">Análise Inteligente</h3>
                        <div class="space-y-6">
                            <!-- Goal Progress -->
                            <div>
                                <div class="flex justify-between text-sm mb-2">
                                    <span>Progresso da Meta</span>
                                    <span id="goal-progress-text">62% do objetivo diário</span>
                                </div>
                                <div class="w-full bg-gray-200 rounded-full h-3">
                                    <div id="goal-progress-bar" class="bg-primary h-3 rounded-full transition-all duration-500" style="width: 62%"></div>
                                </div>
                            </div>

                            <!-- Macro Balance -->
                            <div>
                                <h4 class="font-semibold text-dark mb-3">Distribuição de Macros</h4>
                                <div class="space-y-3">
                                    <div class="flex justify-between items-center">
                                        <span class="text-sm">Proteínas</span>
                                        <div class="flex items-center">
                                            <div class="w-20 bg-gray-200 rounded-full h-2 mr-3">
                                                <div class="bg-blue-500 h-2 rounded-full" style="width: 75%"></div>
                                            </div>
                                            <span class="text-sm font-medium">75%</span>
                                        </div>
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <span class="text-sm">Carboidratos</span>
                                        <div class="flex items-center">
                                            <div class="w-20 bg-gray-200 rounded-full h-2 mr-3">
                                                <div class="bg-yellow-500 h-2 rounded-full" style="width: 55%"></div>
                                            </div>
                                            <span class="text-sm font-medium">55%</span>
                                        </div>
                                    </div>
                                    <div class="flex justify-between items-center">
                                        <span class="text-sm">Gorduras</span>
                                        <div class="flex items-center">
                                            <div class="w-20 bg-gray-200 rounded-full h-2 mr-3">
                                                <div class="bg-red-500 h-2 rounded-full" style="width: 45%"></div>
                                            </div>
                                            <span class="text-sm font-medium">45%</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Predictions -->
                            <div class="bg-blue-50 p-4 rounded-lg">
                                <h4 class="font-semibold text-blue-800 mb-2">🔮 Previsões IA</h4>
                                <div class="space-y-2 text-sm text-blue-700">
                                    <p>• Com o ritmo atual, você atingirá 1,850 kcal hoje</p>
                                    <p>• Déficit previsto: -150 kcal (ideal para sua meta)</p>
                                    <p>• Tempo estimado para meta: 8 semanas</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Weekly Trends -->
                    <div class="bg-neutral rounded-2xl p-8 card-shadow">
                        <h3 class="text-xl font-semibold text-dark mb-6">Tendências Semanais</h3>
                        <div class="space-y-6">
                            <!-- Chart Simulation -->
                            <div>
                                <h4 class="font-semibold text-dark mb-3">Balanço Calórico (7 dias)</h4>
                                <div class="flex items-end space-x-2 h-32 mb-2">
                                    <div class="bg-success rounded-t flex-1 h-20" title="Segunda: -200 kcal"></div>
                                    <div class="bg-warning rounded-t flex-1 h-16" title="Terça: +100 kcal"></div>
                                    <div class="bg-success rounded-t flex-1 h-24" title="Quarta: -150 kcal"></div>
                                    <div class="bg-success rounded-t flex-1 h-28" title="Quinta: -300 kcal"></div>
                                    <div class="bg-warning rounded-t flex-1 h-12" title="Sexta: +250 kcal"></div>
                                    <div class="bg-danger rounded-t flex-1 h-8" title="Sábado: +400 kcal"></div>
                                    <div class="bg-success rounded-t flex-1 h-32" title="Domingo: -150 kcal"></div>
                                </div>
                                <div class="flex justify-between text-xs text-gray-500">
                                    <span>Seg</span>
                                    <span>Ter</span>
                                    <span>Qua</span>
                                    <span>Qui</span>
                                    <span>Sex</span>
                                    <span>Sáb</span>
                                    <span>Dom</span>
                                </div>
                                <div class="flex justify-center space-x-4 mt-4 text-xs">
                                    <div class="flex items-center">
                                        <div class="w-3 h-3 bg-success rounded mr-1"></div>
                                        <span>Déficit</span>
                                    </div>
                                    <div class="flex items-center">
                                        <div class="w-3 h-3 bg-warning rounded mr-1"></div>
                                        <span>Equilibrio</span>
                                    </div>
                                    <div class="flex items-center">
                                        <div class="w-3 h-3 bg-danger rounded mr-1"></div>
                                        <span>Superávit</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Weekly Stats -->
                            <div class="grid grid-cols-2 gap-4">
                                <div class="text-center">
                                    <div class="text-2xl font-bold text-success">-1,050</div>
                                    <div class="text-sm text-gray-600">Déficit Semanal</div>
                                </div>
                                <div class="text-center">
                                    <div class="text-2xl font-bold text-primary">-0.3kg</div>
                                    <div class="text-sm text-gray-600">Perda Estimada</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="mt-8 bg-neutral rounded-2xl p-8 card-shadow">
                    <h3 class="text-xl font-semibold text-dark mb-6">Ações Rápidas</h3>
                    <div class="grid md:grid-cols-4 gap-4">
                        <button onclick="showPage('nutrition-analyzer')" class="bg-white p-4 rounded-lg text-center hover:shadow-md transition-shadow">
                            <div class="text-2xl mb-2">🥗</div>
                            <div class="font-medium text-dark">Adicionar Alimento</div>
                        </button>
                        <button onclick="showPage('activity-tracker')" class="bg-white p-4 rounded-lg text-center hover:shadow-md transition-shadow">
                            <div class="text-2xl mb-2">🏃</div>
                            <div class="font-medium text-dark">Registrar Atividade</div>
                        </button>
                        <button onclick="updateBalance()" class="bg-white p-4 rounded-lg text-center hover:shadow-md transition-shadow">
                            <div class="text-2xl mb-2">🔄</div>
                            <div class="font-medium text-dark">Atualizar Dados</div>
                        </button>
                        <button onclick="showPage('ai-recommendations')" class="bg-white p-4 rounded-lg text-center hover:shadow-md transition-shadow">
                            <div class="text-2xl mb-2">🤖</div>
                            <div class="font-medium text-dark">Ver Recomendações</div>
                        </button>
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
                        <li><a href="goal-setup.html" class="text-gray-300 hover:text-primary transition-colors">Goal Setup</a></li>
                        <li><a href="nutrition.html" class="text-gray-300 hover:text-primary transition-colors">Nutrition Analyzer</a></li>
                        <li><a href="activity.html" class="text-gray-300 hover:text-primary transition-colors">Activity Tracker</a></li>
                        <li><a href="balance.html" class="text-gray-300 hover:text-primary transition-colors">Balance Engine</a></li>
                        <li><a href="ai-recommendations.html" class="text-gray-300 hover:text-primary transition-colors">AI Coach</a></li>
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