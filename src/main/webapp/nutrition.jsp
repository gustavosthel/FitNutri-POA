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

    <!-- Nutrition Analyzer Page -->
    <div id="nutrition-analyzer-page" class="page active pt-16">
        <div class="min-h-screen bg-white">
            <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-20">
                <!-- ... título mantido ... -->
                
                <div class="text-center mb-12">
                    <h1 class="text-3xl md:text-4xl font-bold text-dark mb-4">🥗 Analisador Nutricional</h1>
                    <p class="text-lg text-gray-600">Servlet de processamento nutricional com base de dados interna</p>
                </div>
                
                <form action="nutrition-analyzer" method="POST">
                    <div class="grid lg:grid-cols-2 gap-8">
                        <!-- Food Search -->
                        <div class="bg-neutral rounded-2xl p-8 card-shadow">
                            <h3 class="text-xl font-semibold text-dark mb-6">Buscar Alimento</h3>
                            <div class="space-y-4">
                                <div>
                                    <label class="block text-sm font-medium text-dark mb-2">Nome do Alimento</label>
                                    <input type="text" name="food" value="${param.food}" placeholder="Ex: 100g peito de frango grelhado" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent" required>
                                </div>
                                <div class="grid grid-cols-2 gap-4">
                                    <div>
                                        <label class="block text-sm font-medium text-dark mb-2">Quantidade</label>
                                        <input type="number" name="quantity" value="${empty param.quantity ? '100' : param.quantity}" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent" required>
                                    </div>
                                    <div>
                                        <label class="block text-sm font-medium text-dark mb-2">Unidade</label>
                                        <select name="unit" class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-primary focus:border-transparent">
                                            <option value="g" ${param.unit == 'g' ? 'selected' : ''}>gramas (g)</option>
                                            <option value="ml" ${param.unit == 'ml' ? 'selected' : ''}>mililitros (ml)</option>
                                            <option value="unit" ${param.unit == 'unit' ? 'selected' : ''}>unidade</option>
                                            <option value="cup" ${param.unit == 'cup' ? 'selected' : ''}>xícara</option>
                                            <option value="tbsp" ${param.unit == 'tbsp' ? 'selected' : ''}>colher de sopa</option>
                                        </select>
                                    </div>
                                </div>
                                <button type="submit" class="w-full bg-primary text-white py-3 rounded-lg font-semibold hover:bg-secondary transition-colors">
                                    🔍 Processar com Servlet
                                </button>
                            </div>
                        </div>

                        <!-- Nutrition Results -->
                        <div class="bg-neutral rounded-2xl p-8 card-shadow">
                            <h3 class="text-xl font-semibold text-dark mb-6">Análise Nutricional</h3>
                            <div id="nutrition-results">
                                <c:choose>
                                    <c:when test="${not empty nutritionData}">
                                        <div class="fade-in">
                                            <div class="text-center mb-6">
                                                <h4 class="text-2xl font-bold text-primary mb-2">${nutritionData.name}</h4>
                                                <div class="text-sm text-gray-600">${nutritionData.quantity}${nutritionData.unit}</div>
                                                <div class="text-4xl font-bold text-dark mt-2">${nutritionData.calories} kcal</div>
                                            </div>
                                            
                                            <div class="grid grid-cols-2 gap-4 mb-6">
                                                <div class="bg-blue-50 p-4 rounded-lg text-center">
                                                    <div class="text-2xl font-bold text-blue-600">${nutritionData.protein}g</div>
                                                    <div class="text-sm text-blue-800">Proteínas</div>
                                                </div>
                                                <div class="bg-yellow-50 p-4 rounded-lg text-center">
                                                    <div class="text-2xl font-bold text-yellow-600">${nutritionData.carbs}g</div>
                                                    <div class="text-sm text-yellow-800">Carboidratos</div>
                                                </div>
                                                <div class="bg-red-50 p-4 rounded-lg text-center">
                                                    <div class="text-2xl font-bold text-red-600">${nutritionData.fat}g</div>
                                                    <div class="text-sm text-red-800">Gorduras</div>
                                                </div>
                                                <div class="bg-green-50 p-4 rounded-lg text-center">
                                                    <div class="text-2xl font-bold text-green-600">${nutritionData.fiber}g</div>
                                                    <div class="text-sm text-green-800">Fibras</div>
                                                </div>
                                            </div>
                                            
                                            <div class="space-y-2 text-sm mb-6">
                                                <div class="flex justify-between">
                                                    <span>Açúcares:</span>
                                                    <span class="font-medium">${nutritionData.sugar}g</span>
                                                </div>
                                                <div class="flex justify-between">
                                                    <span>Sódio:</span>
                                                    <span class="font-medium">${nutritionData.sodium}mg</span>
                                                </div>
                                                <div class="flex justify-between">
                                                    <span>Potássio:</span>
                                                    <span class="font-medium">${nutritionData.potassium}mg</span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:when test="${not empty error}">
                                        
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center text-gray-500 py-12">
                                            <div class="text-6xl mb-4">🍽️</div>
                                            <p>Digite um alimento para ver a análise completa via Servlet</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </form>

                <!-- ... daily log mantido ... -->
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
    
    <style>
    .loading {
        animation: spin 1s linear infinite;
    }
    
    @keyframes spin {
        from { transform: rotate(0deg); }
        to { transform: rotate(360deg); }
    }
    
    .fade-in {
        animation: fadeIn 0.5s ease-in;
    }
    
    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }
</body>
</html>